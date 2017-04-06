//
//  NSString+LQStringTool.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/22.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LQStringTool)

//字母
- (BOOL)lq_isOnlyLetters;

//数字
- (BOOL)lq_isOnlyNumbers;

//字母和数字
- (BOOL)lq_isOnlyAlphaNumeric;

@end
