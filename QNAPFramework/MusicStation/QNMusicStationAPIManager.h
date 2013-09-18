//
//  QNMusicStationAPIManager.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/13.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNModuleBaseObject.h"
#import <RestKit/RestKit.h>
#import "QNAPFramework.h"
#import "QNMusicMapping.h"

@class QNFileLogin;
typedef enum{
    QNSearchSongAll = 1,
    QNSearchSongName,
    QNSearchSongAlbum,
    QNSearchSongArtist
} QNSearchSongType;

@interface QNMusicStationAPIManager : QNModuleBaseObject
- (void)setting;

#pragma mark - MusicStation API
/**
 *  Login method for fetching multimedia sid. This method is not hooked in AOP interceptors.
 *
 *  @param account  Your NAS account
 *  @param password Your NAS password
 *  @param success  executing after login success
 *  @param failure  executing after login fail
 */
- (void)loginForMultimediaSid:(NSString *)account withPassword:(NSString *)password withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getFolderListWithFolderID:(NSString* )folderId withSuccessBlock:(QNSuccessBlock)success withFaliureBlock:(QNFailureBlock)failure;

- (void)getSongListWithArtistId:(NSString *)artistId withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getAlbumListWithAlbumId:(NSString *)albumId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getGenreListWithGenreId:(NSString *)genreId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getRecentListWithPageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getMyFavoriteListWithSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getUPNPListWithLinkId:(NSString *)linkId withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)fetchingMultimediaImage:(NSString *)imagePath withSuccessBlock:(void(^)(UIImage *image))success withFailureBlock:(void(^)(NSError *error))failure withInProgressBlock:(QNInProgressBlock)inProgress;

- (void)searchSongListWithKeyword:(NSString *)keyword withQueryType:(QNSearchSongType)searchType withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getFileWithFileID:(NSString *)fId withFileExtension:(NSString *)fileExtension withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure withInProgressBlock:(QNInProgressBlock)inProgress;


@end
