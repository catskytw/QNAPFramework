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
@property(nonatomic, strong) RKObjectManager *rkObjectManager;

- (id)initWithMyCloudBaseURL:(NSURL *)baseURL;

- (void)fetchOAuthToken:(void(^)(AFOAuthCredential *credential))success
       withFailureBlock:(void(^)(NSError *error))failure;

- (void)readMyInformation:(void(^)(RKObjectRequestOperation *operaion, RKMappingResult *mappingResult))success withFailiureBlock:(void(^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
