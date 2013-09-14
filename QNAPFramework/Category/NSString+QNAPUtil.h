//
//  NSString+QNAPUtil.h
//  QNAPFramework
//
//  Created by Change.Liao on 13/9/14.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (QNAPUtil)
/**
 *  Force the first char to be uppercase.
 *
 *  @return Origin string besides the first char being uppercase.
 */
- (NSString *)forceFirstCharUppercase;
@end
