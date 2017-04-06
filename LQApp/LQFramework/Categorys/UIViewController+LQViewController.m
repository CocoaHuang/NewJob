//
//  UIViewController+LQViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "UIViewController+LQViewController.h"

@implementation UIViewController (LQViewController)

+ (void)load
{
    Method sysMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method cusMethod = class_getInstanceMethod([self class], @selector(cusViewWillAppear:));
    method_exchangeImplementations(sysMethod, cusMethod);
}

- (void)cusViewWillAppear:(BOOL)animated
{    
    [self cusViewWillAppear:animated];
    if ([self isKindOfClass:NSClassFromString(@"LQBaseViewController")]) {
        LQCurrentViewController = self;
        
        
        
        MY_Log(@"当前控制器：%@",LQCurrentViewController);
        MY_Log(@"当前跟控制器：%@",LQCurrentRootController);
    }
}


- (void)nativeTransitionToViewControllerWithName:(NSString *)vcName andParams:(NSDictionary *)params animated:(BOOL)animated completion:(void(^)(NSDictionary *info,UIViewController *targetVc))completionBlock
{
    UIViewController *vc = [[LQMediator sharedInstance] basicNativePushViewControllerWithVCName:vcName andParams:params];
    if (!vc) {
        return;
    }
    if (completionBlock) {
        if (params) {
            completionBlock(params, vc);
        }
        else {
            completionBlock(nil, vc);
        }
    }
    [self.navigationController pushViewController:vc animated:animated];
}

- (void)remoteTransitionToViewControllerWithURL:(NSURL *)url animated:(BOOL)animated completion:(void(^)(NSDictionary *info))completionBlock
{
    UIViewController *vc = [[LQMediator sharedInstance] performActionWithUrl:url completion:completionBlock];
    if (!vc) {
        return;
    }
    [self.navigationController pushViewController:vc animated:animated];
}



@end
