//
//  QNAPFramework.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/DDLog.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>

@class QNSearchResponse;
@class QNFileLoginError;
@class MyCloudResponse;
@class MyCloudCloudLinkResponse;
#define CredentialIdentifier @"myCloudCredential"


#ifndef LOG_VERBOSE
extern int ddLogLevel;
#endif

/**
 *  Expent the successBlockName
 *
 *  @param classname the string of QNSuccessBlock's extention and parameter.
 *
 *  @return a specified success block with the response object's name.
 */
#ifndef QNSuccessBlockExt
#define QNSuccessBlockExt(classname) typedef void (^QNSuccessBlockExt##classname)(RKObjectRequestOperation *operation, RKMappingResult *result, classname *obj)
#endif

#ifndef QNFailureBlockExt
#define QNFailureBlockExt(classname) typedef void (^QNFailureBlockExt##classname)(RKObjectRequestOperation *operation, NSError *error, classname *obj)
#endif

#pragma mark - successBlocks
QNSuccessBlockExt(QNSearchResponse);
QNSuccessBlockExt(MyCloudCloudLinkResponse);

#pragma mark - failureBlocks
QNFailureBlockExt(QNFileLoginError);
QNFailureBlockExt(MyCloudResponse);
/**
 *  success block executing after API success
 *
 *  @param ^QNSuccessBlock RKObjectRequestOperation and RKObjectMapping, you can access the return objects from mappingResult
 */
typedef void (^QNSuccessBlock)(RKObjectRequestOperation *operation, RKMappingResult *mappingResult);

/**
 *  Failure block executing after API failure, maybe including client error or server error.
 *
 *  @param ^QNFailureBlock <#^QNFailureBlock description#>
 */

typedef void (^QNFailureBlock)(RKObjectRequestOperation *operation, NSError *error);

/**
 *  <#Description#>
 */
typedef void (^QNInProgressBlock)(long long totalBytesRead, long long totalBytesExpectedToRead);