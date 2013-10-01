//
//  QNVideoMapping.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/27.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"
#import <RestKit/RestKit.h>
@interface QNVideoMapping : QNMappingProtoType
+ (RKEntityMapping *)mappingForGetAllVideoList;
@end
