//
//  QNFileStationAPIManager.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNModuleBaseObject.h"
#import <RestKit/RestKit.h>
#import "QNFileLogin.h"
#import "QNFileLoginError.h"
#import "QNAPFramework.h"
#import "QNSearchResponse.h"

typedef enum{
    QNFileNameSort = 0,
    QNFileSizeSort,
    QNFileTypeSort,
    QNFileModefiedTimeSort,
    QNFilePrivilegeSort,
    QNFileOwnerSort,
    QNFileGroupSort
}QNFileSortType;

@interface QNFileStationAPIManager : QNModuleBaseObject{
    NSString *_authSid;
}
@property(nonatomic, strong) RKObjectManager *rkObjectManager;
@property(nonatomic, strong, readonly) NSString *authSid;
- (void)setting;

/**
 *  login action in FileStations Version 1.0
 *  TODO: checkout the version above
 *
 *  @param account  the account you want to login
 *  @param password the password for account above
 *  @param success  a success block excuting while login success in asynchronized mode.
 *  @param failure  a failure block
 */
- (void)loginWithAccount:(NSString*)account withPassword:(NSString*)password withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult, QNFileLogin *loginInfo))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, QNFileLoginError *loginError))failure;

/**
 *  Download a file. You can use the 'fileRange' parameter to request some specified binary data of the file. Resume downloading is based on the machinism mentioned before.
 *
 *  @param filePath   file path
 *  @param fileName   file name
 *  @param isFolder   a directory or not.
 *  @param fileRange  the range of bytes, the defulat value is nil which means to download a whole file.
 *  @param success    success block
 *  @param failure    failure block
 *  @param inProgress the block of updateing downloading progress
 */
- (void)downloadFileWithFilePath:(NSString *)filePath withFileName:(NSString *)fileName isFolder:(BOOL)isFolder withRange:(NSRange *)fileRange withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure withInProgressBlock:(void(^)(long long totalBytesRead, long long totalBytesExpectedToRead))inProgress;

/**
 *  Get a thumbNail for a specified pic. This method uses the url as a key to search the image from cache first, and downloads from network if there is no image in cache.
 *  In next time, the image could be fetched from cache directly unlee executing [QNFileStationAPIManager clearThumnailCache];
 *
 *  Attention: You have to give the correct fileName and filePath which are following up the relative's rule in NSURL
 *  Please see https://developer.apple.com/library/ios/documentation/cocoa/reference/foundation/Classes/NSURL_Class/Reference/Reference.html#//apple_ref/doc/uid/20000301-4355
 *
 *  @param fileName   picName
 *  @param filePath   picPath
 *  @param success    executing block after loading successful
 *  @param failure    executing block after loading failure
 *  @param inProgress invoke this block while download
 */
- (void)thumbnailWithFile:(NSString *)fileName withPath:(NSString *)filePath withSuccessBlock:(void(^)(UIImage *image))success withFailureBlock:(void(^)(NSError *error))failure withInProgressBlock:(void(^)(NSUInteger receivedSize, long long expectedSize))inProgress;

/**
 *  search files of conditions(parameters)
 *
 *  @param keyword    a keyword of the files you want to search
 *  @param sourcePath the root directory
 *  @param sortType   sortType, an enum of QNFileSortType
 *  @param limit      a number of limitation
 *  @param startIndex start index
 *  @param isASC      if yes, sorting in ASC,vice versa.
 */
- (void)searchFiles:(NSString *)keyword withSourcePath:(NSString *)sourcePath withSortField:(QNFileSortType)sortType withLimitNumber:(NSUInteger)limit withStartIndex:(NSUInteger)startIndex isASC:(BOOL)isASC withSuccessBlock:(QNQNSearchResponseSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Clean all images,which is downloaded from [QNFileStationAPIManager tuhmbnailWithFile:withPath:withSuccessBlock:withFailureBlock:withInProgressBlock:], in ImageCache
 */
- (void)clearThumbnailCache;
@end
