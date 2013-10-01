//
//  QNVideoFileItem.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/10/1.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNVideoFileItem : NSManagedObject

@property (nonatomic, retain) NSString * mediaType;
@property (nonatomic, retain) NSString * f_id;
@property (nonatomic, retain) NSString * cFileName;
@property (nonatomic, retain) NSString * cPictureTitle;
@property (nonatomic, retain) NSString * comment;
@property (nonatomic, retain) NSNumber * iFileSize;
@property (nonatomic, retain) NSNumber * iWidth;
@property (nonatomic, retain) NSNumber * iHeight;
@property (nonatomic, retain) NSNumber * duration;
@property (nonatomic, retain) NSNumber * dateCreated;
@property (nonatomic, retain) NSNumber * dateModified;
@property (nonatomic, retain) NSNumber * addToDbTime;
@property (nonatomic, retain) NSString * yearMonth;
@property (nonatomic, retain) NSString * yearMonthDay;
@property (nonatomic, retain) NSNumber * dateTime;
@property (nonatomic, retain) NSNumber * status;
@property (nonatomic, retain) NSNumber * transcodeStatus;
@property (nonatomic, retain) NSNumber * colorLevel;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSNumber * mask;
@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * importYearMonthDay;
@property (nonatomic, retain) NSNumber * v720P;
@property (nonatomic, retain) NSNumber * v360P;
@property (nonatomic, retain) NSNumber * v240P;
@property (nonatomic, retain) NSNumber * isNew;
@property (nonatomic, retain) NSString * mime;

@end
