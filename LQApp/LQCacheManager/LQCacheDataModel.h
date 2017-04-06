//
//  LQCacheDataModel.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/17.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LQCacheDataModel : NSObject <NSCoding>

@property (nonatomic, copy) NSString *cacheKey;
@property (nonatomic, copy) NSString *cacheDirectory;
@property (nonatomic, assign) NSTimeInterval cacheTimeLength;
@property (nonatomic, assign) NSTimeInterval cacheSaveTime;
@property (nonatomic, strong) id cacheData;


/**
 @param cacheKey
 @param cacheDir    缓存所在文件夹
 @param cacheData
 @param timeLength

 @return
 */
+ (instancetype)createCacheModelWithKey:(NSString *)cacheKey
                         cacheDir:(NSString *)cacheDir
                              cacheData:(id)cacheData
                              cacheTime:(NSTimeInterval)timeLength;


/**
 验证数据是否过期

 @param cacheModel

 @return
 */
- (BOOL)isValidCacheData:(LQCacheDataModel *)cacheModel;




@end
