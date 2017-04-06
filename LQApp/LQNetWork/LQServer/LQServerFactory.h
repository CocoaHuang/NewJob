//
//  LQServerFactory.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQBaseServer.h"
#import "LQRequestConfigure.h"

@interface LQServerFactory : NSObject

+ (instancetype)sharedInstance;

//当前处于的服务
+ (NSString *)serverApi;

//当前处于的服务环境
+ (EnvironmentType)serverEnvironmentType;

+ (void)changeEnvironmentType:(EnvironmentType)environmentType;

//根据服务器类型 获取服务配置 LQRequestConfigure
- (LQBaseServer<LQBaseServerProtocol> *)serviceWithType:(LQServiceType)type;


@end
