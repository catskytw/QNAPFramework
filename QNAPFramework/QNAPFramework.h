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
#define CredentialIdentifier @"myCloudCredential"


#ifndef LOG_VERBOSE
extern int ddLogLevel;
#endif

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