//
//  QNAPFrameworkTests.m
//  QNAPFrameworkTests
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPFrameworkTests.h"
#import <CocoaLumberjack/DDLog.h>

#define CLIENT_ID @""
#define CLIENT_SECRET @""

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QNAPFrameworkTests

- (void)setUp
{
    [super setUp];
    self.myCloudManager = [[QNMyCloudManager alloc] initWithMyCloudBaseURL:[NSURL URLWithString:@"http://core.api.alpha-myqnapcloud.com"]
                                                              withClientId:CLIENT_ID
                                                          withClientSecret:CLIENT_SECRET];
}

- (void)tearDown
{
    self.myCloudManager = nil;
    [super tearDown];
}

#pragma mark - TestCase
- (void)testToken
{
    [self.myCloudManager fetchOAuthToken:^(AFOAuthCredential *credential){
        DDLogInfo(@"credential %@", credential.accessToken);
    }
                        withFailureBlock:^(NSError *error){
                            DDLogError(@"error while acquiring accessToken %@", error);
                        }];
}

@end
