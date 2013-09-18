//
//  MyCloudSourceInfo.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/18.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MyCloudSourceInfo : NSManagedObject

@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * ip;
@property (nonatomic, retain) NSString * region;

@end
