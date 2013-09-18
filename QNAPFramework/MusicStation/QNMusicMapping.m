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
    RKEntityMapping *response = [QNMusicMapping entityMapping:@"QNMusicListResponse"
                                       withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                                  isXMLParser:YES];
    
    RKEntityMapping *mapping = [QNMusicMapping entityMapping:@"QNFolderSummary"
                                      withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                                 isXMLParser:YES
                                        isFirstChatUppercase:YES];
    RKEntityMapping *subMapping = [QNMusicMapping entityMapping:@"QNFolder"
                                         withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                                    isXMLParser:YES
                                           isFirstChatUppercase:YES];
    [mapping addAttributeMappingsFromDictionary:
     @{
     @"audio_playtime.text":@"audio_playtime"
     }];
    [subMapping setIdentificationAttributes:@[ @"linkID"]];
    
    
    RKRelationshipMapping *datasRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"datas"
                                                                                       toKeyPath:@"relationship_QNFolderSummary"
                                                                                     withMapping:mapping];
    
    [response addPropertyMapping:datasRelation];

    RKRelationshipMapping *dataRelation = [RKRelationshipMapping relationshipMappingFromKeyPath:@"data"
                                                                                      toKeyPath:@"relationship_QNFolder"
                                                                                    withMapping:subMapping];
    
    [mapping addPropertyMapping:dataRelation];
    return response;
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
