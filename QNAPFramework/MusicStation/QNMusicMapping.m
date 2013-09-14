//
//  QNMusicMapping.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMusicMapping.h"
#import "QNAPCommunicationManager.h"

@implementation QNMusicMapping

+ (RKEntityMapping *)mappingForFolder{
    return  [QNMusicMapping entityMapping:@"QNFolder"
                   withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                              isXMLParser:YES
                     isFirstChatUppercase:YES];
}

+ (RKEntityMapping *)mappingForError{
    return [QNMusicMapping entityMapping:@"QNError"
                  withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                             isXMLParser:YES];
}

+ (RKDynamicMapping *)dynamicMappingForMultiMediaLogin{
    RKEntityMapping *multiMediaLoginMapping = [QNMusicMapping mappingForMultimediaLogin];
    [multiMediaLoginMapping setIdentificationAttributes:@[@"sid"]];
    
    RKEntityMapping *multiMediaLoginInfoMapping = [QNMusicMapping mappingForMultimediaLoginInfo];
    [multiMediaLoginInfoMapping setIdentificationAttributes:@[@"builtinFirmwareVersion"]];
    
    RKDynamicMapping *dynamicMapping = [RKDynamicMapping new];
    [dynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        NSDictionary *dictionary = (NSDictionary *)representation;
        NSArray *allKeys = [dictionary allKeys];
        for (NSString *key in allKeys) {
            if([key isEqualToString:@"sid"])
                return multiMediaLoginMapping;
        }
        return multiMediaLoginInfoMapping;
    }];
    return dynamicMapping;
}

+ (RKEntityMapping *)mappingForMultimediaLoginInfo{
    return [QNMusicMapping entityMapping:@"QNMultimediaLoginInfo"
                  withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                             isXMLParser:YES];    
}

+ (RKEntityMapping *)mappingForMultimediaLogin{
    return [QNMusicMapping entityMapping:@"QNMultimediaLogin" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:YES];
}
@end
