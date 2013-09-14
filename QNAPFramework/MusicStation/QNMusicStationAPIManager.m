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
    RKEntityMapping *folderMapping = [QNMusicMapping mappingForFolder];
    [folderMapping setIdentificationAttributes:@[@"linkID"]];
    
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
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"act":@"list",
                                       @"type":@"folder",
                                       @"sid":[QNAPCommunicationManager share].sidForMultimedia
                                       }];
    if(folderId)
        [parameters setValue:folderId forKey:@"Linkid"];
    
    [self.weakRKObjectManager getObject:nil
                                   path:@"musicstation/api/medialist_api.php"
                             parameters:parameters
                                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                    if([[mappingResult firstObject] isKindOfClass:[QNError class]]){
                                        DDLogError(@"error code: %@", [(QNError *)[mappingResult firstObject] errorcode]);
                                        failure(operation, (NSError *)mappingResult);
                                    }
                                    else{
                                        DDLogVerbose(@"get folder list %@", [mappingResult firstObject]);
                                        success(operation, mappingResult);
                                    }
                                }
                                failure:^(RKObjectRequestOperation *operation, NSError *error){
                                    failure(operation, error);
                                }];

}

@end
