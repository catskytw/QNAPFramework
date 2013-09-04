//
//  QNModuleBaseObject.h
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QNModuleBaseObject : NSObject
@property(nonatomic, strong)NSString *baseURL;
- (id)initWithBaseURL:(NSString *)baseURL;
- (NSArray *)allErrorMessageResponseDescriptor;

@end
