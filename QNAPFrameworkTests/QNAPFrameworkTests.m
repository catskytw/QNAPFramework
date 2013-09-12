//
//  QNAPFrameworkTests.m
//  QNAPFrameworkTests
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPFrameworkTests.h"
#import <CocoaLumberjack/DDLog.h>
#define EXP_SHORTHAND YES

#import <Expecta/Expecta.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <MagicalRecord/MagicalRecord.h>
#import "SettingInfo.h"
#import "UserActivity.h"
#import "App.h"
#import "Response.h"
@implementation QNAPFrameworkTests

- (void)setUp {
    __block NSNumber *isFetchToken = nil;
    __block NSNumber *isFetchSid = nil;
    [super setUp];
    [Expecta setAsynchronousTestTimeout:10000];
    [[QNAPCommunicationManager share] settingMisc: nil];
    self.myCloudManager = [[QNAPCommunicationManager share] factoryForMyCloudManager:MyCloudServerBaseURL
                                                                        withClientId:CLIENT_ID
                                                                    withClientSecret:CLIENT_SECRET];
    [self.myCloudManager fetchOAuthToken:MyCloud_ACCOUNT
                            withPassword:MyCloud_PASSWORD
                        withSuccessBlock:^(AFOAuthCredential *credential){
                            isFetchToken = @YES;
                        }withFailureBlock:^(NSError *error){
                            
                        }];
    self.fileManager = [[QNAPCommunicationManager share] factoryForFileStatioAPIManager:NASURL];
    [self.fileManager loginWithAccount:NAS_ACCOUNT
                          withPassword:NAS_PASSWORD
                      withSuccessBlock:^(RKObjectRequestOperation *operaion, RKMappingResult *mappingResult, QNFileLogin *login){
                          isFetchSid = @YES;
                      }
                      withFailureBlock:nil];
    expect(isFetchToken).willNot.beNil();    
    expect(isFetchSid).willNot.beNil();
    
}

- (void)tearDown {
    self.myCloudManager = nil;
    self.fileManager = nil;
    [QNAPCommunicationManager closeCommunicationManager];
    
    [super tearDown];
}

#pragma mark - TestCase
- (void)testToken {
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
    expect(_credential).willNot.beNil();
}

- (void)testMyCloudReadMyInformation {
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager readMyInformation:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        _operation = operation;
    }                    withFailiureBlock:nil];
    expect(_operation).willNot.beNil();
}

- (void)testMyCloudUpdateMyInformation{
    NSDictionary *userInfo = @{@"email":@"catskytw@gmail.com",
                               @"first_name":@"Change",
                               @"last_name":@"Chen",
                               @"mobile_number":@"0912345678",
                               @"language":@"ch",
                               @"gender":[NSNumber numberWithInt:1],
                               @"birthday":@"1976-10-20",
                               @"subscribed":[NSNumber numberWithBool:YES]
                               };
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager updateMyInformation:userInfo
                            withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                _operation = operation;
                            }
                            withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, Response *response) {
                            }];
    expect(_operation).willNot.beNil();
}

- (void)testMyCloudListMyActivities{
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager listMyActivities:0
                                withLimit:10
                                   isDesc:YES
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                             _operation = operation;
                         }
                         withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, Response *response){
                         }];
    
    expect(_operation).willNot.beNil();
}

- (void)testMyCloudChangePassword{
    __block BOOL hasResponse = NO;
    [self.myCloudManager changeMyPassword:@"12345678"
                          withNewPassword:@"12345678"
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingRestul){
                             Response *response = [mappingRestul firstObject];
                             DDLogInfo(@"changePassword response code:%@  message:%@",response.code, response.message);
                             hasResponse = YES;
                         }
                         withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, Response *response){
                             hasResponse = YES;
                         }];
    
    expect(hasResponse).willNot.beFalsy();
}

- (void)testFileManagerLogin{
    __block BOOL _hasResponse = false;
    [self.fileManager loginWithAccount:NAS_ACCOUNT
                          withPassword:NAS_PASSWORD
                      withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, QNFileLogin *login){
                          _hasResponse = true;
                          DDLogInfo(@"login information %@", login);
                      }
                      withFailureBlock:^(RKObjectRequestOperation *operation, QNFileLoginError *error){
                          _hasResponse = true;
                          if(error)
                              DDLogError(@"Error while FileStationLogin %@", error.errorValue);
                      }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testDownloadFile{
    __block BOOL _hasResponse = false;
    [self.fileManager downloadFileWithFilePath:@"/Public"
                                     withFiles:@[@"1.mov"]
                                      isFolder:NO
                                     withRange:nil
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  DDLogVerbose(@"download success");
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  DDLogError(@"download error, Error: %@", error);
                              }
                           withInProgressBlock:^(CGFloat percentage){
                               DDLogVerbose(@"download percentage is %f", percentage);
                               _hasResponse = YES;
                           }];
    expect(_hasResponse).willNot.beFalsy();
}
@end
