//
//  QNFileCustomLogo.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/11.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFileCustomLogo : NSManagedObject

@property (nonatomic, retain) NSString * customFrontLogo;
@property (nonatomic, retain) NSString * customLoginLogo;

@end
