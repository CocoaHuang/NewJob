//
//  LQCacheManager.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/13.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQCacheManager.h"
#import "LQCacheDataModel.h"

NSString * const kLQCacheManagerDirectoryName = @"MYCachesDirectory";         //默认缓存文件夹

static LQCacheManager *CachesManager = nil;

@interface LQCacheManager ()

@property (nonatomic, strong) NSMutableDictionary *cacheManagerDict;
@property (nonatomic, strong) YYCache *cacheManager;

@end

@implementation LQCacheManager

#pragma mark set up
+ (instancetype)shareMYCachesManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CachesManager = [[LQCacheManager alloc] init];
        [CachesManager setupForCachesManager];
    });
    return CachesManager;
}

- (void)setupForCachesManager
{
    self.cacheManagerDict = [NSMutableDictionary dictionary];
    self.cacheManager = [self createYYCacheWithName:kLQCacheManagerDirectoryName];
    [self.cacheManagerDict setValue:self.cacheManager forKey:kLQCacheManagerDirectoryName];
}

#pragma mark 缓存
+ (void)saveDataWithData:(id)saveData cacheKey:(NSString *)cacheKey cachePolicy:(LQRequestCachePolicy)cachePolicy invalidTimeLength:(NSTimeInterval)invalidTimeLength withBlock:(void(^)(void))block
{
    if (!saveData || cacheKey.length == 0 || cachePolicy == LQRequestNonuseCacheData) {
        return;
    }
    if (cachePolicy == LQRequestUseCacheAndCacheTime && invalidTimeLength == 0) {
        return;
    }
    LQCacheDataModel *cacheModel = [LQCacheDataModel createCacheModelWithKey:cacheKey cacheDir:kLQCacheManagerDirectoryName cacheData:saveData cacheTime:invalidTimeLength];
    YYCache *cache = [LQCacheManager shareMYCachesManager].cacheManager;
    [cache setObject:cacheModel forKey:cacheKey withBlock:block];
}

#pragma mark 读取
+ (id)readCacheDataWithName:(NSString *)cacheKey cachePolicy:(LQRequestCachePolicy)cachePolicy
{
    if (cacheKey.length == 0 || cachePolicy == LQRequestNonuseCacheData) {
        return nil;
    }
    YYCache *cache = [LQCacheManager shareMYCachesManager].cacheManager;
    LQCacheDataModel *cacheModel = (LQCacheDataModel *)[cache objectForKey:cacheKey];
    if (cachePolicy == LQRequestUseCacheAndCacheTime) {
        
        
        if (![cacheModel isValidCacheData:cacheModel]) {
            [cache removeObjectForKey:cacheKey];
            return nil;
        }
    }
    return cacheModel.cacheData;
}

+ (void)clearAllCacheData
{
    [[LQCacheManager shareMYCachesManager].cacheManagerDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        YYCache *cache = (YYCache *)obj;
        [cache removeAllObjects];
    }];
}


- (YYCache *)createYYCacheWithName:(NSString *)name
{
    YYCache *cache = [YYCache cacheWithName:name];
    cache.memoryCache.shouldRemoveAllObjectsOnMemoryWarning = YES;
    cache.memoryCache.shouldRemoveAllObjectsWhenEnteringBackground = YES;
    return cache;
}

#pragma mark setAndGet
- (void)setCacheDirectoryName:(NSString *)cacheDirectoryName
{
    if (cacheDirectoryName.length == 0) {
        return;
    }
    if ([self.cacheManagerDict valueForKey:cacheDirectoryName]) {
        self.cacheManager = [self.cacheManagerDict valueForKey:cacheDirectoryName];
    }
    else {
        self.cacheManager = [self createYYCacheWithName:cacheDirectoryName];
        [self.cacheManagerDict setValue:self.cacheManager forKey:cacheDirectoryName];
    }
}

//加密串 md5生成缓存key
+ (NSString *)getSignStr:(NSDictionary *)params path:(NSString *)path
{
    if (params == nil) {
        return [NSObject encryptionBaseOnMD5:path];
    }
    NSArray *keysArr = [params allKeys];
    NSArray *sortedArr = [keysArr sortedArrayUsingSelector:@selector(compare:)];
    NSMutableString *muStr = [NSMutableString stringWithString:path];
    for (int i = 0; i < sortedArr.count; i ++)
    {
        [muStr appendFormat:@"%@%@",sortedArr[i],[params valueForKey:sortedArr[i]]];
    }
    return [NSObject encryptionBaseOnMD5:muStr];
}

@end
