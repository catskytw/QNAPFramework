//
//  QNAPFrameworkTests.m
//  QNAPFrameworkTests
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPFrameworkTests.h"
#import <CocoaLumberjack/DDLog.h>
#import <Expecta/Expecta.h>

#define MyCloudServerBaseURL @"http://core.api.alpha-myqnapcloud.com"
#define CLIENT_ID @"521c609775413f6bfec8e59b"
#define CLIENT_SECRET @"LWvRWyHFNDENTZZGCp9kcOEGed18cW02KVnV6bfrvtBL0hpu"
#define EXP_SHORTHAND YES

static const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation QNAPFrameworkTests

- (void)setUp
{
    [super setUp];
    [Expecta setAsynchronousTestTimeout:10];

    self.myCloudManager = [[QNMyCloudManager alloc] initWithMyCloudBaseURL:[NSURL URLWithString:MyCloudServerBaseURL]
                                                              withClientId:CLIENT_ID
                                                          withClientSecret:CLIENT_SECRET];
    [self.myCloudManager fetchOAuthToken:^(AFOAuthCredential *credential){
        
    }
                        withFailureBlock:^(NSError *error){}];

}

- (void)tearDown
{
    self.myCloudManager = nil;
    [super tearDown];
}

#pragma mark - TestCase
- (void)notTestToken
{
    __block AFOAuthCredential *_credential = nil;
    [self.myCloudManager fetchOAuthToken:^(AFOAuthCredential *credential){
        DDLogInfo(@"credential %@", credential.accessToken);
        _credential = credential;
    }
                        withFailureBlock:^(NSError *error){
                            _credential = [AFOAuthCredential new];
                            DDLogError(@"error while acquiring accessToken %@", error);
                        }
     ];
    EXP_expect(_credential).willNot.beNil();
}

- (void)testReadMyInformation{
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager readMyInformation: ^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        _operation = operation;
        DDLogInfo(@"readMyInformation success: %@", operation.mappingResult);
    } withFailiureBlock:^(RKObjectRequestOperation *operation, NSError *error){
        _operation = operation;
        DDLogError(@"readMyInformation failure: %@", operation);
    }];
    
    EXP_expect(_operation).willNot.beNil();
}
@end
