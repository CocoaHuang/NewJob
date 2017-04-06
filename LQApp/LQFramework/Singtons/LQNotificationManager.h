//
//  LQNotificationManager.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/15.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQNotificationManager : NSObject

+ (instancetype)shareLQNotificationManager;

- (void)postBackgroundFetchNotificationWithBlock:(void (^)(UIBackgroundFetchResult))completionHandler;
- (void)observeBackgroundFetchNotificationWithTarget:(NSObject *)objc;

@end
