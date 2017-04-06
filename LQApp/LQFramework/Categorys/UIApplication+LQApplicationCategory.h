//
//  UIApplication+LQApplicationCategory.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/17.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <UIKit/UIKit.h>


//        MY_Log(@"当前控制器：%@",LQCurrentViewController);
//        MY_Log(@"当前跟控制器：%@",LQCurrentRootController);

#define LQCurrentViewController [UIApplication sharedApplication].currentViewController
#define LQCurrentRootController [UIApplication sharedApplication].keyWindow.rootViewController

@interface UIApplication (LQApplicationCategory)


@property (nonatomic, strong) UIViewController *currentViewController;

- (UIViewController *)currentRootViewController;

@end
