//
//  LQCacheManager.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, LQRequestCachePolicy)
{
    LQRequestUseCacheAndRequestData = 0,           //使用缓存并请求   （默认，取缓存，在请求，在缓存）
    LQRequestUseCacheAndCacheTime = 1,             //有缓存过期时间    (没过期直接使用，不请求)
    LQRequestNonuseCacheData = 2,                  //直接请求         (不进行缓存处理)
    //    LQRequestUseCustomCacheData = 3,               //自定义
};

@interface LQCacheManager : NSObject

@property (nonatomic, copy) NSString *cacheDirectoryName;

+ (instancetype)shareMYCachesManager;

/**

 @param saveData
 @param cacheKey
 @param invalidTimeLength 超时 (0：不缓存)
 @param block
 */
+ (void)saveDataWithData:(id)saveData cacheKey:(NSString *)cacheKey cachePolicy:(LQRequestCachePolicy)cachePolicy invalidTimeLength:(NSTimeInterval)invalidTimeLength withBlock:(void(^)(void))block;

/**
 读取缓存
 
 @param fileName 文件名（请求的url）
 
 @return
 */

+ (id)readCacheDataWithName:(NSString *)cacheKey cachePolicy:(LQRequestCachePolicy)cachePolicy;


+ (void)clearAllCacheData;

/**
 生成缓存key
 @param params 请求参数
 @param path   url

 @return
 */
+ (NSString *)getSignStr:(NSDictionary *)params path:(NSString *)path;



@end
