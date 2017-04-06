//
//  LQRefreshLeftLayer.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/23.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQRefreshLeftLayer.h"


@interface LQRefreshLeftLayer ()


@end

@implementation LQRefreshLeftLayer



- (void)drawInContext:(CGContextRef)ctx
{
    if (_drawNum == 0) {
        CGContextClearRect(ctx, self.visibleRect);
        return;
    }
    
    CGFloat layerH = self.bounds.size.height;
    if (_drawNum > 0.5 && _drawNum <= 1) {
        CGContextAddArc(ctx, SCREEN_WIDTH * 0.5, layerH * 0.5, 15.f, M_PI / 2, M_PI / 2 + (M_PI * 4) * (_drawNum - 0.5), NO);
        CGContextStrokePath(ctx);
    }
    if (_drawNum > 1) {
        CGFloat layerH = self.bounds.size.height;
        CGContextAddArc(ctx, SCREEN_WIDTH * 0.5, layerH * 0.5, 15.f, M_PI / 2, M_PI / 2 + M_PI * 2, NO);
        CGContextStrokePath(ctx);
    }
}

- (void)setDrawNum:(CGFloat)drawNum
{
    _drawNum = drawNum;
    if (_drawNum <= 0) {
        [self removeAllAnimations];

    }
    [self setNeedsDisplay];
}

- (void)startAnimation
{
    CABasicAnimation *proAnimation = [CABasicAnimation animationWithKeyPath:@"position.x"];
    proAnimation.duration = 0.3f;
    proAnimation.repeatCount = INT_MAX;
    proAnimation.autoreverses = YES;
    proAnimation.fromValue = @(50 + SCREEN_WIDTH * 0.5);
    proAnimation.byValue = @(0 + SCREEN_WIDTH * 0.5);
    proAnimation.toValue = @(SCREEN_WIDTH * 0.5 - 50);
    [self addAnimation:proAnimation forKey:nil];
}

@end
