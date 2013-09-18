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
@property(nonatomic, weak) RKObjectManager *rkObjectManager;

@property(nonatomic, strong) NSString *sidForQTS;
@property(nonatomic, strong) NSString *sidForMultimedia;
@property(nonatomic, strong) NSString *myCloudAccessToken;

@property(nonatomic, strong) QNFileStationAPIManager *fileStationsManager;
@property(nonatomic, strong) QNMyCloudManager *myCloudManager;
@property(nonatomic, strong) QNMusicStationAPIManager *musicStationManager;

+ (QNAPCommunicationManager *)share;
+ (void)closeCommunicationManager;

/**
 *  active all stations
 *
 *  @param parameters This Dictionary should look like this:
 * @{
 * @"NASURL":NASURL,
 * @"MyCloudURL":MyCloudServerBaseURL,
 * @"ClientId":CLIENT_ID,
 * @"ClientSecret":CLIENT_SECRET
 * }
 *
 *  @return YES if all stations activated, vice versa.
 */
- (BOOL)activateAllStation:(NSDictionary *)parameters;
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
