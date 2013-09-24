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

/**
 *  get folder list
 *
 *  @param folderId folder id which should be aquired from folder list API; nil to fetch folder list under root directory.
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)getFolderListWithFolderID:(NSString* )folderId withSuccessBlock:(QNSuccessBlock)success withFaliureBlock:(QNFailureBlock)failure;

/**
 *  get Song list from NAS
 *
 *  @param artistId artist id; return all songs if artistId is nil.
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)getSongListWithArtistId:(NSString *)artistId withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get album list from NAS
 *
 *  @param albumId  Any specified album. List all albums if this parameter is nil.
 *  @param pageSize counts of per page
 *  @param currPage current page
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)getAlbumListWithAlbumId:(NSString *)albumId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get genre list
 *
 *  @param genreId  Give this parameter if any specified genre you want. List all genres if nil.
 *  @param pageSize counts of per page
 *  @param currPage current page
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)getGenreListWithGenreId:(NSString *)genreId pageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get recent play list.
 *
 *  @param pageSize counts of per page
 *  @param currPage current page
 *  @param success  success block
 *  @param failure  failure block
 */
- (void)getRecentListWithPageSize:(NSInteger)pageSize currPage:(NSInteger)currPage withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get the favorite play list. Edit this list via NAS user interface.
 *
 *  @param success success block
 *  @param failure failure block
 */
- (void)getMyFavoriteListWithSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Get UPNP list
 *
 *  @param linkId  If list, all UPNP server will not use this parameter.
 *  @param success success block
 *  @param failure failure block
 */
- (void)getUPNPListWithLinkId:(NSString *)linkId withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  Download an image.
 *
 *  @param imagePath  image path
 *  @param success    success block, the type of return value
 *  @param failure    failure block
 *  @param inProgress the progress while downloading
 */
- (void)fetchingMultimediaImage:(NSString *)imagePath withSuccessBlock:(void(^)(UIImage *image))success withFailureBlock:(void(^)(NSError *error))failure withInProgressBlock:(QNInProgressBlock)inProgress;

/**
 *  search the song name
 *
 *  @param keyword    the keyword of the song
 *  @param searchType QNSearchSonyType, including name, album, artist
 *  @param success    success block
 *  @param failure    failure block
 */
- (void)searchSongListWithKeyword:(NSString *)keyword withQueryType:(QNSearchSongType)searchType withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

/**
 *  download a file
 *
 *  @param fId           LinkID for file
 *  @param fileExtension File extension
 *  @param success       success block
 *  @param failure       failure block
 *  @param inProgress    the progress while downloading
 */
- (void)getFileWithFileID:(NSString *)fId withFileExtension:(NSString *)fileExtension withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure withInProgressBlock:(QNInProgressBlock)inProgress;


@end
