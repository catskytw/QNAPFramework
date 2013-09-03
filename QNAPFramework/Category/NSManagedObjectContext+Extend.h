//
// Created by Chen-chih Liao on 13/9/3.
// Copyright (c) 2013 QNAP. All rights reserved.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface NSManagedObjectContext (Extend)
+ (void)MR_setRootSavingContext:(NSManagedObjectContext *)context;
+ (void)MR_setDefaultContext:(NSManagedObjectContext *)moc;
@end