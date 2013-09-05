//
//  Response.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/5.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Response : NSManagedObject

@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSString * message;

@end
