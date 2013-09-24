//
//  QNFileStationMapping.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/9.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>

@interface QNFileStationMapping : QNMappingProtoType
/**
 *  mapping for QTS login
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForLogin;

/**
 *  mapping for QTS login error if happened.
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForLoginError;

/**
 *  mapping for search file
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForSearchFiles;

/**
 *  This is a special case for QTS login mapping.
 *  It's so...complicated that we have to give a manual mapping
 *
 *  @return NSDictionary,
 */
+ (NSDictionary *)allMappingInAuthLogin;

/**
 *  give a dynamic mapping for login
 *
 *  @param correctResponseMapping the correct mapping if the response is in correct format
 *  @param errorMapping           use this error mapping if any error code or http status error.
 *
 *  @return RKDynamicMapping
 */
+ (RKDynamicMapping *)dynamicMappingLoginWithCorrectMapping:(RKEntityMapping *)correctResponseMapping withErrorResponseMapping:(RKEntityMapping *)errorMapping;
@end
