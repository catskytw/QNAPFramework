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

@interface QNMusicStationAPIManager : QNModuleBaseObject

/**
 *  Login for fetching multimedia sid. No doubt about it, you can do anything you want in success block or failure block.
 *
 *  @param account  <#account description#>
 *  @param password <#password description#>
 *  @param success  <#success description#>
 *  @param failure  <#failure description#>
 */
- (void)loginForMultimediaSid:(NSString *)account withPassword:(NSString *)password withSuccessBlock:(QNSuccessBlock)success withFailureBlock:(QNFailureBlock)failure;

- (void)getFolderListWithFolderID:(NSString* )folderId withSuccessBlock:(QNSuccessBlock)success withFaliureBlock:(QNFailureBlock)failure;
@end
