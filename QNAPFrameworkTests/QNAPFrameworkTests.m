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
#import "QNAPFramework.h"
#import "SettingInfo.h"
#import "QNAppDelegate.h"
#import "QNAPFrameworkUtil.h"
#import "QNMusicListResponse.h"
#import "QNFolderSummary.h"
#import "QNFolder.h"
#import "MyCloudCloudLinkResponse.h"
#import "QNSearchFileInfo.h"
@implementation QNAPFrameworkTests

- (void)setUp {
    [super setUp];
    [Expecta setAsynchronousTestTimeout:10];
    QNAppDelegate *appDelegate = (QNAppDelegate *)[[UIApplication sharedApplication] delegate ];
    self.viewController = (QNViewController *)appDelegate.window.rootViewController;
    
    self.myCloudManager = self.viewController.myCloudManager;
    self.fileManager = self.viewController.fileStationManager;
    self.musicManager = self.viewController.musicStationManager;    
    [[QNAPCommunicationManager share] settingMisc: nil];
    
    NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:5];
    [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    
}

- (void)tearDown {
    self.myCloudManager = nil;
    self.fileManager = nil;
    [super tearDown];
}

#pragma mark - MyCloud TestCase
- (void)testCase999_MyCloudFetchingToken {
    //we should always test this function at the last case(set up the name as testCase999), or interference other mycloudAPIs testing.
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
    while (!_credential.accessToken) {
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    }
}

- (void)testCase12_MyCloudReadMyInformation {
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager readMyInformation:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        _operation = operation;
    }                    withFailiureBlock:nil];
    expect(_operation).willNot.beNil();
}

- (void)testCase13_MyCloudUpdateMyInformation{
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
                            withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, MyCloudResponse *response) {
                            }];
    expect(_operation).willNot.beNil();
}

- (void)testCase14_MyCloudListMyActivities{
    __block RKObjectRequestOperation *_operation = nil;
    [self.myCloudManager listMyActivities:0
                                withLimit:10
                                   isDesc:YES
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                             _operation = operation;
                         }
                         withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, MyCloudResponse *response){
                         }];
    
    expect(_operation).willNot.beNil();
}

- (void)testCase15_MyCloudChangePassword{
    __block BOOL hasResponse = NO;
    [self.myCloudManager changeMyPassword:@"12345678"
                          withNewPassword:@"12345678"
                         withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingRestul){
                             MyCloudResponse *response = [mappingRestul firstObject];
                             DDLogInfo(@"changePassword response code:%@  message:%@",response.code, response.message);
                             hasResponse = YES;
                         }
                         withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error, MyCloudResponse *response){
                             hasResponse = YES;
                         }];
    
    expect(hasResponse).willNot.beFalsy();
}

- (void)testCase16_MyCloudGetCloudLink{
    __block BOOL _finished = NO;
    [self.myCloudManager getCloudLinkWithOffset:0
                                      withLimit:0
                                ithSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, MyCloudCloudLinkResponse *cloudlink){
                                    _finished = YES;
                                    DDLogVerbose(@"myCloudLink %@", cloudlink.cloud_link_id);
                                }
                               withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                   DDLogError(@"myCloudLink Error: %@", error);
                                   _finished = NO;
                               }];
    expect(_finished).willNot.beFalsy();
}
#pragma mark - FileManager TestCase
- (void)testCase9999_FileManagerLogin{
    __block BOOL _hasResponse = false;
    [self.fileManager loginWithAccount:NAS_ACCOUNT
                          withPassword:NAS_PASSWORD
                      withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult, QNFileLogin *login){
                          _hasResponse = true;
                          DDLogInfo(@"login information %@", login.authSid);
                      }
                      withFailureBlock:^(RKObjectRequestOperation *operation, QNFileLoginError *error){
                          _hasResponse = true;
                          if(error)
                              DDLogError(@"Error while FileStationLogin %@", error.errorValue);
                      }];
    while (!self.fileManager.authSid) {
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    }
}

- (void)testCase20_FileManagerDownloadFile{
    __block BOOL _hasDownload = false;
    [self.fileManager downloadFileWithFilePath:@"/Public"
                                  withFileName:@"1.mov"
                                      isFolder:NO
                                     withRange:nil
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  DDLogVerbose(@"download success");
                                  _hasDownload = YES;
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  DDLogError(@"download error, Error: %@", error);
                                  _hasDownload = YES;
                              }
                           withInProgressBlock:^(long long totalBytesRead, long long totalBytesExpectedToRead){
                               DDLogVerbose(@"download file progress %lldbytes/%lldbytes", totalBytesRead, totalBytesExpectedToRead);
                               _hasDownload = YES;
                           }];
    expect(_hasDownload).willNot.beFalsy();
//    while (!_hasDownload){
//        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
//        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
//    }
}

- (void)testCase21_FileManagerDownloadThumbnail{
    __block BOOL _hasDownload = NO;
    [self.fileManager thumbnailWithFile:@"1.JPG"
                               withPath:@"/Public"
                       withSuccessBlock:^(UIImage *image){
                           DDLogVerbose(@"received thumbnailImage %@", image);
                           _hasDownload = YES;
                       }
                       withFailureBlock:^(NSError *error){
                           DDLogError(@"received thumbnail failiure %@", error);
                           _hasDownload = YES;
                       }
                    withInProgressBlock:^(NSUInteger receivedSize, long long expectedSize){
                        DDLogVerbose(@"received thumbnail %i bytes/%lld bytes", receivedSize, expectedSize);
                    }];
    while (!_hasDownload){
        NSDate* nextTry = [NSDate dateWithTimeIntervalSinceNow:0.1];
        [[NSRunLoop currentRunLoop] runUntilDate:nextTry];
    }
}

- (void)testCase22_FileManagerSearchFiles{
    __block BOOL _finished = NO;
    [self.fileManager searchFiles:@"mp3"
                   withSourcePath:@"/Multimedia"
                    withSortField:QNFileModefiedTimeSort
                  withLimitNumber:20
                   withStartIndex:0
                            isASC:NO
                 withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *result, QNSearchResponse *obj){
                     _finished = YES;
                 }withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                     _finished = YES;
                 }];
     expect(_finished).willNot.beFalsy();
}
#pragma mark - MusicStationManager TestCase
- (void)testCase30_MusicManagerGetFolderList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getFolderListWithFolderID:nil
                                withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                    _hasResponse = YES;
                                    [self analysisMusicResponse:[mappingResult firstObject]];
                                }
                                withFaliureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                    _hasResponse = YES;
                                }];
    expect(_hasResponse).willNot.beFalsy();

}

- (void)testCase31_MusicManagerGetSongList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getSongListWithArtistId:nil
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  _hasResponse = YES;
                                  [self analysisMusicResponse:[mappingResult firstObject]];
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  _hasResponse = YES;
                              }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase32_MusicManagerGetAlbumList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getAlbumListWithAlbumId:nil
                                      pageSize:10
                                      currPage:0
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  _hasResponse = YES;
                                  [self analysisMusicResponse:[mappingResult firstObject]];
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  _hasResponse = YES;
                              }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase33_MusicManagerGetGenreList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getGenreListWithGenreId:nil
                                      pageSize:10
                                      currPage:0
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  _hasResponse = YES;
                                  [self analysisMusicResponse:[mappingResult firstObject]];
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  _hasResponse = YES;
                              }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase34_MusicManagerGetRecentList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getRecentListWithPageSize:10
                                        currPage:0
                              withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                  _hasResponse = YES;
                                  [self analysisMusicResponse:[mappingResult firstObject]];
                              }
                              withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                  _hasResponse = YES;
                              }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase35_MusicManagerGetFavoriteList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getMyFavoriteListWithSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
        _hasResponse = YES;
        [self analysisMusicResponse:[mappingResult firstObject]];
    }
                                        withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                            _hasResponse = YES;
                                        }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase36_MusicManagerGetUPNPList{
    __block BOOL _hasResponse = NO;
    [self.musicManager getUPNPListWithLinkId:nil
                            withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                                _hasResponse = YES;
                                [self analysisMusicResponse:[mappingResult firstObject]];
                            }
                            withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                                _hasResponse = NO;
                            }];
    expect(_hasResponse).willNot.beFalsy();
}

- (void)testCase37_MusicManagerGetFile{
    __block BOOL _hasResponse = NO;
    [self.musicManager getFileWithFileID:@"4"
                       withFileExtension:@""
                        withSuccessBlock:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult){
                            _hasResponse = YES;
                        }
                        withFailureBlock:^(RKObjectRequestOperation *operation, NSError *error){
                            _hasResponse = NO;
                        }
                     withInProgressBlock:^(long long totalBytesRead, long long totalBytesExpectedToRead){
                         DDLogVerbose(@"MusicManager Get File received data: %lld/%lld", totalBytesRead, totalBytesExpectedToRead);
                         _hasResponse = YES;
                     }];
    expect(_hasResponse).willNot.beFalsy();
}

#pragma mark - Private Methods
- (void)analysisMusicResponse:(QNMusicListResponse *)response{
    DDLogVerbose(@"QNFolderSummary pageSize:%@, totalCount: %i", [[response relationship_QNFolderSummary] pageSize], [[[response relationship_QNFolderSummary] relationship_QNFolder] count]);
}

@end
