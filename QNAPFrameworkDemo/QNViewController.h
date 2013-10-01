//
//  QNViewController.h
//  QNAPFrameworkDemo
//
//  Created by Chen-chih Liao on 13/9/4.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QNMyCloudManager.h"
#import "QNFileStationAPIManager.h"
#import "QNMusicStationAPIManager.h"
#import "QNVideoStationAPIManager.h"

@interface QNViewController : UIViewController
@property QNMyCloudManager *myCloudManager;
@property QNFileStationAPIManager *fileStationManager;
@property QNMusicStationAPIManager *musicStationManager;
@property QNVideoStationAPIManager *videoStationManager;

@property IBOutlet UILabel *loginLabel;
@property IBOutlet UILabel *downloadPercent;
@property IBOutlet UIButton *downloadBtn;

- (IBAction)downloadSampleFile:(id)sender;
@end
