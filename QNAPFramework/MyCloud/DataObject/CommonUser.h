//
//  CommonUser.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/4.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonUser : NSObject
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * first_name;
@property (nonatomic, strong) NSString * last_name;
@property (nonatomic, strong) NSNumber * gender;
@property (nonatomic, strong) NSString * birthday;
@property (nonatomic, strong) NSString * language;
@property (nonatomic, strong) NSString * mobile_number;
@property (nonatomic, strong) NSNumber * subscribed;
@end
