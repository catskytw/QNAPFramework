//
//  NSString+QNAPUtil.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "NSString+QNAPUtil.h"

@implementation NSString (QNAPUtil)
- (NSString *)forceFirstCharUppercase{
    NSString *firstChar = [[self substringWithRange:NSMakeRange(0, 1)] uppercaseString];
    return [self stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:firstChar];
}

@end
