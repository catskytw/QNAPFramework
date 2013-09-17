//
//  QNAPFrameworkUtil.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/13.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPFrameworkUtil.h"
@implementation QNAPFrameworkUtil

+ (void)waitUntilConditionYES:(int *)condition{
    while (!condition){
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    }
}

+ (void)waitUntilConditionBlock:(__strong CheckConditionBlock)checkCondition{
    while(!checkCondition()){
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];        
    }
}

@end
