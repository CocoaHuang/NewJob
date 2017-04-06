//
//  UIApplication+LQApplicationCategory.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/17.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "UIApplication+LQApplicationCategory.h"

@implementation UIApplication (LQApplicationCategory)

//- (void)setTransParamsDict:(NSDictionary *)transParamsDict
//{
//    objc_setAssociatedObject(self, _cmd, transParamsDict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}
//
//- (NSDictionary *)transParamsDict
//{
//    return objc_getAssociatedObject(self, _cmd);
//}

- (void)setCurrentViewController:(UIViewController *)currentViewController
{
    objc_setAssociatedObject(self, @selector(currentViewController), currentViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIViewController *)currentViewController
{
    return objc_getAssociatedObject(self, @selector(currentViewController));
}

- (UIViewController *)currentRootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}



@end
