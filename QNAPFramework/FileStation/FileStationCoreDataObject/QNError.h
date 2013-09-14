//
//  QNError.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNError : NSManagedObject

@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSString * errorcode;

@end
