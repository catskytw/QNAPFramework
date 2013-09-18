//
//  MyCloudUserActivity.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/18.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MyCloudApp, MyCloudSourceInfo;

@interface MyCloudUserActivity : NSManagedObject

@property (nonatomic, retain) NSString * action;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) id metadata;
@property (nonatomic, retain) NSString * user_activity_id;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) MyCloudApp *relationship_App;
@property (nonatomic, retain) MyCloudSourceInfo *relationship_SourceInfo;

@end
