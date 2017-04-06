//
//  AppDelegate.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "AppDelegate.h"
#import "LQPageTransitionManager.h"
#import "LQMediator+LQAction_BaseViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self configureDebugSettingWithApplication:application launchOptions:launchOptions];
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    Class vcName = NSClassFromString(@"LQBaseTabBarViewController");
    self.window.rootViewController = [[vcName alloc] init];
    [self.window makeKeyAndVisible];
    
    //    NSLog(@"%@",[LQPageTransitionManager sharePageTransitionManager].curretnTabBarController);
    
    //   NSLog(@"--------%@",[[LQMediator sharedInstance] performActionWithUrl:[NSURL URLWithString:@"aaa://BaseViewController/NativeTransitionToViewControllerWithParams:?pushName==WebViewController$id==https://www.hao123.com?a=1&b=2"] completion:^(NSDictionary *info) {
    //   }]);
    
    
    return YES;
}

#pragma mark 配置debug
- (void)configureDebugSettingWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions
{
    [self configureBackgroundFetchIntervalWithApplication:application];
#ifdef DEBUG
    //    -UIViewShowAlignmentRects YES //开启对齐线框
    [[NSUserDefaults standardUserDefaults] setBool:YES
                                            forKey:@"UIViewShowAlignmentRects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
#else
    [[NSUserDefaults standardUserDefaults] setBool:NO
                                            forKey:@"UIViewShowAlignmentRects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
#endif
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    //    __block UIBackgroundTaskIdentifier task = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
    //        //规定时间内未完成时调用
    //        [application endBackgroundTask:task];
    //        MY_Log(@"未完成");
    //        task = UIBackgroundTaskInvalid;
    //    }];
    //
    //    NSTimer *time = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(backgroundTask) userInfo:nil repeats:YES];
    //
    ////    [[NSRunLoop currentRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];
    //
    //    [application endBackgroundTask:task];
    //    MY_Log(@"完成");
    //    task = UIBackgroundTaskInvalid;
    
}

- (void)backgroundTask
{
    MY_Log(@"还有--%.2lf",[UIApplication sharedApplication].backgroundTimeRemaining);
}



- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark 后台任务-------------------------------------------------------------------------------------------
- (void)configureBackgroundFetchIntervalWithApplication:(UIApplication *)application
{
    [application setMinimumBackgroundFetchInterval:UIApplicationBackgroundFetchIntervalMinimum];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    if (LQCurrentViewController && [LQCurrentViewController respondsToSelector:@selector(performBackgroundFetchWithApplication:CompletionHandler:)]) {
        [LQCurrentViewController performBackgroundFetchWithApplication:application CompletionHandler:completionHandler];
    }
    else {
        MY_Log(@"后台更新失败了");
        completionHandler(UIBackgroundFetchResultFailed);
    }
    //在实际的IOS7环境中，Fetch事件是由系统管理的，app开发者无法预先知道Fetch事件达到的时机。但XCode也提供了Fetch事件的调试办法，在XCode上运行程序后，在Debug->Simulate Background Fetch.
    //还有一种情况是app没有运行(不在前台也不在后台)，被Fetch事件唤醒执行.这种情况的测试方法如下:
    //Product->Scheme->Edit scheme 在Debug模式选中Options,点选Launch due to a background fetch event，运行即可
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    /*
     1.app 未启动状态
       在didFinishLaunchingWithOptions 接收处理远程消息
     2.app 已经启动
       实际上，如果应用在后台收到推送,方法会立刻执行一次当用户点击推送消息启动的时候，会执行第二次;如果是通过点击图标启动应用，不会则执行第二次
       判断是第一次执行还是第二次执行，UIApplicationState这个状态。
     */
    if (application.applicationState == UIApplicationStateActive) {
        //app正处于前台（执行操作）
    }
    else if (application.applicationState == UIApplicationStateBackground) {
        //处于后台
    }
    else {
        //UIApplicationStateInactive (由于)
        //第二次进入调用（点击推送消息进入调用，点app图标进入不调用）
    }
    completionHandler(UIBackgroundFetchResultNewData);
}




@end
