//
//  QNModuleBaseObject.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
@interface QNModuleBaseObject : NSObject
@property(nonatomic, strong)NSString *baseURL;
@property(nonatomic, weak) RKObjectManager *weakRKObjectManager;

- (id)initWithBaseURL:(NSString *)baseURL;
- (NSArray *)allErrorMessageResponseDescriptor;

@end
