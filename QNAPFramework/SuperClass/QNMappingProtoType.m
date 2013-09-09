//
//  QNMappingProtoType.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>
#import "Response.h"
#import "QNAPCommunicationManager.h"

@implementation QNMappingProtoType

+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser{
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
        [targetEntityMapping addAttributeMappingsFromDictionary:[self convertAllKeysFromRKPropertInspectorToDictionary:mutableKeysArray]];
    else
        [targetEntityMapping addAttributeMappingsFromArray:mutableKeysArray];
    return targetEntityMapping;
}

+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray*)allKeys{
    NSMutableDictionary *mutablDic = [[NSMutableDictionary alloc] init];
    for (NSString *key in allKeys) {
        [mutablDic setValue:key forKey:[NSString stringWithFormat:@"%@.text",key]];
    }
    return (NSDictionary*)mutablDic;
}
@end
