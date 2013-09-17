//
//  QNSearchFileInfo.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/17.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface QNSearchFileInfo : NSManagedObject

@property (nonatomic, retain) NSString * filename;
@property (nonatomic, retain) NSNumber * isfolder;
@property (nonatomic, retain) NSNumber * filesize;
@property (nonatomic, retain) NSString * group;
@property (nonatomic, retain) NSString * owner;
@property (nonatomic, retain) NSNumber * iscommpressed;
@property (nonatomic, retain) NSNumber * privilege;
@property (nonatomic, retain) NSNumber * filetype;
@property (nonatomic, retain) NSString * mt;
@property (nonatomic, retain) NSNumber * epochmt;
@property (nonatomic, retain) NSNumber * qbox_type;
@property (nonatomic, retain) NSNumber * qbox_share_id_status;
@property (nonatomic, retain) NSString * qbox_share_id;
@property (nonatomic, retain) NSNumber * exist;
@property (nonatomic, retain) NSNumber * mp4_240;
@property (nonatomic, retain) NSNumber * mp4_360;
@property (nonatomic, retain) NSNumber * mp4_720;
@property (nonatomic, retain) NSNumber * trans;
@property (nonatomic, retain) NSNumber * play;

@end
