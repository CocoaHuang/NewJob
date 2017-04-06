//
//  LQTarget_BaseViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQTarget_BaseViewController.h"
#import "LQBaseViewController.h"


@implementation LQTarget_BaseViewController

- (UIViewController *)LQAction_NativeTransitionToViewControllerWithParams:(NSDictionary *)params
{    
    if (!params) {
        return nil;
    }
    NSString *vcName = [params valueForKey:kLQMediatorTargetVCName];
    UIViewController *vc = [LQTarget_BaseViewController createViewControllerFromName:vcName];
    return vc;
}

//- (UIViewController *)LQAction_RemoteTransitionToViewControllerWithParams:(NSDictionary *)params
//{
//    return [self LQAction_NativeTransitionToViewControllerWithParams:params];
//}

#pragma mark 根据名称创建viewController，并将params的数据赋值给viewController
+ (UIViewController *)createViewControllerFromName:(NSString *)name
{    
    Class vcClass = NSClassFromString(name);
    if (!vcClass)
    {
        return nil;
    }
    NSObject *obj = [[vcClass alloc] init];
    if (![obj isKindOfClass:[UIViewController class]]) {
        return nil;
    }
    return (UIViewController *)obj;
}

@end
