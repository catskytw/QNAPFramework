//
//  QNVideoStationAPIManager.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/27.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNModuleBaseObject.h"
#import "QNAPFramework.h"

/**
 *  Sort type of video files
 *
 *  @param NSInteger             NSInteger Type
 *  @param VideoFileListSortType name of thie type definition
 *
 *  @return a enum of VideoFileListSortType
 */
typedef NS_ENUM(NSInteger, VideoFileListSortType){
    videoFileListSortByName,
    videoFileListSortByDBtime,
    videoFileListSortByCreate,
    videoFileListSortByModify,
    videoFileListSortByColor,
    videoFilelistSortByRating,
    videoFileListSortByTimeLine,
    videoFileListSortByRandom
};


typedef NS_ENUM(NSInteger, VideoFileHomePath){
    videoFileHomePathPublic,
    videoFileHomePathPrivate,
    videoFileHomePathQSync
};
@interface QNVideoStationAPIManager : QNModuleBaseObject

/**
 *  get all video files list
 *
 *  @param sortType      Sorting, see typedef 'VideoFileListSortType'
 *  @param pageNumber    Which page you want to fetch on.
 *  @param countsPerPage How many records in one page.
 *  @param homePath      Which path you want to search for?
 *  @param isASC         If yes, ASC; if no, DESC.
 *  @param success       successBlock
 *  @param failure       failureBlock
 */
- (void)getAllFileListWithSortBy:(VideoFileListSortType)sortType withPageNumber:(NSInteger)pageNumber withCountsPerPage:(NSInteger)countsPerPage withHomePath:(VideoFileHomePath)homePath isASC:(BOOL)isASC  withSuccessBlock:(QNQNVideoFileListSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  get the list of timeLine.
 *
 *  @param homePath which path you want to list
 *  @param success  successBlock, a block excuting after the request receives a response successfully
 *  @param failure  failureBlock, a block excuting after the request has any error, including error status,
 */
- (void)getTimeLineListWithHomePath:(VideoFileHomePath)homePath withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get video files in a specified date.
 *
 *  @param timeLineLabel This parameter's value is from content of timeline xml tag <YearMonth>, e.g. 2013-09
 *  @param sortType      sort by
 *  @param pageNumber    current page.
 *  @param countPerPage  how many records in one page.
 *  @param homePath      which path you want to list
 *  @param isASC         is ASC? If no, DESC.
 *  @param success       successBlock, a block excuting after the request receives a response successfully
 *  @param failure       failureBlock, a block excuting after the request has any error, including error status
 */
- (void)getTimeLineFileListWithTimeLineLabel:(NSString *)timeLineLabel withSortBy:(VideoFileListSortType)sortType withPageNumber:(NSInteger)pageNumber withCountsPerPage:(NSInteger)countPerPage withHomePath:(VideoFileHomePath)homePath isASC:(BOOL)isASC withSuccessBlock:(QNSuccessBlock)success withFailueBlock:(QNFailureBlock)failure;

@end
