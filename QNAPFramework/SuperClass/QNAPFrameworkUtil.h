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
/**
 *  Synchronized. Waiting unless the condition is True
 *
 *  @param condition, be aware, the type is (int *)
 */
+ (void)waitUntilConditionYES:(int *)condition;

/**
 *  Synchronized. Waitint unless the block returning YES.
 *
 *  @param checkCondition block return.
 */
+ (void)waitUntilConditionBlock:(__strong CheckConditionBlock)checkCondition;

@end
