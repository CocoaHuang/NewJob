//
//  LQServerFactory.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQServerFactory.h"
#import "LQMainServer.h"
#import "LQSubServer.h"

@interface LQServerFactory ()

@property (nonatomic, strong) NSMutableDictionary *serviceStorage;
@property (nonatomic, strong) LQBaseServer<LQBaseServerProtocol> *currentServer;

@end


@implementation LQServerFactory

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static LQServerFactory *sharedInstance;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[LQServerFactory alloc] init];
        [sharedInstance setupLQServerFactory];
    });
    return sharedInstance;
}

- (void)setupLQServerFactory
{
    self.currentServer = nil;
    [self serviceStorage];
}

#pragma mark 当前服务器的URL与type
+ (NSString *)serverApi
{
    if ([LQServerFactory sharedInstance].currentServer == nil) {
        return nil;
    }
    return [LQServerFactory sharedInstance].currentServer.serverUrl;
}

+ (EnvironmentType)serverEnvironmentType
{
    if ([LQServerFactory sharedInstance].currentServer == nil) {
        MY_Log(@"当前服务器为nil");
        return EnvironmentTypePreRelease;
    }
    return [LQServerFactory sharedInstance].currentServer.serverType;
}

#pragma mark 获取并生成服务器
- (LQBaseServer<LQBaseServerProtocol> *)serviceWithType:(LQServiceType)type
{
    if (_serviceStorage[@(type)] == nil) {
        _serviceStorage[@(type)] = [self createNewServerWithType:type environmentType:EnvironmentTypePreRelease];
    }
    _currentServer = _serviceStorage[@(type)];
    return _currentServer;
}

- (LQBaseServer<LQBaseServerProtocol> *)createNewServerWithType:(LQServiceType)type environmentType:(EnvironmentType)eType
{
    LQBaseServer<LQBaseServerProtocol> *service = nil;
    switch (type) {
        case ServiceA:
            service = [[LQMainServer alloc] initServerWithEnvironmentType:eType];
            break;
        case ServiceB:
            service = [[LQSubServer alloc] initServerWithEnvironmentType:eType];
            break;
        default:
            break;
    }
    return service;
}

#pragma mark 修改服务器环境
+ (void)changeEnvironmentType:(EnvironmentType)environmentType
{
    LQServerFactory *factory = [LQServerFactory sharedInstance];
    if (factory.serviceStorage && factory.serviceStorage.count != 0) {
        [factory.serviceStorage enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            //obj 服务器
            LQBaseServer<LQBaseServerProtocol> *objServer = (LQBaseServer<LQBaseServerProtocol> *)obj;            
            objServer.serverType = environmentType;
        }];
    }
}

#pragma mark - getters and setters
- (NSMutableDictionary *)serviceStorage
{
    if (_serviceStorage == nil) {
        _serviceStorage = [[NSMutableDictionary alloc] init];
    }
    return _serviceStorage;
}

@end
