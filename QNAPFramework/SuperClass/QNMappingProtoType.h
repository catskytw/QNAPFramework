//
//  QNMappingProtoType.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>

@interface QNMappingProtoType : NSObject


+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser;
+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray*)allKeys;

@end
