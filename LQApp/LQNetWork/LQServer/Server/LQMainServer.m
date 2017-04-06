//
//  LQMainServer.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQMainServer.h"

@implementation LQMainServer

@synthesize developUrl = _developUrl,releseUrl = _releseUrl;

- (NSString *)developUrl
{
    MY_Log(@"服务器Main_De");
    return @"https://cfapi.chaojifan.com";
}

- (NSString *)releseUrl
{
    MY_Log(@"服务器Main_De");
    return @"https://cfapi.chaojifan.com";
}



@end
