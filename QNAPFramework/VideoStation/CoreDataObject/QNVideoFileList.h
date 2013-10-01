//
//  QNVideoFileList.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/10/1.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNVideoFileItem;

@interface QNVideoFileList : NSManagedObject

@property (nonatomic, retain) NSString * keywordList;
@property (nonatomic, retain) NSString * queries;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * videoCount;
@property (nonatomic, retain) NSSet *relationship_FileItem;
@end

@interface QNVideoFileList (CoreDataGeneratedAccessors)

- (void)addRelationship_FileItemObject:(QNVideoFileItem *)value;
- (void)removeRelationship_FileItemObject:(QNVideoFileItem *)value;
- (void)addRelationship_FileItem:(NSSet *)values;
- (void)removeRelationship_FileItem:(NSSet *)values;

@end
