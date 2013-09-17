//
//  QNAPFrameworkUtil.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/13.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNMusicListResponse.h"
typedef BOOL(^CheckConditionBlock)(void);

@interface QNAPFrameworkUtil : NSObject
+ (void)waitUntilConditionYES:(int *)condition;
+ (void)waitUntilConditionBlock:(__strong CheckConditionBlock)checkCondition;

@end
