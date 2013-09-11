//
//  QNFileStationMapping.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/9.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNFileStationMapping.h"
#import "QNAPCommunicationManager.h"

@implementation QNFileStationMapping
+ (RKEntityMapping *)mappingForLogin{
    RKEntityMapping *fileStationLoginMapping = [RKEntityMapping mappingForEntityForName:@"QNFileLogin" inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [fileStationLoginMapping addAttributeMappingsFromDictionary:[QNFileStationMapping allMappingInAuthLogin]];
    [fileStationLoginMapping setIdentificationAttributes:@[@"authSid"]];
    
    RKEntityMapping *model = [self entityMapping:@"QNFileModel" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
    [model setIdentificationAttributes:@[@"modelName", @"platform"]];
    
    RKEntityMapping *firmware = [self entityMapping:@"QNFileFirmware" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
    [firmware setIdentificationAttributes:@[@"build", @"buildTime", @"version"]];
    
    RKEntityMapping *customLogo = [self entityMapping:@"QNFileCustomLogo" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
    [customLogo setIdentificationAttributes:@[@"customFrontLogo", @"customLoginLogo"]];
    
    RKEntityMapping *passwdConstraints = [self entityMapping:@"QNFilePasswdConstraints" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
    [customLogo setIdentificationAttributes:@[@"passwdConstraint01", @"passwdConstraint02", @"passwdConstraint03", @"passwdConstraint04"]];

    RKRelationshipMapping *firmwareRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"firmware"
                                                                                          toKeyPath:@"relationship_firmware"
                                                                                        withMapping:firmware];
    RKRelationshipMapping *modelRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"model"
                                                                                          toKeyPath:@"relationship_model"
                                                                                        withMapping:model];
    RKRelationshipMapping *customLogoRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"customLogo"
                                                                                          toKeyPath:@"relationship_customLogo"
                                                                                        withMapping:customLogo];
    RKRelationshipMapping *passwdConstraintsRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"passwdConstraints"
                                                                                          toKeyPath:@"relationship_firmware"
                                                                                        withMapping:passwdConstraints];
    
    [fileStationLoginMapping addPropertyMapping:firmwareRelation];
    [fileStationLoginMapping addPropertyMapping:modelRelation];
    [fileStationLoginMapping addPropertyMapping:customLogoRelation];
    [fileStationLoginMapping addPropertyMapping:passwdConstraintsRelation];
    
    return fileStationLoginMapping;
}



+ (NSDictionary *)allMappingInAuthLogin{
        return @{
                 @"doQuick.text": @"doQuick",
                 @"is_booting.text":@"is_booting",
                 @"authPassed.text": @"authPassed",
                 @"authSid.text": @"authSid",
                 @"isAdmin.text":@"isAdmin",
                 @"username.text":@"username",
                 @"groupname.text":@"groupname",
                 @"specVersion.text":@"specVersion",
                 @"hostname.text":@"hostname",
                 @"DemoSiteSuppurt.text":@"demoSiteSupport",
                 @"HTTPHost.text":@"httpHost",
                 @"webAccessPort.text":@"webAccessPort",
                 @"QWebPort.text":@"qWebPort",
                 @"webFSEnabled.text":@"webFSEnabled",
                 @"QMultimediaEnabled.text":@"qMultimediaEnabled",
                 @"MSV2Supported.text":@"msv2Supported",
                 @"MSV2WebEnabled.text":@"msv2WebEnabled",
                 @"MSV2URL.text":@"msv2URL",
                 @"QDownloadEnabled.text":@"qDownloadEnabled",
                 @"DSV2Supported.text":@"dsv2Supported",
                 @"DSV3Supported.text":@"dsv3Supported",
                 @"DSV2URL.text":@"dsv2URL",
                 @"QWebEnabled.text":@"qWebEnabled",
                 @"QWebSSLEnabled.text":@"qWebSSLEnabled",
                 @"QWebSSLPort.text":@"qWebSSLPort",
                 @"NVREnabled.text":@"nvrEnabled",
                 @"NVRURL.text":@"nvrURL",
                 @"NVRVER.text":@"nvrVer",
                 @"WFM2.text":@"wfm2",
                 @"wfmPortEnabled.text":@"wfmPortEnabled",
                 @"wfmPort.text":@"wfmPort",
                 @"wfmSSLEnabled.text":@"wfmSSLEnabled",
                 @"wfmSSLPort.text":@"wfmSSLPort",
                 @"wfmURL.text":@"wfmURL",
                 @"QMusicsEnabled.text":@"qMusicsEnabled",
                 @"QMusicsURL.text":@"qMusicsURL",
                 @"QVideosEnabled.text":@"qVideosEnabled",
                 @"QVideosURL.text":@"qVideosURL",
                 @"QPhotosEnabled.text":@"qPhotosEnabled",
                 @"QPhotosURL.text":@"qPhotosURL",
                 @"stunnelEnabled.text":@"stunnelEnabled",
                 @"stunnelPort.text":@"stunnelPort",
                 @"forceSSL.text":@"forceSSL",
                 @"HDAROOT_ALMOST_FULL.text":@"hdaRoot_ALMOST_FULL",
                 @"serviceURL.text":@"serviceURL",
                 };
}
@end
