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
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>
#import "SettingInfo.h"

#define EXP_SHORTHAND YES

@implementation QNAPFrameworkTests

- (void)setUp {

    
    [super setUp];
    [Expecta setAsynchronousTestTimeout:10];
    NSURL *resourceURL = [[NSBundle mainBundle] URLForResource:@"QNAPFrameworkBundle" withExtension:@"bundle"];
    NSBundle *qnapResourceBundle = [NSBundle bundleWithURL: resourceURL];
    [[QNAPCommunicationManager share] settingMisc: qnapResourceBundle];

    self.myCloudManager = [[QNAPCommunicationManager share] factoryForMyCloudManager:MyCloudServerBaseURL withClientId:CLIENT_ID withClientSecret:CLIENT_SECRET];
    [self.myCloudManager fetchOAuthToken:ACCOUNT
                            withPassword:PASSWORD
                        withSuccessBlock:^(AFOAuthCredential *credential) {
                            DDLogVerbose(@"credential success %@", credential.accessToken);
                        }
                        withFailureBlock:^(NSError *error){
                            DDLogError(@"token failure: %@", error);
                        }];
    EXP_expect(self.myCloudManager.rkObjectManager).willNot.beNil();

}

- (void)tearDown {
    self.myCloudManager = nil;
    [QNAPCommunicationManager closeCommunicationManager];
    
    [super tearDown];
}

#pragma mark - TestCase
- (void)notTestToken {
    __block AFOAuthCredential *_credential = nil;
    [self.myCloudManager fetchOAuthToken:^(AFOAuthCredential *credential) {
        DDLogInfo(@"credential %@", credential.accessToken);
        _credential = credential;
    }
                        withFailureBlock:^(NSError *error) {
                            _credential = [AFOAuthCredential new];
                            DDLogError(@"error while acquiring accessToken %@", error);
                        }
    ];
    EXP_expect(_credential).willNot.beNil();
}

- (void)testReadMyInformation {
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager readMyInformation:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        _operation = operation;
    }                    withFailiureBlock:^(RKObjectRequestOperation *operation, NSError *error) {
        
    }];

    EXP_expect(_operation).willNot.beNil();
}
@end
