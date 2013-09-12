//
//  QNFileStationAPIManager.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNFileStationAPIManager.h"
#import "QNFileStationMapping.h"
#import "QNAPCommunicationManager.h"
#import "RKXMLReaderSerialization.h"
#import "QNAPFramework.h"
#import "RKObjectManager_DownloadProgress.h"

@implementation QNFileStationAPIManager
- (instancetype)initWithBaseURL:(NSString *)baseURL{
    if((self = [super initWithBaseURL:baseURL])){
        self.baseURL = baseURL;
        self.rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:self.baseURL]];
        self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
        [self.rkObjectManager setAcceptHeaderWithMIMEType:@"text/xml"];
        [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"text/xml"];        
    }
    return self;
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
    RKDynamicMapping *dynamicMapping = [QNFileStationMapping dynamicMappingWithCorrectMapping:responseMapping withErrorResponseMapping:errorMapping];
    
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
    //h ttp://changenas.myqnapcloud.com:8080/cgi-bin/filemanager/utilRequest.cgi?func=download&sid=6nmadgva&isfolder=0&source_path=/Public&source_file=1.mov&source_total=1
    //h ttp://IP:8080/cgi-bin/filemanager/utilRequest.cgi?func=download&sid=xxxx&isfolder=0&source_path=/Public&source_file=test.txt&source_file=test2.txt&source_total=2
    //two source_file? WTF.
    if(!filePath || !fileName)
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
                            success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){}
                            failure:^(RKObjectRequestOperation *operation, NSError *error){}
                         inProgress:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead){
                             inProgress(totalBytesRead, totalBytesExpectedToRead);
                         }];
}
@end
