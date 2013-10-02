//
//  QNVideoTimeLineResponse.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/10/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNVideoTimeLine;

@interface QNVideoTimeLineResponse : NSManagedObject

@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * queries;
@property (nonatomic, retain) NSSet *relationship_timeLine;
@end

@interface QNVideoTimeLineResponse (CoreDataGeneratedAccessors)

- (void)addRelationship_timeLineObject:(QNVideoTimeLine *)value;
- (void)removeRelationship_timeLineObject:(QNVideoTimeLine *)value;
- (void)addRelationship_timeLine:(NSSet *)values;
- (void)removeRelationship_timeLine:(NSSet *)values;

@end
