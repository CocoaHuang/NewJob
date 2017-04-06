//
//  LQTarget_BaseViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

//params push到vc 的key
NSString * const kLQMediatorTargetVCName = @"LQMediatorTargetVCName";

@interface LQTarget_BaseViewController : NSObject

//target 暴露的可调用的接口Action
#pragma mark 本地点用
- (UIViewController *)LQAction_NativeTransitionToViewControllerWithParams:(NSDictionary *)params;

//#pragma mark 远程
//- (UIViewController *)LQAction_RemoteTransitionToViewControllerWithParams:(NSDictionary *)params;


@end
