//
//  User.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/5.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * birthday;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * first_name;
@property (nonatomic, retain) NSNumber * gender;
@property (nonatomic, retain) NSString * language;
@property (nonatomic, retain) NSString * last_name;
@property (nonatomic, retain) NSString * mobile_number;
@property (nonatomic, retain) NSNumber * subscribed;

@end
