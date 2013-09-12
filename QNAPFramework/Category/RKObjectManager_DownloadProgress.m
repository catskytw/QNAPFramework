//
//  RKObjectManager+RKObjectManager_DownloadProgress.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/12.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "RKObjectManager_DownloadProgress.h"
#import "RKHTTPRequestOperation.h"

@implementation RKObjectManager (RKObjectManager_DownloadProgress)
/**
 *  Send a request for downloading a file with a progress block.
 *  Limitation: You can't use ManagedObject in this method.
 *
 *  @param object     <#object description#>
 *  @param path       <#path description#>
 *  @param parameters <#parameters description#>
 *  @param success    <#success description#>
 *  @param failure    <#failure description#>
 *  @param inProgress <#inProgress description#>
 */
- (void)getObject:(id)object
             path:(NSString *)path
       parameters:(NSDictionary *)parameters
          success:(void (^)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult))success
          failure:(void (^)(RKObjectRequestOperation *operation, NSError *error))failure
       inProgress:(void(^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))inProgress
{
    NSAssert(object || path, @"Cannot make a request without an object or a path.");
    RKObjectRequestOperation *operation = [self appropriateObjectRequestOperationWithObject:object method:RKRequestMethodGET path:path parameters:parameters];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    [operation.HTTPRequestOperation setDownloadProgressBlock:inProgress];
    //TODO set Output Stream Here!
    [self enqueueObjectRequestOperation:operation];
}
@end
