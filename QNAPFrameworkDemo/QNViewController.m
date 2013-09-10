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
#import "SettingInfo.h"

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
    [self.myCloudManager fetchOAuthToken:ACCOUNT
                            withPassword:PASSWORD
                        withSuccessBlock:^(AFOAuthCredential *credential) {
                            [self.myCloudManager readMyInformation:^(RKObjectRequestOperation *operation, RKMappingResult *result){
                            }
                                                 withFailiureBlock:^(RKObjectRequestOperation *operation, NSError *error, Response *response){
                                                 }];
                        }
                        withFailureBlock:^(NSError *error){
                            DDLogError(@"token failure: %@", error);
                        }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
