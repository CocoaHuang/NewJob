//
//  LQNormalTools.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/2.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQNormalTools.h"

@implementation LQNormalTools

- (BOOL)isUrlString:(NSString *) textString {
    NSString *regex = @"[a-zA-Z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:textString];
}

@end
