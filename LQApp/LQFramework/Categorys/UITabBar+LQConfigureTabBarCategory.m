//
//  UITabBar+LQConfigureTabBarCategory.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/28.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "UITabBar+LQConfigureTabBarCategory.h"

@implementation UITabBar (LQConfigureTabBarCategory)

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!self.clipsToBounds && !self.hidden && self.alpha > 0)
//    {
//        
//        UIView *result = [super hitTest:point withEvent:event];
//        if (result) {
//            return result;
//        }
//        else {
//            for (UIView *subview in self.subviews.reverseObjectEnumerator)
//            {
//                //将当前点击point转换到subview坐标系中
//                CGPoint subPoint = [subview convertPoint:point fromView:self];
//                result = [subview hitTest:subPoint withEvent:event];
//                if (result) {
//                    return result;
//                }
//            }
//        }
//    }
//    return nil;
//}


@end
