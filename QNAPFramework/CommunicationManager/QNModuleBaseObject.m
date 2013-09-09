//
//  QNModuleBaseObject.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/3.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "QNModuleBaseObject.h"
#import <RestKit/RestKit.h>
#import "QNMyCloudMapping.h"

@implementation QNModuleBaseObject
- (id)initWithBaseURL:(NSString *)baseURL{
    if((self = [super init])){
        
    }
    return self;
}

- (NSArray *)allErrorMessageResponseDescriptor{
    RKEntityMapping *responseMapping = [QNMyCloudMapping mappingForResponse];
    responseMapping.identificationAttributes = @[@"code", @"message"];
    
    NSIndexSet *errorIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(RKStatusCodeClassRedirection, RKStatusCodeClassServerError+ 100)];
    
    RKResponseDescriptor *putResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                            method:RKRequestMethodPUT
                                                                                       pathPattern:nil
                                                                                           keyPath:nil
                                                                                       statusCodes:errorIndexSet];
    RKResponseDescriptor *getResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                               method:RKRequestMethodGET
                                                                                          pathPattern:nil
                                                                                              keyPath:nil
                                                                                          statusCodes:errorIndexSet];
    RKResponseDescriptor *postResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                               method:RKRequestMethodPOST
                                                                                          pathPattern:nil
                                                                                              keyPath:nil
                                                                                          statusCodes:errorIndexSet];
    RKResponseDescriptor *deleteResponseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping
                                                                                               method:RKRequestMethodDELETE
                                                                                          pathPattern:nil
                                                                                              keyPath:nil
                                                                                          statusCodes:errorIndexSet];

    return @[putResponseDescriptor, getResponseDescriptor, postResponseDescriptor, deleteResponseDescriptor];
}
@end
