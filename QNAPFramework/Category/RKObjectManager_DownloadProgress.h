//
//  RKObjectManager+RKObjectManager_DownloadProgress.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/12.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "RKObjectManager.h"
#import "QNAPFramework.h"

@interface RKObjectManager (RKObjectManager_DownloadProgress)
- (void)getObject:(id)object
             path:(NSString *)path
       parameters:(NSDictionary *)parameters
          success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
          failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
       inProgress:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))inProgress;

@end
