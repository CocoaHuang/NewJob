//
//  LQMediator+LQAction_BaseViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQMediator.h"

@interface LQMediator (LQAction_BaseViewController)


#pragma mark push跳转
//- (UIViewController *)baseNativePushViewControllerWithVCName:(NSString *)vcName;

- (UIViewController *)basicNativePushViewControllerWithVCName:(NSString *)vcName andParams:(NSDictionary *)params;


//- (UIViewController *)baseRemotePushViewControllerWithParams:(NSDictionary *)params;


@end
