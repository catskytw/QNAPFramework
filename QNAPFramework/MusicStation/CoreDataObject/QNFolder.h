//
//  QNFolder.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/16.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class QNFolderSummary;

@interface QNFolder : NSManagedObject

@property (nonatomic, retain) NSString * fileName;
@property (nonatomic, retain) NSString * fileType;
@property (nonatomic, retain) NSString * imagePath;
@property (nonatomic, retain) NSString * linkID;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * extension;
@property (nonatomic, retain) NSNumber * songID;
@property (nonatomic, retain) NSNumber * audio_playtime;
@property (nonatomic, retain) NSString * artist;
@property (nonatomic, retain) NSString * album;
@property (nonatomic, retain) NSString * albumartist;
@property (nonatomic, retain) NSNumber * tracknumber;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSNumber * year;
@property (nonatomic, retain) NSNumber * useCount;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSNumber * formatid;
@property (nonatomic, retain) NSString * filePath;
@property (nonatomic, retain) NSNumber * mediaType;
@property (nonatomic, retain) QNFolderSummary *relationship_QNFolderSummary;

@end
