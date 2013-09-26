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

/**
 *  A singleton for QNAPCommunicationManager. Of course you can create an instance for yourself.
 *
 *  @return QNAPCommunicationManager singleton
 */
+ (QNAPCommunicationManager *)share;

/**
 *  Close this CommunicationManager
 */
+ (void)closeCommunicationManager;

/**
 *  active all stations
 *
 *  @param parameters This Dictionary should look like this:
    @{
        @"NASURL":NASURL,
        @"MyCloudURL":MyCloudServerBaseURL,
        @"ClientId":CLIENT_ID,
        @"ClientSecret":CLIENT_SECRET,
    }
 *
 *  @return YES if all stations activated, vice versa.
 */
- (BOOL)activateAllStation:(NSDictionary *)parameters;
#pragma mark - Factory methods

/**
 *  a factory to create a QNFileStationAPIManager instance, and point it as QNCommunicationManager.fileStationManager
 *
 *  @param baseURL NAS URL, e.g. http://yourNasURL:8080
 *
 *  @return QNFileStationAPIManager
 */
- (QNFileStationAPIManager *)factoryForFileStatioAPIManager:(NSString *)baseURL;

/**
 *  a factory to create a QNMyCloudManager instance, and point it as QNCommunicationManager.myCloudManager
 *
 *  @param baseURL      mycloud server url
 *  @param clientId     clientId, please ask this information from mycloud server administrator.
 *  @param clientSecret clientSecret, please ask this information from mycloud server administrator.
 *
 *  @return QNCloudManager
 */
- (QNMyCloudManager *)factoryForMyCloudManager:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret;

/**
 *  A factory to create a QNMusicStationAPIManager, and point it as QNCommunicationManager.musicStationManager
 *
 *  @param baseURL NAS URL
 *
 *  @return QNMusicStationAPIManager
 */
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
