//
//  UIViewController+LQViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LQViewController)

- (void)nativeTransitionToViewControllerWithName:(NSString *)vcName andParams:(NSDictionary *)params animated:(BOOL)animated completion:(void(^)(NSDictionary *info,UIViewController *targetVc))completionBlock;


- (void)remoteTransitionToViewControllerWithURL:(NSURL *)url animated:(BOOL)animated completion:(void(^)(NSDictionary *info))completionBlock;



#pragma mark pop



//后台任务
- (void)performBackgroundFetchWithApplication:(UIApplication *)application CompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler;

@end
