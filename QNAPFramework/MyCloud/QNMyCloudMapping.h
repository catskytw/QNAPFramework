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
 *  回覆response mapping, 其餘result部份則使用dynamic mapping方式
 *
 *  @param resultMapping result 部份之mappin
 *
 *  @return RKEntityMapping, 用來放入responseDescriptor
 */
+ (RKEntityMapping *)basicResponseMappingWithResult:(RKEntityMapping *)resultMapping;

+ (RKEntityMapping *)mappingForUser;
+ (RKEntityMapping *)mappingForResponse;
+ (RKEntityMapping *)mappingForUserActivities;
@end
