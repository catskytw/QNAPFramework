//
//  QNVideoStationAPIManager.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/27.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNVideoStationAPIManager.h"
#import "QNVideoMapping.h"
#import "QNAPCommunicationManager.h"
#import "QNVideoFileList.h"
#import "QNVideoFileItem.h"

@implementation QNVideoStationAPIManager

- (void)getAllFileListWithSortBy:(VideoFileListSortType)sortType withPageNumber:(NSInteger)pageNumber withCountsPerPage:(NSInteger)countsPerPage withHomePath:(VideoFileHomePath)homePath isASC:(BOOL)isASC  withSuccessBlock:(QNQNVideoFileListSuccessBlock)success withFailureBlock:(QNFailureBlock)failure{
    RKEntityMapping *fileListMapping = [QNVideoMapping mappingForGetAllVideoList];
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:fileListMapping
                                                                                            method:RKRequestMethodGET
                                                                                       pathPattern:nil
                                                                                           keyPath:@"QDocRoot"
                                                                                       statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.weakRKObjectManager addResponseDescriptor:responseDescriptor];
    NSDictionary *parameters = @{@"t":@"videos",
                                 @"s": [self sortString:sortType],
                                 @"sd":(isASC)?@"ASC":@"DESC",
                                 @"sid":[QNAPCommunicationManager share].sidForMultimedia,
                                 @"p": [NSNumber numberWithInt:pageNumber],
                                 @"c": [NSNumber numberWithInt:countsPerPage],
                                 @"h": [NSNumber numberWithInt:[self valueForHomePath:homePath]]
                                 };
    [self.weakRKObjectManager getObject:nil
                                   path:@"video/api/list.php"
                             parameters:parameters
                                success:^(RKObjectRequestOperation *o, RKMappingResult *m){
                                    QNVideoFileList *mappingObject = [m firstObject];
                                    success(o, m, mappingObject);
                                }
                                failure:^(RKObjectRequestOperation *o, NSError *e){
                                    failure(o, e);
                                }];
}


#pragma mark - PrivateMethod
- (NSString *)sortString:(VideoFileListSortType)sortType{
    NSString *s = nil;
    switch (sortType) {
        case videoFileListSortByColor:
            s = @"color";
            break;
        case videoFileListSortByCreate:
            s = @"create";
            break;
        case videoFileListSortByDBtime:
            s = @"dbtime";
            break;
        case videoFileListSortByModify:
            s = @"modify";
            break;
        case videoFileListSortByName:
            s = @"name";
            break;
        case videoFilelistSortByRating:
            s = @"rating";
            break;
        case videoFileListSortByTimeLine:
            s = @"timeline";
            break;
        case videoFileListSortByRandom:
        default:
            s = @"random";
            break;
    }
    return s;
}

- (NSInteger)valueForHomePath:(VideoFileHomePath)homePath{
    NSInteger r = 0;
    switch (homePath) {
        case videoFileHomePathPrivate:
            r = 1;
            break;
        case videoFileHomePathQSync:
            r = 2;
            break;
        default:
        case videoFileHomePathPublic:
            r = 0;
            break;
    }
    return r;
}
@end
