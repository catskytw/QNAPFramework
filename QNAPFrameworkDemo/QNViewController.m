//
//  QNViewController.m
//  QNAPFrameworkDemo
//
//  Created by Chen-chih Liao on 13/9/4.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNViewController.h"
#import "QNAPCommunicationManager.h"
#import <CocoaLumberjack/DDLog.h>

#define MyCloudServerBaseURL @"http://core.api.alpha-myqnapcloud.com"
#define CLIENT_ID @"521c609775413f6bfec8e59b"
#define CLIENT_SECRET @"LWvRWyHFNDENTZZGCp9kcOEGed18cW02KVnV6bfrvtBL0hpu"
int ddLogLevel = LOG_LEVEL_VERBOSE;

@interface QNViewController ()

@end

@implementation QNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *resourceURL = [[NSBundle mainBundle] URLForResource:@"QNAPFrameworkBundle" withExtension:@"bundle"];
    NSBundle *qnapResourceBundle = [NSBundle bundleWithURL: resourceURL];
    [[QNAPCommunicationManager share] settingMisc: qnapResourceBundle];
    self.myCloudManager = [[QNAPCommunicationManager share] factoryForMyCloudManager:MyCloudServerBaseURL withClientId:CLIENT_ID withClientSecret:CLIENT_SECRET];
    [self.myCloudManager
     fetchOAuthToken:^(AFOAuthCredential *credential) {
         DDLogInfo(@"credential %@", credential.accessToken);
         [self.myCloudManager readMyInformation:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
             DDLogInfo(@"readMyInformation success: %@", operation.mappingResult);
         }                    withFailiureBlock:^(RKObjectRequestOperation *operation, NSError *error) {
             DDLogError(@"readMyInformation failure: %@", operation);
         }];
     }
     withFailureBlock:^(NSError *error) {
         
     }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
