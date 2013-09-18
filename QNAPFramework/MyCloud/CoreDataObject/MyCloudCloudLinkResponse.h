//
//  MyCloudCloudLinkResponse.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/18.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyCloudCloudLinkResponse : NSManagedObject

@property (nonatomic, retain) NSString * cloud_link_id;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * device_id;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSDate * updated_at;
@property (nonatomic, retain) NSString * user_id;
@property (nonatomic, retain) NSString * version;

@end
