//
//  MyCloudUser.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/18.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyCloudUser : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * mobile_number;
@property (nonatomic, retain) NSNumber * subscribed;

@end
