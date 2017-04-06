//
//  LQRequestManager.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/14.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQRequestConfigure.h"
#import "LQCacheManager.h"
#import "LQRequestResult.h"





//1.直接请求服务器 (不缓存)
//2.用缓存在请求服务器 (每次都缓存)
//3.有缓存用缓存，不请求服务器（过期）

@interface LQRequestManager : NSObject

#pragma mark post/get 数据请求
+ (LQRequestManager *)requestWithRequestType:(LQRequestType)requestType
                                  serverType:(LQServiceType)serverType
                                 requestPath:(NSString *)path
                                requestparam:(NSDictionary *)params
                                 cachePolicy:(LQRequestCachePolicy)cachePolicy
                                   cacheTime:(NSTimeInterval)cacheTimeLength
                              completeReturn:(completeReturnBlock)completeReturn;

#pragma mark 单独设置超时时间
+ (void)requestWithServerType:(LQServiceType)serverType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                      timeOut:(NSTimeInterval)timeoutInterval                  //超时
                  requestType:(LQRequestType)requestType                       //请求类型
               completeReturn:(completeReturnBlock)completeReturn;


#pragma mark 数据上传
+ (void)uploadAPIWithServerType:(LQServiceType)serverType
                           path:(NSString *)path
                          param:(NSDictionary *)parameters
                    requestType:(LQRequestType)requestType
                         upload:(UploadDataBlock)uploadBlock
                 completeReturn:(completeReturnBlock)completeReturn;

#pragma mark 取消网络请求
- (void)cancelRequest;

@end
