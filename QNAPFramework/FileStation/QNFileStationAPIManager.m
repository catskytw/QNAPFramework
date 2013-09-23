//
//  QNFileStationAPIManager.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNFileStationAPIManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AFNetworking/AFHTTPClient.h>
#import "QNFileStationMapping.h"
#import "QNAPCommunicationManager.h"
#import "RKXMLReaderSerialization.h"
#import "QNAPFramework.h"
#import "RKObjectManager_DownloadProgress.h"
#import "QNSearchResponse.h"

@class RKNSJSONSerialization;

@implementation QNFileStationAPIManager
@synthesize authSid = _authSid;

- (id)initWithBaseURL:(NSString *)baseURL{
    if((self = [super initWithBaseURL:baseURL])){
        self.baseURL = baseURL;
        [self setting];
    }
    return self;
}

- (void)setting{
    self.rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:self.baseURL]];
    self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
    [self.rkObjectManager setAcceptHeaderWithMIMEType:@"text/xml"];
    [self.rkObjectManager setAcceptHeaderWithMIMEType:@"text/html"]; //video/quicktime
    [self.rkObjectManager setAcceptHeaderWithMIMEType:@"video/quicktime"];
    [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"text/xml"];
    [RKMIMETypeSerialization registerClass:[RKNSJSONSerialization class] forMIMEType:@"text/html"];
}
#pragma mark - FileStation API
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNFileLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, QNFileLoginError *loginError))failure{
    
    if(!self.rkObjectManager){
        DDLogError(@"FileStationManager is nil!");
        return;
    }
    //mapping the first layer
    RKEntityMapping *responseMapping = [QNFileStationMapping mappingForLogin];
    RKEntityMapping *errorMapping = [QNFileStationMapping mappingForLoginError];
    RKDynamicMapping *dynamicMapping = [QNFileStationMapping dynamicMappingLoginWithCorrectMapping:responseMapping withErrorResponseMapping:errorMapping];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:dynamicMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"QDocRoot"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];
    NSDictionary *parameters = @{@"pwd":password, @"user":account, @"service":@"1"};
    [self.rkObjectManager getObjectsAtPath:@"cgi-bin/authLogin.cgi"
                              parameters:parameters
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                     //fetching the result from coredata
                                     id resultObject = [mappingResult firstObject];
                                     [QNMappingProtoType dynamicMappingResult:resultObject];
                                     if([NSStringFromClass([resultObject class]) isEqualToString:@"QNFileLogin"]){
                                         NSArray *allQNLogin = [QNFileLogin MR_findAllInContext:self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext];
                                         QNFileLogin *targetLogin = allQNLogin[0];
                                         _authSid = [NSString stringWithString:targetLogin.authSid];
                                         [QNAPCommunicationManager share].sidForQTS = _authSid;
                                         DDLogInfo(@"fetching login information successfully...Sid: %@", targetLogin.authSid);
                                         
                                         if(success){
                                             success(operation, mappingResult, targetLogin);
                                         }
                                     }else{ //如果不是QNFileLogin, 那必定是QNFileLoginError
                                         if(failure)
                                             failure(operation, resultObject);
                                     }
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
                                     QNFileLoginError *loginError = [QNFileLoginError MR_createEntity];
                                     [loginError setErrorValue:[error localizedDescription]];
                                     if(failure)
                                         failure(operation, loginError);
                                     DDLogError(@"HTTP Request Error! %@", error);
                                 }];
}

- (void)downloadFileWithFilePath:(NSString *)filePath withFileName:(NSString *)fileName isFolder:(BOOL)isFolder withRange:(NSRange *)fileRange withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure withInProgressBlock:(void(^)(long long totalBytesRead, long long totalBytesExpectedToRead))inProgress{
    /**
     *http://changenas.myqnapcloud.com:8080/cgi-bin/filemanager/utilRequest.cgi?func=download&sid=6nmadgva&isfolder=0&source_path=/Public&source_file=1.mov&source_total=1
     *http://IP:8080/cgi-bin/filemanager/utilRequest.cgi?func=download&sid=xxxx&isfolder=0&source_path=/Public&source_file=test.txt&source_file=test2.txt&source_total=2
     *two source_file? WTF.
     *
     *maybe Using AOP concept here is better. TODO item.
     */
    if(!filePath || !fileName || !_authSid)
        return;
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:
                                       @{
                                       @"func":@"download",
                                       @"sid":_authSid,
                                       @"isfolder":@(isFolder),
                                       @"source_path":filePath,
                                       @"source_file":fileName,
                                       @"source_total":@"1"
                                       }];
    [self.rkObjectManager getObject:nil
                               path:@"cgi-bin/filemanager/utilRequest.cgi"
                         parameters:parameters
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                DDLogVerbose(@"downloadFile %@ successful!", fileName);
                                success(operation, mappingResult);
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                DDLogError(@"downloadFile %@ failure!", fileName);
                                failure(operation, error);
                            }
                         inProgress:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
                             inProgress(totalBytesRead, totalBytesExpectedToRead);
                         }];
}

- (void)thumbnailWithFile:(NSString *)fileName withPath:(NSString *)filePath withSuccessBlock:(void(^)(UIImage *image))success withFailureBlock:(void(^)(NSError *error))failure withInProgressBlock:(void(^)(NSUInteger receivedSize, long long expectedSize))inProgress{
    

    AFHTTPClient *client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:self.baseURL]];
    NSMutableURLRequest *request =[client requestWithMethod:@"GET"
                                                       path:@"cgi-bin/filemanager/utilRequest.cgi"
                                                 parameters:
                                   @{
                                   @"func":@"get_thumb",
                                   @"sid":_authSid,
                                   @"name":fileName,
                                   @"path":filePath,
                                   @"size":@"320"}
                                   ];
    [[SDWebImageManager sharedManager] downloadWithURL:[request URL]
                                               options:0
                                              progress:^(NSUInteger receivedSize, long long expectedSize){
                                                  inProgress(receivedSize, expectedSize);
                                              }
                                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished){
                                                 if(finished)
                                                     (image)?success(image):failure(error);
                                             }];
    
}

- (void)searchFiles:(NSString *)keyword withSourcePath:(NSString *)sourcePath withSortField:(QNFileSortType)sortType withLimitNumber:(NSUInteger)limit withStartIndex:(NSUInteger)startIndex isASC:(BOOL)isASC withSuccessBlock:(QNQNSearchResponseSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{

    RKEntityMapping * responseMapping = [QNFileStationMapping mappingForSearchFiles];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];

    NSDictionary *dic = @{@"func":@"search",
                          @"sid":_authSid,
                          @"keyword":keyword,
                          @"source_path":sourcePath,
                          @"dir":(isASC?@"ASC":@"DESC"),
                          @"start":@(startIndex),
                          @"limit":@(limit),
                          @"sort":[self convertQNFileSortType:sortType]
                          };
    
    [self.rkObjectManager getObject:nil
                               path:@"cgi-bin/filemanager/utilRequest.cgi"
                         parameters:dic
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                QNSearchResponse *response = (QNSearchResponse *)[mappingResult firstObject];
                                DDLogInfo(@"search files under %@: %i files", sourcePath, [response.relationship_QNSearchFileInfo count]);
                                success(operation, mappingResult, response);
                            }
                            failure:^(RKObjectRequestOperation *operation, NSError *error){
                                DDLogError(@"search file under %@ error: %@", sourcePath, error);
                                failure(operation, error);
                            }];
}

- (NSString *)convertQNFileSortType:(QNFileSortType)sortType{
    NSString *r = nil;
    switch (sortType) {
        case QNFileGroupSort:
            r = @"group";
            break;
        case QNFileModefiedTimeSort:
            r = @"mt";
            break;
        case QNFileOwnerSort:
            r = @"owner";
            break;
        case QNFilePrivilegeSort:
            r = @"privilege";
            break;
        case QNFileSizeSort:
            r = @"filesize";
            break;
        case QNFileTypeSort:
            r = @"filetype";
            break;
        default:
        case QNFileNameSort:
            r = @"filename";
            break;
    }
    return r;
}

- (void)clearThumbnailCache{
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
}

@end
