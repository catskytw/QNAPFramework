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
#import <RestKit/RestKit.h>
#import "QNAPFrameworkUtil.h"
#import "QNAPFramework.h"

@interface QNViewController ()

@end

@implementation QNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[QNAPCommunicationManager share] activateAllStation:@{
     @"NASURL":NASURL,
     @"MyCloudURL":MyCloudServerBaseURL,
     @"ClientId":CLIENT_ID,
     @"ClientSecret":CLIENT_SECRET,
     @"NASAccount":NAS_ACCOUNT,
     @"NASPassword":NAS_PASSWORD,
     @"MyCloudAccount":MyCloud_ACCOUNT,
     @"MyCloudPassword":MyCloud_PASSWORD
     }];
    
    self.fileStationManager = [QNAPCommunicationManager share].fileStationsManager;
    self.myCloudManager = [QNAPCommunicationManager share].myCloudManager;
    self.musicStationManager = [QNAPCommunicationManager share].musicStationManager;

    [self.musicStationManager loginForMultimediaSid:NAS_ACCOUNT
                                       withPassword:NAS_PASSWORD
                                   withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                       [self.loginLabel setText:@"登入成功"];
                                   }
                                   withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                       [self.loginLabel setText:@"登入失敗"];
                                   }];

    [self.fileStationManager loginWithAccount:NAS_ACCOUNT
                                 withPassword:NAS_PASSWORD
                             withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, QNFileLogin *login){
                                 [self.loginLabel setText:@"登入成功"];
                             }
                             withFailureBlock:^(RKObjectRequestOperation *operation, QNFileLoginError *error){
                                 [self.loginLabel setText:@"登入失敗"];
                             }];
    
    [self.myCloudManager fetchOAuthToken:MyCloud_ACCOUNT
                            withPassword:MyCloud_PASSWORD
                        withSuccessBlock:^(AFOAuthCredential *credential){
                            
                        } withFailureBlock:^(NSError *error){
                            
                        }];
//    [QNAPFrameworkUtil waitUntilConditionBlock:^BOOL(){
//        return ([QNAPCommunicationManager share].sidForMultimedia && [QNAPCommunicationManager share].sidForMultimedia);
//    }];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)downloadSampleFile:(id)sender{
    [self.fileStationManager downloadFileWithFilePath:@"/Public"
                                         withFileName:@"1.mov"
                                             isFolder:NO
                                            withRange:nil
                                     withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                         [self.downloadPercent setText:@"下載完成"];
                                     }
                                     withFailureBlock:^(RKObjectRequestOperation *o, NSError *e){
                                         [self.downloadPercent setText:@"下載失敗"];
                                     }
                                  withInProgressBlock:^(long long r, long long t){
                                      CGFloat per = (CGFloat)r/(CGFloat)t;
                                      CGFloat rMB = r/1048576.0f;
                                      CGFloat tMB = t/1048576.0f;
                                      per *= 100.0f;
                                      
                                      NSString *s = [NSString stringWithFormat:@"p:%0.1f,r:%0.1f,t:%0.1f", per, rMB, tMB];
                                      [self.downloadPercent setText:s];
                                  }];
}

@end
