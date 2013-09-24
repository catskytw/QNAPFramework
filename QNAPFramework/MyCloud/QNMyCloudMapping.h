//
//  QNMyCloudMapping.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "QNMappingProtoType.h"
@interface QNMyCloudMapping : QNMappingProtoType
/**
 *  The basic mapping only for status, message properties
 *
 *  @param resultMapping result mapping from developers for result properties
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)basicResponseMappingWithResult:(RKEntityMapping *)resultMapping;

/**
 *  mapping for fetching user information
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForUser;

/**
 *  mapping for myCloud response
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForResponse;

/**
 *  mapping for fetching cloudlink
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForCloudlink;

/**
 *  mapping for users' activities
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForUserActivities;
@end
