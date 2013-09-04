//
//  QNMyCloudManager.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import <AFOAuth2Client/AFOAuth2Client.h>
#import "QNModuleBaseObject.h"

@interface QNMyCloudManager : QNModuleBaseObject
@property(nonatomic, strong) NSString *clientId;
@property(nonatomic, strong) NSString *clientSecret;
@property(nonatomic, strong) RKObjectManager *rkObjectManager;

/**
 *  Init with some properties, including baseURL, client id, client secret.
 *
 *  @param baseURL      baseURL information of NSURL base.
 *  @param clientId     client id. If you have no one, please contact MyCloud Department in QNAP
 *  @param clientSecret client secret. If you have no one, please contact MyCloud Department in QNAP
 *
 *  @return QNMyCloudManager
 */
- (id)initWithMyCloudBaseURL:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret;

/**
 *  Acquiring the credential of each mycloud API via client_credential. If success, this method would build a RKObjectManager embedding the credential.
 *  Developers don't take care anything about OAuth2.
 *
 *  Attention!
 *  You can't invoke any /me resource if using the token acquired by this method, or you would get an error message "User is not found" from server.
 *  @param success What else things you want to do if success
 *  @param failure What else things you want to do if failure
 */
- (void)fetchOAuthToken:(void(^)(AFOAuthCredential *credential))success
       withFailureBlock:(void(^)(NSError *error))failure;

/**
 *  Acquiring the credential of each mycloud API via user login. If success, this method would build a RKObjectManager embedding the credential.
 *  Developers don't take care anything about OAuth2.
 *
 *  @param account  User Account
 *  @param password User Password
 *  @param success  What else things you want to do if success
 *  @param failure  What else things you want to do if failure
 */
- (void)fetchOAuthToken:(NSString *)account withPassword:(NSString *)password withSuccessBlock:(void(^)(AFOAuthCredential *credential))success
       withFailureBlock:(void(^)(NSError *error))failure;

#pragma mark - /me
/**
 *  Get MyInformation from resource /me
 *  Attention please. 
 *  You need to be pretty sure the token fetching by an use, not a client-crendentials; 
 *  otherwise, you would get an error message "User is not found"
 *
 *  @param success What else things you want to do if success
 *  @param failure What else things you want to do if failure
 */
- (void)readMyInformation:(void(^)(RKObjectRequestOperation *operaion, RKMappingResult *mappingResult))success withFailiureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure;

/**
 *  update MyInformation by credential. Please make sure your access token which should be acquired by 
 *  -(void)fetchOAuthToken:withPassword:withSuccessBlock:withFailureBlock:
 *  or you would get an error message
 *
 *  @param userInfo     a dictionary including all User Properties described in User Class
 *  @param success      a success block excuting after successful updating.
 *  @param failureBlock a failure block excuting after updating fail.
 */
- (void)updateMyInformation:(NSDictionary *)userInfo withSuccessBlock:(void(^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success withFailureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failureBlock;

@end
