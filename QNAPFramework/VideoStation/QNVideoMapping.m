//
//  QNVideoMapping.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/27.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNVideoMapping.h"
#import "QNAPCommunicationManager.h"

@implementation QNVideoMapping
+ (RKEntityMapping *)mappingForGetAllVideoList{
    RKEntityMapping * fileListMapping = [RKEntityMapping mappingForEntityForName:@"QNVideoFileList" inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    RKEntityMapping * fileItemMapping = [RKEntityMapping mappingForEntityForName:@"QNVideoFileItem" inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [fileListMapping addAttributeMappingsFromDictionary:@{@"status.text":@"status",
                                                          @"videoCount.text":@"videoCount",
                                                          @"Queries.text":@"queries",
                                                          @"KeywordList.text":@"keywordList"
                                                          }];
    [fileItemMapping addAttributeMappingsFromDictionary:[self attributeDictionaryForGetAllVideoItem]];
    [fileItemMapping setIdentificationAttributes:@[@"f_id"]];
    RKRelationshipMapping *relation_FileItem = [RKRelationshipMapping relationshipMappingFromKeyPath:@"DataList.FileItem"
                                                                                           toKeyPath:@"relationship_FileItem"
                                                                                         withMapping:fileItemMapping];
    [fileListMapping addPropertyMapping:relation_FileItem];
    return fileListMapping;
}

+ (RKEntityMapping *)mappingForTimeLineList{
    RKEntityMapping *timeLineResponse = [RKEntityMapping mappingForEntityForName:@"QNVideoTimeLineResponse" inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [timeLineResponse addAttributeMappingsFromDictionary:@{@"status.text":@"status",
                                                           @"Queries.text":@"queries"
                                                           }];
    RKEntityMapping *timeLineListMapping = [RKEntityMapping mappingForEntityForName:@"QNVideoTimeLine"
                                                               inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [timeLineListMapping addAttributeMappingsFromDictionary:@{
                                                              @"YearMonth.text":@"yearMonth",
                                                              @"Year.text":@"year",
                                                              @"Month.text":@"month",
                                                              @"Count.text":@"count"
                                                              }];
    RKEntityMapping *timeLineDateItem = [RKEntityMapping mappingForEntityForName:@"QNVideoDateItem"
                                                            inManagedObjectStore:[QNAPCommunicationManager share].objectManager];
    [timeLineDateItem addAttributeMappingsFromDictionary:@{@"c.text":@"count",
                                                           @"d.text":@"date"
                                                           }];
    RKRelationshipMapping *relation_timeLine = [RKRelationshipMapping relationshipMappingFromKeyPath:@"DataList.Timeline"
                                                                                           toKeyPath:@"relationship_timeLine"
                                                                                         withMapping:timeLineListMapping];
    
    RKRelationshipMapping *relation_dateItem = [RKRelationshipMapping relationshipMappingFromKeyPath:@"date"
                                                                                           toKeyPath:@"relationship_dateItem"
                                                                                         withMapping:timeLineDateItem];
    [timeLineResponse addPropertyMapping:relation_timeLine];
    [timeLineListMapping addPropertyMapping:relation_dateItem];
    
    return timeLineResponse;
}


+ (NSDictionary *)attributeDictionaryForGetAllVideoItem{
    return @{
             @"MediaType.text":@"mediaType",
             @"id.text":@"f_id",
             @"cFilename.text":@"cFileName",
             @"cPictureTitle.text":@"cPictureTitle",
             @"comment.text":@"comment",
             @"mime.text":@"mime",
             @"iFileSize.text":@"iFileSize",
             @"iWidth.text":@"iWidth",
             @"iHeight.text":@"iHeight",
             @"Duration.text":@"duration",
             @"DateCreated.text":@"dateCreated",
             @"DateModified.text":@"dateModified",
             @"AddToDbTime.text":@"addToDbTime",
             @"YearMonth.text":@"yearMonth",
             @"YearMonthDay.text":@"yearMonthDay",
             @"dateTime.text":@"dateTime",
             @"status.text":@"status",
             @"TranscodeStatus.text":@"transcodeStatus",
             @"ColorLevel.text":@"colorLevel",
             @"Orientation.text":@"orientation",
             @"mask.text":@"mask",
             @"prefix.text":@"prefix",
             @"keywords.text":@"keywords",
             @"rating.text":@"rating",
             @"uid.text":@"uid",
             @"ImportYearMonthDay.text":@"importYearMonthDay",
             @"V720P.text":@"v720P",
             @"V360P.text":@"v360P",
             @"V240P.text":@"v240P",
             @"new.text":@"isNew"
             };
}

@end
