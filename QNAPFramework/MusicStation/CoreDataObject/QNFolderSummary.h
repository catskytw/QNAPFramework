//
//  QNFolderSummary.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/16.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNFolder;

@interface QNFolderSummary : NSManagedObject

@property (nonatomic, retain) NSNumber * totalCounts;
@property (nonatomic, retain) NSNumber * currPage;
@property (nonatomic, retain) NSString * pageSize;
@property (nonatomic, retain) NSSet *relationship_QNFolder;
@end

@interface QNFolderSummary (CoreDataGeneratedAccessors)

- (void)addRelationship_QNFolderObject:(QNFolder *)value;
- (void)removeRelationship_QNFolderObject:(QNFolder *)value;
- (void)addRelationship_QNFolder:(NSSet *)values;
- (void)removeRelationship_QNFolder:(NSSet *)values;

@end
