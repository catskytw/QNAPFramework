//
//  QNMappingProtoType.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>
#import "QNAPCommunicationManager.h"
#import "NSString+QNAPUtil.h"

@implementation QNMappingProtoType

+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser{
    return [QNMappingProtoType entityMapping:entityName withManagerObjectStore:managedObjectStore isXMLParser:isXMLParser isFirstChatUppercase:NO];
}

+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser isFirstChatUppercase:(BOOL)isFirstCharUppercase{
    RKEntityMapping *targetEntityMapping = [RKEntityMapping mappingForEntityForName:entityName inManagedObjectStore:managedObjectStore];
    NSManagedObjectModel *managerObjectModel = managedObjectStore.managedObjectModel;
    NSEntityDescription *targetEntityDescription = [[managerObjectModel entitiesByName] objectForKey:entityName];
    NSArray *targetEntityKeys =[[[RKPropertyInspector sharedInspector] propertyInspectionForEntity:targetEntityDescription] allKeys];
    
    /**
     資料表於設計時, 有relationship的key必定要以 "relationship_xxxx" 的格式
     以利此處篩選
     */
    NSMutableArray *mutableKeysArray = [NSMutableArray arrayWithArray:targetEntityKeys];
    NSMutableArray *discardArray = [NSMutableArray array];
    for (NSString *key in mutableKeysArray) {
        if([key hasPrefix:@"relationship_"])
            [discardArray addObject:key];
    }
    [mutableKeysArray removeObjectsInArray:discardArray];
    
    if(isXMLParser)
        if(isFirstCharUppercase)
            [targetEntityMapping addAttributeMappingsFromDictionary:[self convertAllKeysFromRKPropertInspectorToDictionary:mutableKeysArray isForcingFirstCharUppercase:YES]];
        else
            [targetEntityMapping addAttributeMappingsFromDictionary:[self convertAllKeysFromRKPropertInspectorToDictionary:mutableKeysArray]];
    else
        [targetEntityMapping addAttributeMappingsFromArray:mutableKeysArray];
    return targetEntityMapping;
}

+ (RKDynamicMapping *)dynamicMappingWithCorrectMapping:(RKEntityMapping *)correctResponseMapping withErrorResponseMapping:(RKEntityMapping *)errorMapping withErrorKey:(NSString *)errorNodeKey isXMLParser:(BOOL)isXML{
    
    RKDynamicMapping *rDynamicMapping = [RKDynamicMapping new];
    [rDynamicMapping setObjectMappingForRepresentationBlock:^RKObjectMapping *(id representation) {
        NSString *judgeKey = (isXML)?[[representation valueForKey:errorNodeKey] valueForKey:@"text"]:[representation valueForKey:errorNodeKey];
        if ([judgeKey isEqualToString:@"0"])
            return errorMapping;
        else
            return correctResponseMapping;
    }];
    return rDynamicMapping;
}

+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray*)allKeys{
    return [QNMappingProtoType convertAllKeysFromRKPropertInspectorToDictionary:allKeys isForcingFirstCharUppercase:NO];
}

+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray *)allKeys isForcingFirstCharUppercase:(BOOL)isForce{
    NSMutableDictionary *mutablDic = [[NSMutableDictionary alloc] init];
    for (NSString *key in allKeys) {
        (isForce)?
        [mutablDic setValue:key forKey:[NSString stringWithFormat:@"%@.text",[key forceFirstCharUppercase]]]:
        [mutablDic setValue:key forKey:[NSString stringWithFormat:@"%@.text",key]];
    }
    return (NSDictionary*)mutablDic;
}

+ (void)dynamicMappingResult:(id)dynamicObject{
    DDLogWarn(@"dynamic mapping detected: %@", NSStringFromClass([dynamicObject class]));
}

@end
