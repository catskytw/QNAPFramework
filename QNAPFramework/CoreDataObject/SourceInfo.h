//
//  SourceInfo.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/5.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SourceInfo : NSManagedObject

@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * ip;
@property (nonatomic, retain) NSString * region;

@end
