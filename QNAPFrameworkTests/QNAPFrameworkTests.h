//
//  QNAPFrameworkTests.h
//  QNAPFrameworkTests
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "QNAPCommunicationManager.h"
#import "QNViewController.h"


@interface QNAPFrameworkTests : SenTestCase
@property QNViewController *viewController;
@property QNAPCommunicationManager *communicationManager;
@property QNMyCloudManager *myCloudManager;
@property QNFileStationAPIManager *fileManager;
@property QNMusicStationAPIManager *musicManager;
@end
