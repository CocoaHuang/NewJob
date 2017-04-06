//
//  LQCacheDataModel.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/17.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQCacheDataModel.h"


@interface LQCacheDataModel ()


@end

@implementation LQCacheDataModel

+ (instancetype)createCacheModelWithKey:(NSString *)cacheKey
                               cacheDir:(NSString *)cacheDir
                              cacheData:(id)cacheData
                              cacheTime:(NSTimeInterval)timeLength
{
    LQCacheDataModel *cacheModel = [[LQCacheDataModel alloc] initCacheDataModelWithKey:cacheKey cacheDir:cacheDir cacheData:cacheData cacheTime:timeLength];
    return cacheModel;
}


- (instancetype)initCacheDataModelWithKey:(NSString *)cacheKey
                                 cacheDir:(NSString *)cacheDir
                                cacheData:(id)cacheData
                                cacheTime:(NSTimeInterval)timeLength
{
    LQCacheDataModel *cacheModel = [[LQCacheDataModel alloc] init];
    cacheModel.cacheKey = cacheKey;
    cacheModel.cacheDirectory = cacheDir;
    cacheModel.cacheData = cacheData;
    cacheModel.cacheTimeLength = timeLength;
    cacheModel.cacheSaveTime = [[NSDate date] timeIntervalSince1970];
    return cacheModel;
}


- (YYCache *)createYYCacheWithName:(NSString *)name
{
    YYCache *cache = [YYCache cacheWithName:name];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    return cache;
}

- (BOOL)isValidCacheData:(LQCacheDataModel *)cacheModel
{
    
    
    return cacheModel.cacheSaveTime + cacheModel.cacheTimeLength > [[NSDate date] timeIntervalSince1970] ? YES : NO;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.cacheKey forKey:@"cacheKey"];
    [encoder encodeObject:self.cacheDirectory forKey:@"cacheDirectory"];
    [encoder encodeObject:self.cacheData forKey:@"cacheData"];
    [encoder encodeDouble:self.cacheTimeLength forKey:@"cacheTimeLength"];
    [encoder encodeDouble:self.cacheSaveTime forKey:@"cacheSaveTime"];
}

/**
 *  从文件中解析对象时会调用
 *  在这个方法中说清楚哪些属性需要存储
 */
- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init]) {
        self.cacheKey = [decoder decodeObjectForKey:@"cacheKey"];
        self.cacheDirectory = [decoder decodeObjectForKey:@"cacheDirectory"];
        self.cacheData = [decoder decodeObjectForKey:@"cacheData"];
        self.cacheTimeLength = [decoder decodeDoubleForKey:@"cacheTimeLength"];
        self.cacheSaveTime = [decoder decodeDoubleForKey:@"cacheSaveTime"];
    }
    return self;
}

@end
