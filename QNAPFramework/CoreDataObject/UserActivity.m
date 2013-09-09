//
//  UserActivity.m
//  QNAPFramework
//
//  Created by Chen-chih Liao on 13/9/5.
//  Copyright (c) 2013年 QNAP. All rights reserved.
//

#import "UserActivity.h"
#import "App.h"
#import "SourceInfo.h"


@implementation UserActivity

@dynamic action;
@dynamic created_at;
@dynamic metadata;
@dynamic user_id;
@dynamic user_activity_id;
@dynamic relationship_App;
@dynamic relationship_SourceInfo;

- (NSString *)description{
    return [NSString stringWithFormat:@"action: %@, created_at: %@, user_id: %@, user_activity_id: %@", self.action, self.created_at, self.user_id, self.user_activity_id];
}
@end
