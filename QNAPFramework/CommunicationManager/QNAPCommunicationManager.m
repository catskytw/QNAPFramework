//
//  QNAPCommunicationManager.m
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/2.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNAPCommunicationManager.h"
#import "NSPersistentStoreCoordinator+MagicalRecord.h"
#import "NSManagedObjectContext+Extend.h"
#import <MagicalRecord/MagicalRecord+Setup.h>
#import <RestKit/CoreData.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import "AOPProxy.h"
#import <objc/runtime.h>
#import "QNAPFrameworkUtil.h"

#import "User.h"
static QNAPCommunicationManager *singletonCommunicationManager = nil;
int ddLogLevel;

@implementation QNAPCommunicationManager

+ (QNAPCommunicationManager *)share{
    if(singletonCommunicationManager == nil){
        /**
         1. create singletonCommunicationManager
         2. binding magical record's context with AFNetworking's context(which both mean the context of CoreData)
         3. other essential settings.
         */
        singletonCommunicationManager = [QNAPCommunicationManager new];
        singletonCommunicationManager.allModules = [NSMutableArray array];
        [singletonCommunicationManager activateDebugLogLevel:LOG_LEVEL_VERBOSE];
        [singletonCommunicationManager settingMisc:nil];
        
    }
    return singletonCommunicationManager;
}
#pragma mark - FileManager Interceptor
- (BOOL)bindAllInterceptorForFileManager:(id)classInstance{
    /** TODO:
     *  Maybe we should use `class_copyMethodList(object_getClass(t), &mc)` to replace this foolish array.
     *  The only one problem is that all properties' getter and setter are included in class_copyMethodList, which might cause a deadlock if checking sidForxxx.
     *  Sigh!
     */

    NSArray *bindingMethods = @[@"loginWithAccount:withPassword:withSuccessBlock:withFailureBlock:",
                                @"downloadFileWithFilePath:withFileName:isFolder:withRange:withSuccessBlock:withFailureBlock:withInProgressBlock:",
                                @"thumbnailWithFile:withPath:withSuccessBlock:withFailureBlock:withInProgressBlock:"
                                ];
    for(NSString *methodName in bindingMethods){
        [(AOPProxy *)classInstance interceptMethodStartForSelector:NSSelectorFromString(methodName)
                                             withInterceptorTarget:self
                                               interceptorSelector:@selector(beforeInterceptorForFileManager:)];
        [(AOPProxy *)classInstance interceptMethodEndForSelector:NSSelectorFromString(methodName)
                                           withInterceptorTarget:self
                                             interceptorSelector:@selector(afterInterceptorForFileManager:)];
    }
    return YES;
}

- (BOOL) bindAllInterceptorForMyCloud:(id)classInstance{
    /** TODO:
     *  Maybe we should use `class_copyMethodList(object_getClass(t), &mc)` to replace this foolish array.
     *  The only one problem is that all properties' getter and setter are included in class_copyMethodList, which might cause a deadlock if checking sidForxxx.
     *  Sigh!
     */

    [self listAllMethod:[[QNMyCloudManager alloc] init]];
    NSArray *bindingMethods = @[@"readMyInformation:withFailiureBlock:",
                                @"updateMyInformation:withSuccessBlock:withFailureBlock:",
                                @"listMyActivities:withLimit:isDesc:withSuccessBlock:withFailureBlock:",
                                @"changeMyPassword:withNewPassword:withSuccessBlock:withFailureBlock:"
                                ];
    for(NSString *methodName in bindingMethods){
        [(AOPProxy *)classInstance interceptMethodStartForSelector:NSSelectorFromString(methodName)
                                             withInterceptorTarget:self
                                               interceptorSelector:@selector(beforeInterceptorForMyCloud:)];
        [(AOPProxy *)classInstance interceptMethodEndForSelector:NSSelectorFromString(methodName)
                                           withInterceptorTarget:self
                                             interceptorSelector:@selector(afterInterceptorForMyCloud:)];
    }
    return YES;
}


- (void)beforeInterceptorForFileManager:(NSInvocation *)i{
    /***
     This method running before any selector in fileManager instance.
     What does this method do are:
     1. check sidForMultimedia if valided.
     2. check RKObjectManager
     
     may adding checking the parameters.
     */
    NSLog(@"Selector %@ beforeInterceptor here...", NSStringFromSelector([i selector]));
    if(![QNAPCommunicationManager share].sidForQTS){
    }
}

- (void)afterInterceptorForFileManager:(NSInvocation *)i{
    NSLog(@"Selector %@ afterInterceptor here...", NSStringFromSelector([i selector]));
}

- (void)beforeInterceptorForMyCloud:(NSInvocation *)i{
    NSLog(@"Selector %@ beforeInterceptor here...", NSStringFromSelector([i selector]));
    AFOAuthCredential *credential = [AFOAuthCredential retrieveCredentialWithIdentifier: CredentialIdentifier];
    if(!credential.accessToken || [credential isExpired]){
        __block int isFetchingSuccess = NO;
        QNMyCloudManager *previousMyCloudManager = (QNMyCloudManager *)[self searchModuleWithClassName:@"QNMyCloudManager"];
        [previousMyCloudManager refetchOAuthTokenWithSuccessBlock:^(AFOAuthCredential *credential){
            isFetchingSuccess = YES;
        }
                                                 withFailureBlock:^(NSError *error){
                                                     isFetchingSuccess = YES;
                                                 }];
        [QNAPFrameworkUtil waitUntilConditionYES:&isFetchingSuccess];
    }
}

- (void)afterInterceptorForMyCloud:(NSInvocation *)i{
    
}

#pragma mark - Factory Methods

-(QNFileStationAPIManager*)factoryForFileStatioAPIManager:(NSString*)baseURL{
    if([self validateUrl:baseURL])
        return nil;
    
    //設定QNFileStationAPIManager
    QNFileStationAPIManager *fileStationsAPIManager = (QNFileStationAPIManager *)[[AOPProxy alloc] initWithNewInstanceOfClass:[QNFileStationAPIManager class]];
    [fileStationsAPIManager setBaseURL:baseURL];
    [fileStationsAPIManager setting];
    
    //攔截器
    [self bindAllInterceptorForFileManager:fileStationsAPIManager];
    
    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:fileStationsAPIManager];
    if(searchExistingModule==nil){
        self.weakRKObjectManager = fileStationsAPIManager.rkObjectManager;
        return fileStationsAPIManager;
    }
    else{
        return (QNFileStationAPIManager *)searchExistingModule;
    }
}

- (QNMyCloudManager *)factoryForMyCloudManager:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret{
    if([self validateUrl:baseURL])
        return nil;
    QNMyCloudManager *myCloudManager =(QNMyCloudManager *)[[AOPProxy alloc] initWithNewInstanceOfClass:[QNMyCloudManager class]];
    myCloudManager.baseURL = baseURL;
    myCloudManager.clientSecret = clientSecret;
    myCloudManager.clientId = clientId;

    
    //攔截器
    [self bindAllInterceptorForMyCloud:myCloudManager];

    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:myCloudManager];
    return (searchExistingModule == nil)?myCloudManager:(QNMyCloudManager *)searchExistingModule;
}

- (QNMusicStationAPIManager *)factoryForMusicStatioAPIManager:(NSString*)baseURL{
    if([self validateUrl:baseURL])
        return nil;
    QNMusicStationAPIManager *musicStationsAPIManager = [[QNMusicStationAPIManager alloc] initWithBaseURL:baseURL];
    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:musicStationsAPIManager];
    return (searchExistingModule==nil)?musicStationsAPIManager:(QNMusicStationAPIManager *)searchExistingModule;
}

#pragma mark - PrivateMethod
- (void)listAllMethod:(id)instance{
    int i=0;
    unsigned int mc = 0;
    Method * mlist = class_copyMethodList(object_getClass(instance), &mc);
    NSLog(@"%d methods", mc);
    for(i=0;i<mc;i++)
        NSLog(@"Method no #%d: %s", i, sel_getName(method_getName(mlist[i])));

}

- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

- (QNModuleBaseObject *)sameModuleWithTargetModule:(QNModuleBaseObject*)targetModule{
    @synchronized(self.allModules){
        for (QNModuleBaseObject *examModule in self.allModules) {
            if([examModule.baseURL isEqualToString:targetModule.baseURL] && [targetModule isMemberOfClass:[examModule class]]){
                return examModule;
            }
        }
        return nil;
    }
}

- (QNModuleBaseObject *)searchModuleWithClassName:(NSString *)className{
    @synchronized(self.allModules){
        for (QNModuleBaseObject *examModule in self.allModules) {
            if([examModule isKindOfClass: NSClassFromString(className)]){
                return examModule;
            }
        }
        return nil;
    }
}

#pragma mark - Misc Setting

- (void)activateDebugLogLevel:(int)_ddLogLevel{
    ddLogLevel = _ddLogLevel;
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor blueColor] backgroundColor:nil forFlag:LOG_FLAG_VERBOSE];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor yellowColor] backgroundColor:nil forFlag:LOG_FLAG_WARN];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor redColor] backgroundColor:nil forFlag:LOG_FLAG_ERROR];
    
    if(_ddLogLevel & LOG_FLAG_VERBOSE)
        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
}

- (void)settingMisc:(NSBundle *)resourceBundle{
    /*1. generate the needed context
    * 2. binding MagicalRecord's context with RESTKit's one
    **/
    NSError *error = nil;
    [MagicalRecord setupAutoMigratingCoreDataStack];
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:[NSPersistentStoreCoordinator MR_defaultStoreCoordinator]];
    self.objectManager = managedObjectStore;
    [self.objectManager createPersistentStoreCoordinator];
    
    [self.objectManager addInMemoryPersistentStore:&error];
    
    [self.objectManager createManagedObjectContexts];
    [NSManagedObjectContext MR_setDefaultContext:self.objectManager.mainQueueManagedObjectContext];
    [NSManagedObjectContext MR_setRootSavingContext:managedObjectStore.persistentStoreManagedObjectContext];
}

+ (void)closeCommunicationManager{
    [MagicalRecord cleanUp];
}
@end
