//
//  QNVideoDateItem.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/10/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNVideoDateItem : NSManagedObject

@property (nonatomic, retain) NSString * date;
@property (nonatomic, retain) NSNumber * count;

@end
