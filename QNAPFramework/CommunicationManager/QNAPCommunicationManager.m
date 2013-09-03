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

static QNAPCommunicationManager *singletonCommunicationManager = nil;
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

        [singletonCommunicationManager settingMisc];
        [singletonCommunicationManager activateDebugLogLevel];
        
    }
    return singletonCommunicationManager;
}

#pragma mark - Factory Methods

-(QNFileStationAPIManager*)factoryForFileStatioAPIManager:(NSString*)baseURL{
    if([self validateUrl:baseURL])
        return nil;
    QNFileStationAPIManager *fileStationsAPIManager = [[QNFileStationAPIManager alloc] initWithBaseURL:baseURL];
    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:fileStationsAPIManager];
    return (searchExistingModule==nil)?fileStationsAPIManager:(QNFileStationAPIManager *)searchExistingModule;
}

- (QNMyCloudManager *)factoryForMyCloudManager:(NSString *)baseURL withClientId:(NSString *)clientId withClientSecret:(NSString *)clientSecret{
    if([self validateUrl:baseURL])
        return nil;
    QNMyCloudManager *myCloudManager = [[QNMyCloudManager alloc]
                                        initWithMyCloudBaseURL:baseURL
                                        withClientId:clientId
                                        withClientSecret:clientSecret];
    QNModuleBaseObject *searchExistingModule = [self sameModuleWithTargetModule:myCloudManager];
    return (searchExistingModule == nil)?myCloudManager:(QNMyCloudManager *)searchExistingModule;
}

#pragma mark - PrivateMethod
- (BOOL) validateUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

-(QNModuleBaseObject *)sameModuleWithTargetModule:(QNModuleBaseObject*)targetModule{
    @synchronized(self.allModules){
        for (QNModuleBaseObject *examModule in self.allModules) {
            if([examModule.baseURL isEqualToString:targetModule.baseURL] && [targetModule isMemberOfClass:[examModule class]]){
                return examModule;
            }
        }
        return nil;
    }
}

#pragma mark - Misc Setting

- (void)activateDebugLogLevel{
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:nil forFlag:LOG_FLAG_INFO];
}

- (void)settingMisc{
    /*1. generate the needed context
    * 2. binding MagicalRecord's context with RESTKit's one
    **/
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreNamed:@"ResponseObject"];
    self.objectManager = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:
            [NSPersistentStoreCoordinator MR_defaultStoreCoordinator]];
    
    //Iniitalize CoreData with RestKit
    RKManagedObjectStore *managedObjectStore = [[RKManagedObjectStore alloc] initWithPersistentStoreCoordinator:[NSPersistentStoreCoordinator MR_defaultStoreCoordinator]];
    self.objectManager = managedObjectStore;

    [self.objectManager createManagedObjectContexts];
    [NSManagedObjectContext MR_setDefaultContext:self.objectManager.mainQueueManagedObjectContext];
}
@end
