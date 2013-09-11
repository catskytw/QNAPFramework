//
//  QNFileStationAPIManager.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNModuleBaseObject.h"
#import <RestKit/RestKit.h>
#import "QNFileLogin.h"
@interface QNFileStationAPIManager : QNModuleBaseObject
@property(nonatomic, strong) RKObjectManager *rkObjectManager;
/**
 *  login action in FileStations Version 1.0
 *  TODO: checkout the version above
 *
 *  @param account  the account you want to login
 *  @param password the password for account above
 *  @param success  a success block excuting while login success in asynchronized mode.
 *  @param failure  a failure block
 */
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNFileLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure;

@end
