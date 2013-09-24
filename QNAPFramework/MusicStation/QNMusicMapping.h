//
//  QNMusicMapping.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNMappingProtoType.h"

@interface QNMusicMapping : QNMappingProtoType

/**
 *  mapping for getFolderList
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForFolder;

/**
 *  mapping for Error. In musicStation, there is a common format for error message.
 *  Thus we create a mapping to save error code and error message.
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForError;

/**
 *  Dynamic mapping for multimedia login.
 *
 *  @return DynamicMapping
 */
+ (RKDynamicMapping *)dynamicMappingForMultiMediaLogin;

/**
 *  mapping for correct multimedia login response.
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForMultimediaLogin;

/**
 *  mapping for multimedia login
 *
 *  @return RKEntityMapping
 */
+ (RKEntityMapping *)mappingForMultimediaLoginInfo;

@end
