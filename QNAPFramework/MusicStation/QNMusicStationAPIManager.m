//
//  QNMusicStationAPIManager.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/13.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMusicStationAPIManager.h"
#import "QNAPCommunicationManager.h"
#import "QNMultimediaLogin.h"
#import "QNError.h"

@implementation QNMusicStationAPIManager

- (id)initWithBaseURL:(NSString *)baseURL{
    if((self = [super initWithBaseURL:baseURL])){
        self.weakRKObjectManager = [QNAPCommunicationManager share].weakRKObjectManager;
    }
    return self;
}

- (void)loginForMultimediaSid:(NSString *)account withPassword:(NSString *)password withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    
    RKDynamicMapping *dynamicMapping = [QNMusicMapping dynamicMappingForMultiMediaLogin];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dynamicMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"QDocRoot.datas.data"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.weakRKObjectManager addResponseDescriptor:responseDescriptor];
    NSDictionary *parameters = @{@"act":@"login",
                          @"id":account,
                          @"password":password
                          };
    [self.weakRKObjectManager getObject:nil
                                   path:@"musicstation/api/as_login_api.php"
                             parameters:parameters
                                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                    QNMultimediaLogin *mLogin = (QNMultimediaLogin *)[mappingResult firstObject];
                                    DDLogVerbose(@"multimedia login success %@", mLogin.sid);
                                    if(mLogin.sid)
                                        [QNAPCommunicationManager share].sidForMultimedia = [NSString stringWithString: mLogin.sid];
                                    success(operation, mappingResult);
                                }
                                failure:^(RKObjectRequestOperation *operation, NSError *error){
                                    failure(operation, error);
                                }];
    
}

- (void)getFolderListWithFolderID:(NSString* )folderId withSuccessBlock:(QNSuccessBlock)success withFaliureBlock:(QNFailureBlock)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"folder",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia
                                       }];
    [self musicStationAPIProtoTypeWithProtoTypeId:folderId
                                   withParameters:parameters
                                 withSuccessBlock:success
                                 withFailureBlock:failure];
}

- (void)getSongListWithArtistId:(NSString *)artistId withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"artist",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia
                                       }];
    [self musicStationAPIProtoTypeWithProtoTypeId:artistId
                                   withParameters:parameters
                                 withSuccessBlock:success
                                 withFailureBlock:failure];
}

- (void)getAlbumListWithAlbumId:(NSString *)albumId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"album",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia,
                                       @"pagesize":@(pageSize),
                                       @"currpage":@(currPage)
                                       }];
    [self musicStationAPIProtoTypeWithProtoTypeId:albumId
                                   withParameters:parameters
                                 withSuccessBlock:success
                                 withFailureBlock:failure];
}

- (void)getGenreListWithGenreId:(NSString *)genreId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"genre",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia,
                                       @"pagesize":@(pageSize),
                                       @"currpage":@(currPage)
                                       }];
    [self musicStationAPIProtoTypeWithProtoTypeId:genreId
                                   withParameters:parameters
                                 withSuccessBlock:success
                                 withFailureBlock:failure];

}

- (void)getRecentListWithPageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"recent",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia,
                                       @"pagesize":@(pageSize),
                                       @"currpage":@(currPage)
                                       }];
    [self musicStationAPIProtoTypeWithProtoTypeId:nil
                                   withParameters:parameters
                                 withSuccessBlock:success
                                 withFailureBlock:failure];
}

#pragma mark - PrivateMethod

- (void)musicStationAPIProtoTypeWithProtoTypeId:(NSString *)protoTypeId withParameters:(NSDictionary *)parameters withSuccessBlock:(QNSuccessBlock) success withFailureBlock:(QNFailureBlock) failure{
    RKEntityMapping *folderMapping = [QNMusicMapping mappingForFolder];
    
    RKEntityMapping *errorMapping = [QNMusicMapping mappingForError];
    [errorMapping setIdentificationAttributes:@[@"status", @"errorcode"]];
    
    RKDynamicMapping *dynamicMapping = [QNMusicMapping dynamicMappingWithCorrectMapping:folderMapping
                                                               withErrorResponseMapping:errorMapping
                                                                           withErrorKey:@"status"
                                                                            isXMLParser:YES];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dynamicMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"QDocRoot"
                                                                                       statusCodes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(RKStatusCodeClassSuccessful, RKStatusCodeClassServerError+100)]];
    [self.weakRKObjectManager addResponseDescriptor:responseDescriptor];

    if(protoTypeId)
        [parameters setValue:protoTypeId forKey:@"Linkid"];
    
    [self.weakRKObjectManager getObject:nil
                                   path:@"musicstation/api/medialist_api.php"
                             parameters:parameters
                                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                    if([[mappingResult firstObject] isKindOfClass:[QNError class]]){
                                        DDLogError(@"error code: %@", [(QNError *)[mappingResult firstObject] errorcode]);
                                        failure(operation, (NSError *)mappingResult);
                                    }
                                    else{
                                        success(operation, mappingResult);
                                    }
                                }
                                failure:^(RKObjectRequestOperation *operation, NSError *error){
                                    failure(operation, error);
                                }];
}

@end
