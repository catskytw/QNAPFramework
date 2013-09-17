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
    [passwdConstraints setIdentificationAttributes:@[@"passwdConstraint01", @"passwdConstraint02", @"passwdConstraint03", @"passwdConstraint04"]];

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
                                                                                          toKeyPath:@"relationship_passwdConstraints"
                                                                                        withMapping:passwdConstraints];
    
    [fileStationLoginMapping addPropertyMapping:firmwareRelation];
    [fileStationLoginMapping addPropertyMapping:modelRelation];
    [fileStationLoginMapping addPropertyMapping:customLogoRelation];
    [fileStationLoginMapping addPropertyMapping:passwdConstraintsRelation];
    
    return fileStationLoginMapping;
}

+ (RKEntityMapping *)mappingForSearchFiles{
    RKEntityMapping *responseMapping = [self entityMapping:@"QNSearchResponse"
                            withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                       isXMLParser:NO];
    RKEntityMapping *searchFileMapping = [self entityMapping:@"QNSearchFileInfo"
                                      withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                                 isXMLParser:NO];
    [searchFileMapping setIdentificationAttributes:@[@"filename", @"epochmt"]];
    
    RKRelationshipMapping *searchFileRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"datas"
                                                                                            toKeyPath:@"relationship_QNSearchFileInfo"
                                                                                          withMapping:searchFileMapping];
    [responseMapping addPropertyMapping:searchFileRelation];
    return responseMapping;
}

+ (RKEntityMapping *)mappingForLoginError{
    /**
     <doQuick><![CDATA[]]></doQuick><is_booting><![CDATA[0]]></is_booting><authPassed><![CDATA[0]]></authPassed><errorValue><![CDATA[-1]]></errorValue><username><![CDATA[admin]]></username></QDocRoot>
     */
    return [self entityMapping:@"QNFileLoginError" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
}

+ (RKDynamicMapping *)dynamicMappingLoginWithCorrectMapping:(RKEntityMapping *)correctResponseMapping withErrorResponseMapping:(RKEntityMapping *)errorMapping{
    RKDynamicMapping *rDynamicMapping = [RKDynamicMapping new];
    [rDynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        if ([[[representation valueForKey:@"authPassed"] valueForKey:@"text"] isEqualToString:@"0"]) {
            return errorMapping;
        } else if ([[[representation valueForKey:@"authPassed"] valueForKey:@"text"] isEqualToString:@"1"]) {
            return correctResponseMapping;
        }
        return nil;
    }];
    return rDynamicMapping;
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
