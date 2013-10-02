//
//  QNVideoTimeLine.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/10/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNVideoDateItem;

@interface QNVideoTimeLine : NSManagedObject

@property (nonatomic, retain) NSString * yearMonth;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSNumber * count;
@property (nonatomic, retain) NSString * month;
@property (nonatomic, retain) NSSet *relationship_dateItem;
@end

@interface QNVideoTimeLine (CoreDataGeneratedAccessors)

- (void)addRelationship_dateItemObject:(QNVideoDateItem *)value;
- (void)removeRelationship_dateItemObject:(QNVideoDateItem *)value;
- (void)addRelationship_dateItem:(NSSet *)values;
- (void)removeRelationship_dateItem:(NSSet *)values;

@end
