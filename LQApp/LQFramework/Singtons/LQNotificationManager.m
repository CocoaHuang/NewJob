//
//  LQNotificationManager.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/15.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQNotificationManager.h"


static const NSString *kBackgroundFetchNotificationName = @"backgroundFetchNotificationName";

@implementation LQNotificationManager

+ (instancetype)shareLQNotificationManager
{
    static LQNotificationManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LQNotificationManager alloc] init];
    });
    return manager;
}

- (void)postBackgroundFetchNotificationWithBlock:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSNotification *noti = [NSNotification notificationWithName:@"backgroundFetchNotiName" object:nil userInfo:@{kBackgroundFetchNotificationName : completionHandler}];
    [[NSNotificationCenter defaultCenter] postNotification:noti];
}

- (void)observeBackgroundFetchNotificationWithTarget:(NSObject *)objc
{
    if (!objc) {
        return;
    }
    [[NSNotificationCenter defaultCenter] addObserver:objc selector:@selector(test2:) name:@"backgroundFetchNotiName" object:nil];
}

- (void)test2:(NSNotification *)noti
{
    NSLog(@"哈哈，收到了-%@",noti);
}

- (void)removeObserverWithTarget:(NSObject *)objc
{
    if (!objc) {
        return;
    }
    [[NSNotificationCenter defaultCenter] removeObserver:objc];
}

@end
