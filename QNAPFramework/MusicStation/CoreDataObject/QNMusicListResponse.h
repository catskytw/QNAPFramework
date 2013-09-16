//
//  QNMusicListResponse.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/16.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNFolderSummary;

@interface QNMusicListResponse : NSManagedObject

@property (nonatomic, retain) NSNumber *status;
@property (nonatomic, retain) QNFolderSummary *relationship_QNFolderSummary;

@end
