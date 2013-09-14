//
//  QNMusicMapping.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"

@interface QNMusicMapping : QNMappingProtoType

+ (RKEntityMapping *)mappingForFolder;
+ (RKEntityMapping *)mappingForError;
+ (RKDynamicMapping *)dynamicMappingForMultiMediaLogin;

+ (RKEntityMapping *)mappingForMultimediaLogin;
+ (RKEntityMapping *)mappingForMultimediaLoginInfo;

@end
