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
#import "MyCloudResponse.h"
#import "QNAPFramework.h"

@class MyCloudCloudLinkResponse;

@interface QNMyCloudManager : QNModuleBaseObject
/**
 *  Client ID. This is the essential information of OAuth login by App. Please ask this information from your mycloud server administrator.
 */
@property(nonatomic, strong) NSString *clientId;
/**
 *  Client Secret. This is the essential information of OAuth login by App. Please ask this information from your mycloud server administrator.
 */
@property(nonatomic, strong) NSString *clientSecret;
/**
 *  MyCloud Account. In OAuth, you can login by account/password and clientId/clientSecret for different privilege.
 *  Thus, please ask your mycloud server administor these information.
 */
@property(nonatomic, strong) NSString *account;
/**
 *  As the property "account" descrption.
 */
@property(nonatomic, strong) NSString *password;
/**
 *  A RKObjectManager here. For sharing the resource and manage all http request in queue.
 */
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

/**
 *  A subMethod invoked by fetchOAuthToek:withPassword:withSuccessBlock:withFailureBlock
 *  This method should not be bound in AOP or would be unfinity invoking.
 *
 *  @param success success block
 *  @param failure failure block
 */
- (void)refetchOAuthTokenWithSuccessBlock:(void(^)(AFOAuthCredential *credential))success
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
- (void)readMyInformation:(QNSuccessBlock)success withFailiureBlock:(QNMyCloudResponseFailureBlock)failure;

/**
 *  update MyInformation by credential. Please make sure your access token which should be acquired by 
 *  -(void)fetchOAuthToken:withPassword:withSuccessBlock:withFailureBlock:
 *  or you would get an error message
 *
 *  @param userInfo     a dictionary including all User Properties described in User Class
 *  @param success      a success block excuting after successful updating.
 *  @param failureBlock a failure block excuting after updating fail.
 */
- (void)updateMyInformation:(NSDictionary *)userInfo withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNMyCloudResponseFailureBlock)failure;

/**
 *  list activities of user.
 *
 *  @param offset  The offset of the query result.
 *  @param limit   The number of query result.
 *  @param isDesc  If true, return activities from the latest to the oldest.
 *  @param success a success block excuting after successful fetching
 *  @param failure a failure block excuting after fetching fail.
 */
- (void)listMyActivities:(NSInteger)offset withLimit:(NSInteger)limit isDesc:(BOOL)isDesc withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNMyCloudResponseFailureBlock)failure;

/**
 *  Change user's password
 *
 *  @param oldPassword oldPassword
 *  @param newPassword newPassword
 *  @param success     a success block excuting after successful fetching
 *  @param failure     a failure block excuting after fetching fail.
 */
- (void)changeMyPassword:(NSString *)oldPassword withNewPassword:(NSString *)newPassword withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNMyCloudResponseFailureBlock)failure;

#pragma mark - /cloudLink

/**
 *  get cloudlink
 *
 *  @param offset  the number of offset
 *  @param limit   the number of limitation
 *  @param success success block
 *  @param failure failure block
 */
- (void)getCloudLinkWithOffset:(NSUInteger)offset withLimit:(NSUInteger)limit ithSuccessBlock:(QNMyCloudCloudLinkResponseSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;


@end
