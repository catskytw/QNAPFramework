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
#import "QNMusicStationAPIManager.h"

@interface QNAPCommunicationManager : NSObject
@property(nonatomic, strong) NSMutableArray *allModules;
@property(nonatomic, strong) RKManagedObjectStore *objectManager;
@property(nonatomic, weak) RKObjectManager *weakRKObjectManager;
@property(nonatomic, strong) __block NSString *sidForQTS;
@property(nonatomic, strong) __block NSString *sidForMultimedia;
@property(nonatomic, strong) NSString *myCloudAccessToken;

+ (QNAPCommunicationManager *)share;
+ (void)closeCommunicationManager;
#pragma mark - Factory methods
- (QNFileStationAPIManager *)factoryForFileStatioAPIManager:(NSString *)baseURL;

- (QNMyCloudManager *)factoryForMyCloudManager:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret;

- (QNMusicStationAPIManager *)factoryForMusicStatioAPIManager:(NSString*)baseURL;

- (void)settingMisc:(NSBundle *)resourceBundle;

/**
 *  Give logLevel from CocoaLumberjack. See DDLog.h
 *  If LOG_FLAG_VERBOSE, it would print HTTP's request and response(including header and body in both)
 *
 *  @param _ddLogLevel Log Level
 */
- (void)activateDebugLogLevel:(int)_ddLogLevel;
@end
