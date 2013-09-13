//
//  QNAPFrameworkUtil.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/13.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPFrameworkUtil.h"

@implementation QNAPFrameworkUtil

+ (void)waitUntilConditionYES:(NSNumber *)condition{
    while (![condition boolValue]){
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    }
}
@end
