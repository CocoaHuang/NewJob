//
//  LQBaseTabBar.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/28.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseTabBar.h"


@interface LQBaseTabBar ()

@end

@implementation LQBaseTabBar


- (void)layoutSubviews
{
    [super layoutSubviews];
    for (UIView *itemView in self.subviews) {
        if (![itemView isKindOfClass:NSClassFromString(@"UITabBarButton")])
        {
            if ([itemView isMemberOfClass:NSClassFromString(@"UIImageView")]) {
                //横线
//                [itemView removeFromSuperview];
            }
            else if ([itemView isMemberOfClass:NSClassFromString(@"_UIBarBackground")] || [itemView isMemberOfClass:NSClassFromString(@"_UITabBarBackgroundView")])
            {
//                itemView.bounds = CGRectMake(se, 0, self.width, self.height);
                NSLog(@"---%@",itemView);
            }
            continue;
        }
        [self bringSubviewToFront:itemView];
        UIView *titleView, *iconView;
        
        //捕获title，img
        for (UIView *item in itemView.subviews) {
            if ([item isKindOfClass:NSClassFromString(@"UITabBarSwappableImageView")]) {
                iconView = item;
            }
            else if ([item isKindOfClass:NSClassFromString(@"UITabBarButtonLabel")]) {
                titleView = item;
            }
            else {
            }
        }
        CGFloat space = 12, tabBarButtonLabelHeight = 16;
        CGFloat y = CGRectGetHeight(self.bounds) - (CGRectGetHeight(titleView.bounds) + CGRectGetHeight(iconView.bounds));
        //超过
        if (y < 0) {
            if (titleView.height == 0) {
                //有字
                space -= tabBarButtonLabelHeight;
            }
            else {
                space = 12;
            }
            itemView.frame = CGRectMake(itemView.frame.origin.x,
                                         y - space,
                                         itemView.frame.size.width,
                                         itemView.frame.size.height - y + space
                                         );
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (!self.clipsToBounds && !self.hidden && self.alpha > 0) {
        UIView *result = [super hitTest:point withEvent:event];
        if (result) {
            return result;
        }
        else {
            for (UIView *subview in self.subviews.reverseObjectEnumerator) {
                CGPoint subPoint = [subview convertPoint:point fromView:self];
                result = [subview hitTest:subPoint withEvent:event];
                if (result) {
                    return result;
                }
            }
        }
    }
    return nil;
}


@end
