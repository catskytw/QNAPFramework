//
//  QNAPCommunicationManager.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPCommunicationManager.h"
static QNAPCommunicationManager *singletonCommunicationManager = nil;
@implementation QNAPCommunicationManager

+ (QNAPCommunicationManager *)share{
    if(singletonCommunicationManager == nil){
        /**
         1. create singletonCommunicationManager
         2. binding magical record's context with afnetworking's context(which both mean the context of CoreData)
         3. other essentail settings.
         */
    }
    return singletonCommunicationManager;
}

#pragma mark - LifeCycle

@end
