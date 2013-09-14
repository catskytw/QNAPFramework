//
//  QNFolder.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNFolder : NSManagedObject

@property (nonatomic, retain) NSString * parentFolder;
@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * fileType;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * linkID;
@property (nonatomic, retain) NSString * imagePath;

@end
