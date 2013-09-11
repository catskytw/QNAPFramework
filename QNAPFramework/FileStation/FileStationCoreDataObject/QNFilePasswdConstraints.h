//
//  QNFilePasswdConstraints.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/11.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFilePasswdConstraints : NSManagedObject

@property (nonatomic, retain) NSNumber * passwdConstraint01;
@property (nonatomic, retain) NSNumber * passwdConstraint02;
@property (nonatomic, retain) NSNumber * passwdConstraint03;
@property (nonatomic, retain) NSNumber * passwdConstraint04;

@end
