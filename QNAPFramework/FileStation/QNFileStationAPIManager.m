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

@implementation QNFileStationAPIManager
- (instancetype)initWithBaseURL:(NSString *)baseURL{
    if((self = [super initWithBaseURL:baseURL])){
        self.rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:self.baseURL]];
        self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
        [self.rkObjectManager setAcceptHeaderWithMIMEType:@"text/xml"];
        [RKMIMETypeSerialization registerClass:[RKXMLReaderSerialization class] forMIMEType:@"text/xml"];
    }
    return self;
}
#pragma mark - FileStation API
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNFileLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure{
    
    //mapping the first layer
    RKEntityMapping *responseMapping = [QNFileStationMapping mappingForLogin];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
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
                                     if(success!=nil){
                                         NSArray *allQNLogin = [QNFileLogin MR_findAllInContext:self.rkObjectManager.managedObjectStore.mainQueueManagedObjectContext];
                                         QNFileLogin *targetLogin = [allQNLogin objectAtIndex:0];
                                         success(operation, mappingResult, targetLogin);
                                         DDLogInfo(@"fetching login information successfully...Sid: %@", targetLogin.authSid);
                                     }
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
                                     if(failure!=nil)
                                         failure(operation, error);
                                     DDLogError(@"HTTP Request Error! %@", error);
                                 }];
}
@end
