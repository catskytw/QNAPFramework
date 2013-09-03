//
//  QNMyCloudMapping.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMyCloudMapping.h"

@implementation QNMyCloudMapping

+ (RKEntityMapping *)mappingForUser{
    RKEntityMapping *mappingResult = [RKEntityMapping mappingForEntityForName:@"User" inManagedObjectStore:nil];
}
@end
