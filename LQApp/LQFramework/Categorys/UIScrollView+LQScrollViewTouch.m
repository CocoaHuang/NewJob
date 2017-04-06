//
//  UIScrollView+LQScrollViewTouch.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/14.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "UIScrollView+LQScrollViewTouch.h"

@implementation UIScrollView (LQScrollViewTouch)

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.dragging) {
        [[self nextResponder] touchesBegan:touches withEvent:event];
    }
    
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesMoved:touches withEvent:event];
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.dragging) {
        [[self nextResponder] touchesEnded:touches withEvent:event];
    }
    [super touchesEnded:touches withEvent:event];
}

@end
