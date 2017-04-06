//
//  LQBaseServer.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseServer.h"

@interface LQBaseServer ()

@property (nonatomic, weak) id<LQBaseServerProtocol> childServer;

@end


@implementation LQBaseServer

@synthesize serverUrl = _serverUrl;


- (instancetype)initServerWithEnvironmentType:(EnvironmentType)eType
{
    if (self = [super init]) {
        if ([self conformsToProtocol:@protocol(LQBaseServerProtocol)])
        {
            self.childServer = (id<LQBaseServerProtocol>)self;
            self.serverType = eType;
        }
        else {
            NSAssert(NO,@"子类没有实现协议");
        }
    }
    return self;
}

- (void)setServerType:(EnvironmentType)serverType
{
    
    
    _serverType = serverType;
    switch (_serverType) {
        case EnvironmentTypeDevelop:
        {
            _serverUrl = self.childServer.developUrl;
            break;
        }
        case EnvironmentTypePreRelease:
        {
            _serverUrl = self.childServer.releseUrl;
            break;
        }
        default:
            break;
    }
    
    
}

@end
