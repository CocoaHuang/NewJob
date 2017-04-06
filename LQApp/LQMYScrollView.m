//
//  LQMYScrollView.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/20.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQMYScrollView.h"

@implementation LQMYScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
     Drawing code
}
*/


- (void)drawRect:(CGRect)rect
{
    
    CGPoint arcPoint = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGContextRef ctf = UIGraphicsGetCurrentContext();
    CGContextAddArc(ctf, arcPoint.x, arcPoint.y, arcPoint.x, 0, 2 * M_PI, YES);
    [[UIColor redColor] setFill];
    [[UIColor whiteColor] setStroke];
//    CGContextDrawPath(ctf, kCGPathFill);
    
    CGContextFillPath(ctf);
    
}

@end
