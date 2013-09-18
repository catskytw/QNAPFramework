//
//  MyCloudResponse.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/18.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyCloudResponse : NSManagedObject

@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSString * message;

@end
