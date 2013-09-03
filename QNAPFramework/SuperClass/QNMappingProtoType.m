//
//  QNMappingProtoType.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>
@implementation QNMappingProtoType

+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser{
    RKEntityMapping *targetEntityMapping = [RKEntityMapping mappingForEntityForName:entityName inManagedObjectStore:managedObjectStore];
    NSManagedObjectModel *managerObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    NSEntityDescription *targetEntityDescription = [[managerObjectModel entitiesByName] objectForKey:entityName];
    NSArray *targetEntityKeys =[[[RKPropertyInspector sharedInspector] propertyInspectionForEntity:targetEntityDescription] allKeys];
    if(isXMLParser)
        [targetEntityMapping addAttributeMappingsFromDictionary:[self convertAllKeysFromRKPropertInspectorToDictionary:targetEntityKeys]];
    else
        [targetEntityMapping addAttributeMappingsFromArray:targetEntityKeys];
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
