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
@interface QNFileStationAPIManager : QNModuleBaseObject{
    NSString *_authSid;
}
@property(nonatomic, strong) RKObjectManager *rkObjectManager;
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
 *  下載單一檔案.
 *  可使用Range指定下載該檔哪一部份, 可應用於續傳
 *
 *  @param filePath   檔案路徑
 *  @param fileName   檔名
 *  @param isFolder   是否為目錄
 *  @param fileRange  檔案bytes範圍, 使用nil代表全抓, 若為目錄則此選項自動為nil
 *  @param success    成功後執行之block
 *  @param failure    失敗後執行之block
 *  @param inProgress 下載中執行之block
 */
- (void)downloadFileWithFilePath:(NSString *)filePath withFileName:(NSString *)fileName isFolder:(BOOL)isFolder withRange:(NSRange *)fileRange withSuccessBlock:(void (^)(RKObjectRequestOperation *operation, RKMappingResult * mappingResult))success withFailureBlock:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure withInProgressBlock:(void(^)(long long totalBytesRead, long long totalBytesExpectedToRead))inProgress;

//You should know the relative rules of NSURL
- (void)thumbnailWithFile:(NSString *)fileName withPath:(NSString *)filePath withSuccessBlock:(void(^)(UIImage *image))success withFailureBlock:(void(^)(NSError *error))failure withInProgressBlock:(void(^)(NSUInteger receivedSize, long long expectedSize))inProgress;



@end
