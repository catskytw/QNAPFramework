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
#import "User.h"
#import "CommonUser.h"

#define credentialIdentifier @"myCloudCredential"

int ddLogLevel = LOG_LEVEL_VERBOSE;
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
                                            [AFOAuthCredential storeCredential:credential withIdentifier:credentialIdentifier];
                                            self.rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:self.baseURL]];
                                            self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
                                            [self addingAccessTokenInHeader];
                                            //加入所有錯誤反應, including PUT, DELETE, POST, GET
                                            for (RKResponseDescriptor *errorDes in [self allErrorMessageResponseDescriptor]) {
                                                [self.rkObjectManager addResponseDescriptor:errorDes];
                                            }
                                            if(success)
                                                success(credential);
                                        }
                                        failure:^(NSError *error){
                                            if(failure)
                                                failure(error);
                                        }];
}

- (void)fetchOAuthToken:(NSString *)account withPassword:(NSString *)password withSuccessBlock:(void(^)(AFOAuthCredential *credential))success
       withFailureBlock:(void(^)(NSError *error))failure{
    AFOAuth2Client *oauthClient = [AFOAuth2Client clientWithBaseURL:[NSURL URLWithString:self.baseURL]
                                                           clientID:self.clientId
                                                             secret:self.clientSecret];
    [oauthClient authenticateUsingOAuthWithPath:@"/oauth/token"
                                       username:account
                                       password:password
                                          scope:nil
                                        success:^(AFOAuthCredential *credential){
                                            [AFOAuthCredential storeCredential:credential withIdentifier:credentialIdentifier];
                                            self.rkObjectManager = [RKObjectManager managerWithBaseURL:[NSURL URLWithString:self.baseURL]];
                                            self.rkObjectManager.managedObjectStore = [QNAPCommunicationManager share].objectManager;
                                            [self addingAccessTokenInHeader];
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
    if(!self.rkObjectManager)
        DDLogError(@"RKObjectManager is nil!");
    
    RKEntityMapping *mapping = [QNMyCloudMapping mappingForUser];
    //should be user_id
    mapping.identificationAttributes = @[@"first_name", @"last_name", @"email"];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:mapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"result"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];
    [self.rkObjectManager getObjectsAtPath:@"v1.1/me"
                              parameters:nil
                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                     DDLogVerbose(@"readMyInformation success");
                                     if(success!=nil)
                                         success(operation, mappingResult);
                                 }
                                 failure:^(RKObjectRequestOperation *operation, NSError *error){
                                     DDLogError(@"HTTP Request Error! %@", error);

                                     if(failure!=nil)
                                         failure(operation, error);
                                 }];
}

- (void)updateMyInformation:(NSDictionary *)userInfo withSuccessBlock:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success withFailureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failureBlock{
    if(!userInfo){
        DDLogError(@"update MyInformation fail caused by the giving a nil userInfo!");
        return;
    }
    User *user = [User MR_createEntity];
    [self settingValuesIntoEntity:user withInformationDic:userInfo];
    
    RKEntityMapping *responseMapping = [QNMyCloudMapping mappingForResponse];
    responseMapping.identificationAttributes = @[@"code", @"message"];
    RKObjectMapping *requestMapping = [RKObjectMapping requestMapping];
    [requestMapping addAttributeMappingsFromDictionary: [self allPropertyNames:user withInformationDic:userInfo]];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                            method:RKRequestMethodPUT
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping
                                                                                   objectClass:[User class]
                                                                                   rootKeyPath:nil
                                                                                        method:RKRequestMethodPUT];
    [self.rkObjectManager addRequestDescriptor:requestDescriptor];
    [self.rkObjectManager addResponseDescriptor:responseDescriptor];
    [self addingContentType];
    
    self.rkObjectManager.requestSerializationMIMEType=RKMIMETypeJSON;
    [self.rkObjectManager putObject:user
                                path:@"v1.1/me"
                          parameters:nil
                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                 DDLogVerbose(@"update myinformation success");
                             }
                             failure:^(RKObjectRequestOperation *operation, NSError *error){

                                 DDLogError(@"update myInformation failure: %@", error);
                             }];
}

- (void)listMyActivities{
    
}

#pragma mark - PrivateMethod
- (void)addingContentType{
    //"Content-Type" = "application/json; charset=UTF-8";
    [self.rkObjectManager.HTTPClient setDefaultHeader:@"Content-Type" value:@"application/json; charset=UTF-8"];
}
- (void)addingAccessTokenInHeader{
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier:credentialIdentifier];
    NSString *tokenString = [NSString stringWithFormat:@"Bearer %@", credential.accessToken];
    [self.rkObjectManager.HTTPClient setDefaultHeader:@"Authorization" value:tokenString];
}

- (BOOL)validateAllSetting{
    return (self.rkObjectManager && [self.rkObjectManager.HTTPClient.defaultHeaders valueForKey:@"Authorization"]);
}

- (void)settingValuesIntoEntity:(id)entity withInformationDic:(NSDictionary *)dictionary{
    NSArray *allKeys = [dictionary allKeys];
    for (NSString *key in allKeys) {
        if ([entity respondsToSelector:NSSelectorFromString(key)]){
            [entity setValue:[dictionary valueForKey:key] forKey:key];
        }
    }
}

- (NSMutableDictionary *)allPropertyNames:(id)entity withInformationDic:(NSDictionary *)dictionary{
    NSMutableDictionary *rDic = [NSMutableDictionary dictionary];
    NSArray *allKeys = [dictionary allKeys];
    for (NSString *key in allKeys) {
        if ([entity respondsToSelector:NSSelectorFromString(key)]){
            [rDic setValue:key forKey:key];
        }
    }
    return rDic;
    
/**
 Using runtime checking all properties in entity.
 Better than scan all userInfo's keys which embedded in Entity.
 
 A future work here.
 */
//        unsigned count;
//        objc_property_t *properties = class_copyPropertyList([self class], &count);
//        
//        NSMutableArray *rv = [NSMutableArray array];
//        
//        unsigned i;
//        for (i = 0; i < count; i++)
//        {
//            objc_property_t property = properties[i];
//            NSString *name = [NSString stringWithUTF8String:property_getName(property)];
//            [rv addObject:name];
//        }
//        
//        free(properties);
//        
//        return rv;
}

@end
