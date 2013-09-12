//
//  QNFileLogin.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/11.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNFileFirmware;

@interface QNFileLogin : NSManagedObject

@property (nonatomic, retain) NSNumber * authPassed;
@property (nonatomic, retain) NSString * authSid;
@property (nonatomic, retain) NSString * demoSiteSupport;
@property (nonatomic, retain) NSString * doQuick;
@property (nonatomic, retain) NSNumber * dsv2Supported;
@property (nonatomic, retain) NSString * dsv2URL;
@property (nonatomic, retain) NSNumber * dsv3Supported;
@property (nonatomic, retain) NSNumber * forceSSL;
@property (nonatomic, retain) NSString * groupname;
@property (nonatomic, retain) NSNumber * hdaRoot_ALMOST_FULL;
@property (nonatomic, retain) NSString * hostname;
@property (nonatomic, retain) NSString * httpHost;
@property (nonatomic, retain) NSNumber * is_booting;
@property (nonatomic, retain) NSNumber * isAdmin;
@property (nonatomic, retain) NSNumber * msv2Supported;
@property (nonatomic, retain) NSString * msv2URL;
@property (nonatomic, retain) NSNumber * msv2WebEnabled;
@property (nonatomic, retain) NSNumber * nvrEnabled;
@property (nonatomic, retain) NSString * nvrURL;
@property (nonatomic, retain) NSString * nvrVer;
@property (nonatomic, retain) NSNumber * qDownloadEnabled;
@property (nonatomic, retain) NSNumber * qMultimediaEnabled;
@property (nonatomic, retain) NSNumber * qMusicsEnabled;
@property (nonatomic, retain) NSString * qMusicsURL;
@property (nonatomic, retain) NSNumber * qPhotosEnabled;
@property (nonatomic, retain) NSString * qPhotosURL;
@property (nonatomic, retain) NSNumber * qVideosEnabled;
@property (nonatomic, retain) NSString * qVideosURL;
@property (nonatomic, retain) NSNumber * qWebEnabled;
@property (nonatomic, retain) NSNumber * qWebPort;
@property (nonatomic, retain) NSNumber * qWebSSLEnabled;
@property (nonatomic, retain) NSNumber * qWebSSLPort;
@property (nonatomic, retain) NSString * serviceURL;
@property (nonatomic, retain) NSString * specVersion;
@property (nonatomic, retain) NSNumber * stunnelEnabled;
@property (nonatomic, retain) NSNumber * stunnelPort;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * webAccessPort;
@property (nonatomic, retain) NSNumber * webFSEnabled;
@property (nonatomic, retain) NSNumber * wfm2;
@property (nonatomic, retain) NSNumber * wfmPort;
@property (nonatomic, retain) NSNumber * wfmPortEnabled;
@property (nonatomic, retain) NSNumber * wfmSSLEnabled;
@property (nonatomic, retain) NSNumber * wfmSSLPort;
@property (nonatomic, retain) NSString * wfmURL;
@property (nonatomic, retain) NSManagedObject *relationship_customLogo;
@property (nonatomic, retain) NSManagedObject *relationship_passwdConstraints;
@property (nonatomic, retain) QNFileFirmware *relationship_firmware;
@property (nonatomic, retain) NSManagedObject *relationship_model;

@end
