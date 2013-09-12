//
//  QNFileLoginError.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/12.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFileLoginError : NSManagedObject

@property (nonatomic, retain) NSString * doQuick;
@property (nonatomic, retain) NSNumber * is_booting;
@property (nonatomic, retain) NSNumber * authPassed;
@property (nonatomic, retain) NSString * errorValue;
@property (nonatomic, retain) NSString * username;

@end
