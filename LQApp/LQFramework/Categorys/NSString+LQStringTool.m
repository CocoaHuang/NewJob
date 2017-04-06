//
//  NSString+LQStringTool.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/22.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "NSString+LQStringTool.h"

@implementation NSString (LQStringTool)

- (BOOL)lq_isOnlyLetters {
    NSCharacterSet *letterCharacterset = [[NSCharacterSet letterCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:letterCharacterset].location == NSNotFound);
}

- (BOOL)lq_isOnlyNumbers {
    NSCharacterSet *numSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
    return ([self rangeOfCharacterFromSet:numSet].location == NSNotFound);
}

- (BOOL)lq_isOnlyAlphaNumeric {
    NSCharacterSet *numAndLetterCharSet = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    return ([self rangeOfCharacterFromSet:numAndLetterCharSet].location == NSNotFound);
}

@end
