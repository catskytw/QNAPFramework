//
//  QNMyCloudMapping.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMyCloudMapping.h"
#import "QNAPCommunicationManager.h"
#import <RestKit/RestKit.h>
@implementation QNMyCloudMapping

+ (RKEntityMapping *)mappingForUser{
    return [self entityMapping:@"User" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
}

+ (RKEntityMapping *)mappingForResponse{
    return [self entityMapping:@"Response" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
}

+ (RKEntityMapping *)mappingForUserActivities{
    
}

@end
