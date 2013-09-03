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

@interface QNMyCloudManager : NSObject
@property(nonatomic, strong) NSURL *baseURL;
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
- (id)initWithMyCloudBaseURL:(NSURL *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret;

/**
 *  Acquiring the credential of each mycloud API. If success, this method would build a RKObjectManager embedding the credential.
 *  Developers don't take care anything about OAuth2.
 *
 *  @param success What else things you want to do if success
 *  @param failure What else things you want to do if failure
 */
- (void)fetchOAuthToken:(void(^)(AFOAuthCredential *credential))success
       withFailureBlock:(void(^)(NSError *error))failure;

#pragma mark - /me
/**
 *  Get MyInformation from resource /me
 *
 *  @param success What else things you want to do if success
 *  @param failure What else things you want to do if failure
 */
- (void)readMyInformation:(void(^)(RKObjectRequestOperation *operaion, RKMappingResult *mappingResult))success withFailiureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
