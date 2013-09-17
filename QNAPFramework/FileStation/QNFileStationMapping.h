//
//  QNFileStationMapping.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/9.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>

@interface QNFileStationMapping : QNMappingProtoType
+ (RKEntityMapping *)mappingForLogin;
+ (RKEntityMapping *)mappingForLoginError;
+ (RKEntityMapping *)mappingForSearchFiles;
+ (NSDictionary *)allMappingInAuthLogin;
+ (RKDynamicMapping *)dynamicMappingLoginWithCorrectMapping:(RKEntityMapping *)correctResponseMapping withErrorResponseMapping:(RKEntityMapping *)errorMapping;
@end
