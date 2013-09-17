//
//  QNSearchResponse.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/17.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNSearchFileInfo;

@interface QNSearchResponse : NSManagedObject

@property (nonatomic, retain) NSNumber * medialib;
@property (nonatomic, retain) NSNumber * total;
@property (nonatomic, retain) NSNumber * acl;
@property (nonatomic, retain) NSNumber * is_acl_enable;
@property (nonatomic, retain) NSNumber * is_winacl_support;
@property (nonatomic, retain) NSNumber * is_winacl_enable;
@property (nonatomic, retain) NSNumber * rtt_support;
@property (nonatomic, retain) NSSet *relationship_QNSearchFileInfo;
@end

@interface QNSearchResponse (CoreDataGeneratedAccessors)

- (void)addRelationship_QNSearchFileInfoObject:(QNSearchFileInfo *)value;
- (void)removeRelationship_QNSearchFileInfoObject:(QNSearchFileInfo *)value;
- (void)addRelationship_QNSearchFileInfo:(NSSet *)values;
- (void)removeRelationship_QNSearchFileInfo:(NSSet *)values;

@end
