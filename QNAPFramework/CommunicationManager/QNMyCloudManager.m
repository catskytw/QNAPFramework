//
//  QNMyCloudManager.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMyCloudManager.h"
#import <Expecta/Expecta.h>
#import "QNMyCloudMapping.h"
#import "QNAPCommunicationManager.h"

static const int ddLogLevel = LOG_LEVEL_VERBOSE;
@implementation QNMyCloudManager

#pragma mark - LifeCycle
- (id)initWithMyCloudBaseURL:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret{
    if(self = [super init]){
        self.baseURL = baseURL;
        self.clientId = clientId;
        self.clientSecret = clientSecret;
    }
    return self;
}

#pragma mark - OAuth
- (void)fetchOAuthToken:(void(^)(AFOAuthCredential *credential))success
                       withFailureBlock:(void(^)(NSError *error))failure{
    //TODO fetching token to see if
    AFOAuth2Client *oauthClient = [AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:self.baseURL]
                                                           clientID:self.clientId
                                                             secret:self.clientSecret];
    [oauthClient authenticateUsingOAuthWithPath:@"/oauth/token"
                                     parameters:@{@"grant_type":kAFOAuthClientCredentialsGrantType}
                                        success:^(AFOAuthCredential *credential){
                                            [AFOAuthCredential storeCredential:credential withIdentifier:@"myCloudCredential"];
                                            self.rkObjectManager = [[RKObjectManager alloc] initWithHTTPClient:oauthClient];
                                            self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
                                            if(success)
                                                success(credential);
                                        }
                                        failure:^(NSError *error){
                                            if(failure)
                                                failure(error);
                                        }];
}

#pragma mark - MyCloudAPI V1.1
- (void)readMyInformation:(void(^)(RKObjectRequestOperation *operaion, RKMappingResult *mappingResult))success withFailiureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure{
    //self.rkObjectManager不可為nil
    EXP_expect(self.rkObjectManager).notTo.beNil();
    
    RKEntityMapping *mapping = [QNMyCloudMapping mappingForUser];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"result"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];
    [self.rkObjectManager getObjectsAtPath:@"v1.1/me"
                              parameters:nil
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                     if(success!=nil){
                                     }
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
                                     if(failure!=nil)
                                         failure(operation, error);
                                     DDLogError(@"HTTP Request Error! %@", error);
                                 }];
}

@end
