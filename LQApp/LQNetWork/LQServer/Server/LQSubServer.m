//
//  LQSubServer.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQSubServer.h"

@implementation LQSubServer

@synthesize developUrl = _developUrl,releseUrl = _releseUrl;

- (NSString *)developUrl
{
    MY_Log(@"服务器Sub_De");
    return @"http://www.baidu.com";
}

- (NSString *)releseUrl
{
    MY_Log(@"服务器Sub_Re");
    return @"http://www.pansou.com";
}


@end
