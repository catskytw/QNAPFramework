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

+ (NSString *)ezEncode:(NSString *)str
{
    NSArray *ezEncodeChars = [NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"K", @"L",
                              @"M", @"N", @"O", @"P", @"Q", @"R", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z", @"a", @"b",
                              @"c", @"d", @"e", @"f", @"g", @"h", @"i", @"j", @"k", @"l", @"m", @"n", @"o", @"p", @"q", @"r",
                              @"s", @"t", @"u", @"v", @"w", @"x", @"y", @"z", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7",
                              @"8", @"9", @"+", @"/", nil];
    
    NSUInteger len = [str length];
    int i = 0;
    NSMutableString *outStr = [NSMutableString string];
    char c1, c2, c3;
    while (i < len)
    {
        c1 = [str characterAtIndex:i++] & 0xff;
        if (i == len)
        {
            [outStr appendString:[ezEncodeChars objectAtIndex:c1 >> 2]];
            [outStr appendString:[ezEncodeChars objectAtIndex:(c1 & 0x3) << 4]];
            [outStr appendString:@"=="];
            break;
        }
        
        c2 = [str characterAtIndex:i++];
        if (i == len)
        {
            [outStr appendString:[ezEncodeChars objectAtIndex:c1 >> 2]];
            [outStr appendString:[ezEncodeChars objectAtIndex:((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4)]];
            [outStr appendString:[ezEncodeChars objectAtIndex:(c2 & 0xF) << 2]];
            [outStr appendString:@"="];
            break;
        }
        
        c3 = [str characterAtIndex:i++];
        [outStr appendString:[ezEncodeChars objectAtIndex:c1 >> 2]];
        [outStr appendString:[ezEncodeChars objectAtIndex:((c1 & 0x3)<< 4) | ((c2 & 0xF0) >> 4)]];
        [outStr appendString:[ezEncodeChars objectAtIndex:((c2 & 0xF) << 2) | ((c3 & 0xC0) >> 6)]];
        [outStr appendString:[ezEncodeChars objectAtIndex:c3 & 0x3F]];
    }
    return [NSString stringWithString:outStr];
}

@end
