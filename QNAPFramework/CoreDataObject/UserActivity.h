//
//  UserActivity.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/5.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class App, SourceInfo;

@interface UserActivity : NSManagedObject

@property (nonatomic, retain) NSString * action;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) id metadata;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * user_activity_id;
@property (nonatomic, retain) App *relationship_App;
@property (nonatomic, retain) SourceInfo *relationship_SourceInfo;

@end
