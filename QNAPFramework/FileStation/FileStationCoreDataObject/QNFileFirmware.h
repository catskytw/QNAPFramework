//
//  QNFileFirmware.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/11.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFileFirmware : NSManagedObject

@property (nonatomic, retain) NSString * build;
@property (nonatomic, retain) NSString * buildTime;
@property (nonatomic, retain) NSString * version;

@end
