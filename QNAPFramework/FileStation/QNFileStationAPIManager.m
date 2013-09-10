//
//  QNFileStationAPIManager.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNFileStationAPIManager.h"

@implementation QNFileStationAPIManager
#pragma mark - FileStation API
//- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure{
//    
//    //mapping the first layer
//    RKEntityMapping *responseMapping = [[QNFileStationCoreDataMappingModule shareModule] loginObjectMapping:self.objectManager.managedObjectStore];
//    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
//                                                                                            method:RKRequestMethodGET
//                                                                                       pathPattern:nil
//                                                                                           keyPath:@"QDocRoot"
//                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    [self.objectManager addResponseDescriptor:responseDescriptor];
//    NSDictionary *parameters = @{@"pwd":password, @"user":account, @"service":@"1"};
//    
//    [self.objectManager getObjectsAtPath:@"cgi-bin/authLogin.cgi"
//                              parameters:parameters
//                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
//                                     //fetching the result from coredata
//                                     if(success!=nil){
//                                         NSArray *allQNLogin = [QNLogin MR_findAllInContext:self.objectManager.managedObjectStore.mainQueueManagedObjectContext];
//                                         QNLogin *targetLogin = [allQNLogin objectAtIndex:0];
//                                         success(operation, mappingResult, targetLogin);
//                                         DDLogInfo(@"fetching login information successfully...Sid: %@", targetLogin.authSid);
//                                     }
//                                 }
//                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
//                                     if(failure!=nil)
//                                         failure(operation, error);
//                                     DDLogError(@"HTTP Request Error! %@", error);
//                                 }];
//    
//}
@end
