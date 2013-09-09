//
//  QNMyCloudMapping.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMyCloudMapping.h"
#import "QNAPCommunicationManager.h"
#import <RestKit/RestKit.h>
@implementation QNMyCloudMapping

+ (RKEntityMapping *)mappingForUser{
    return [self entityMapping:@"User" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
}

+ (RKEntityMapping *)mappingForResponse{
    return [self entityMapping:@"Response" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
}

+ (RKEntityMapping *)mappingForUserActivities{
    //設定activity本身自己的mapping
    RKEntityMapping *activitiesMapping = [self entityMapping:@"UserActivity" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
    activitiesMapping.identificationAttributes = @[@"user_activity_id"];
    //設定app 的mapping與relationship
    //因為app 裡有使用id當key, 是ObjC關鍵字, entity另外取為appId
    RKEntityMapping *appMapping =  [RKEntityMapping mappingForEntityForName:@"App" inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [appMapping addAttributeMappingsFromDictionary:@{@"id":@"appId"}];
    
    RKRelationshipMapping *appRelationShip = [RKRelationshipMapping relationshipMappingFromKeyPath:@"app" toKeyPath:@"relationship_App" withMapping:appMapping];
    
    //設定sourceInfo 的mapping與relationship
    RKEntityMapping *sourceMapping = [self entityMapping:@"SourceInfo" withManagerObjectStore:[QNAPCommunicationManager share].objectManager isXMLParser:NO];
    RKRelationshipMapping *sourceInfoRelationShip = [RKRelationshipMapping relationshipMappingFromKeyPath:@"from" toKeyPath:@"relationship_SourceInfo" withMapping:sourceMapping];
    
    //將appRelationship以及sourceInfoRelationship都加入activity
    [activitiesMapping addPropertyMapping:appRelationShip];
    [activitiesMapping addPropertyMapping:sourceInfoRelationShip];
    
    return activitiesMapping;
}

+ (RKEntityMapping *)basicResponseMappingWithResult:(RKEntityMapping *)resultMapping{
    RKEntityMapping *responseMapping = [QNMappingProtoType entityMapping:@"Response"
                                                  withManagerObjectStore:[QNAPCommunicationManager share].objectManager
                                                             isXMLParser:NO];
    [responseMapping addPropertyMapping:[RKRelationshipMapping relationshipMappingFromKeyPath:@"result"
                                                                                    toKeyPath:@"relationship_result"
                                                                                  withMapping:responseMapping]];
    return responseMapping;
}

@end
