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
+ (RKEntityMapping *)entityMapping:(NSString*)entityName withManagerObjectStore:(RKManagedObjectStore*)managedObjectStore isXMLParser:(BOOL)isXMLParser isFirstChatUppercase:(BOOL)isFirstCharUppercase;

+ (RKDynamicMapping *)dynamicMappingWithCorrectMapping:(RKEntityMapping *)correctResponseMapping withErrorResponseMapping:(RKEntityMapping *)errorMapping withErrorKey:(NSString *)errorNodeKey isXMLParser:(BOOL)isXML;

+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray*)allKeys;
+ (NSDictionary *)convertAllKeysFromRKPropertInspectorToDictionary:(NSArray *)allKeys isForcingFirstCharUppercase:(BOOL)isForce;

+ (void)dynamicMappingResult:(id)dynamicObject;

@end
