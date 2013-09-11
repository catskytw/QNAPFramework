//
//  QNAPCommunicationManager.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNFileStationAPIManager.h"
#import "QNMyCloudManager.h"

@interface QNAPCommunicationManager : NSObject
@property(nonatomic, strong) NSMutableArray *allModules;
@property(nonatomic, strong) RKManagedObjectStore *objectManager;

+ (QNAPCommunicationManager *)share;
+ (void)closeCommunicationManager;
#pragma mark - Factory methods
- (QNFileStationAPIManager *)factoryForFileStatioAPIManager:(NSString *)baseURL;
- (QNMyCloudManager *)factoryForMyCloudManager:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret;
- (void)settingMisc:(NSBundle *)resourceBundle;
- (void)activateDebugLogLevel:(int)_ddLogLevel;
@end
