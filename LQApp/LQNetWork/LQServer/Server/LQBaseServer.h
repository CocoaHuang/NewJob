//
//  LQBaseServer.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/2/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

//多服务器使用
typedef NS_ENUM(NSUInteger,EnvironmentType) {
    EnvironmentTypeDevelop,
    EnvironmentTypePreRelease,
};

@protocol LQBaseServerProtocol <NSObject>

@property (nonatomic, copy, readonly) NSString *developUrl;
@property (nonatomic, copy, readonly) NSString *releseUrl;

@end

@interface LQBaseServer : NSObject

- (instancetype)initServerWithEnvironmentType:(EnvironmentType)eType;


@property (nonatomic, assign) EnvironmentType serverType;
@property (nonatomic, strong, readonly) NSString *serverUrl;

@end
