//
//  LQRefreshLeftLayer.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/23.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface LQRefreshLeftLayer : CALayer

@property (nonatomic, assign) CGFloat drawNum;

- (void)startAnimation;

@end
