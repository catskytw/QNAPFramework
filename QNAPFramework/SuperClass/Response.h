//
//  Response.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/4.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Response : NSManagedObject

@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSString * message;

@end
