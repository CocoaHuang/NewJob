//
//  LQRequestManager.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/14.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQRequestManager.h"
#import "LQRequestParamsModel.h"
#import "LQRequestEngine.h"
#import "LQServerFactory.h"


NSString * const kCacheName = @"SaveCacheFile";

@interface LQRequestManager ()

@property (nonatomic, strong) NSURLSessionTask *currentTask;
//@property (nonatomic, strong) YYCache *myCache;

@end

@implementation LQRequestManager

- (instancetype)init
{
    if (self = [super init]) {
        [self setupLQRequestManager];
    }
    return self;
}

- (void)setupLQRequestManager
{

    self.currentTask = nil;
}

#pragma mark 数据请求======================================================================
#pragma mark post/get 数据请求
+ (LQRequestManager *)requestWithRequestType:(LQRequestType)requestType
                                  serverType:(LQServiceType)serverType
                                 requestPath:(NSString *)path
                                requestparam:(NSDictionary *)params
                                 cachePolicy:(LQRequestCachePolicy)cachePolicy
                                   cacheTime:(NSTimeInterval)cacheTimeLength
                              completeReturn:(completeReturnBlock)completeReturn
{
    return [LQRequestManager managerBaseRequestWithRequestType:requestType serverType:serverType requestPath:path requestParams:params uploadProgress:nil downloadProgress:nil uploadData:nil completeReturn:completeReturn timeOut:0 cachePolicy:cachePolicy cacheTime:cacheTimeLength];
}


#pragma mark 单独设置超时时间
+ (void)requestWithServerType:(LQServiceType)serverType
                         path:(NSString *)path
                        param:(NSDictionary *)parameters
                      timeOut:(NSTimeInterval)timeoutInterval                  //超时
                  requestType:(LQRequestType)requestType                       //请求类型
               completeReturn:(completeReturnBlock)completeReturn;

{
    
}


#pragma mark 数据上传======================================================================
+ (void)uploadAPIWithServerType:(LQServiceType)serverType
                           path:(NSString *)path
                          param:(NSDictionary *)parameters
                    requestType:(LQRequestType)requestType
                         upload:(UploadDataBlock)uploadBlock
                 completeReturn:(completeReturnBlock)completeReturn;

{

}


+ (LQRequestManager *)managerBaseRequestWithRequestType:(LQRequestType)requestType
                                             serverType:(LQServiceType)serverType
                                            requestPath:(NSString *)path
                                          requestParams:(NSDictionary *)params
                                         uploadProgress:(ProgressBlock)uploadProgressBlock
                                       downloadProgress:(ProgressBlock)downloadProgressBlock
                                             uploadData:(UploadDataBlock)uploadBlock
                                         completeReturn:(completeReturnBlock)completeReturn
                                                timeOut:(NSTimeInterval)timeoutInterval
                                            cachePolicy:(LQRequestCachePolicy)cachePolicy
                                              cacheTime:(NSTimeInterval)cacheTimeLength
{
    //组装path
    LQBaseServer<LQBaseServerProtocol> *baseServer = [[LQServerFactory sharedInstance] serviceWithType:serverType];
    
    //    http://cfapi.chaojifan.com/plugin.php?mod=cjfapi&act=index&c=index&m=get_index_ad&app_imei=66a44e18f5ee9635399ecbb917fa11e5
    //      https://cfapi.chaojifan.com/plugin.php?mod=cjfapi&act=index&c=index&m=get_startpage_ad&app_imei=66a44e18f5ee9635399ecbb917fa11e5
    //    NSString *apiPath = [NSString stringWithFormat:@"%@/%@",baseServer.serverUrl,@"plugin.php?mod=cjfapi&act=index&c=index&m=get_startpage_ad&app_imei=66a44e18f5ee9635399ecbb917fa11e5"];
    
    NSString *apiPath = @"http://api.pansou.com/search_new.php?";
    LQRequestManager *manager = [[LQRequestManager alloc] init];
    NSString *cacheKey = nil;
    if (cachePolicy != LQRequestNonuseCacheData) {
        cacheKey = [LQCacheManager getSignStr:params path:apiPath];
        NSDictionary *cacheData = [LQCacheManager readCacheDataWithName:cacheKey cachePolicy:cachePolicy];
        if (cacheData) {
            LQRequestResult *comResult = [LQRequestResult dealWithSessionTask:nil RequestData:cacheData requestError:nil];
            completeReturn(comResult);
            if (cachePolicy == LQRequestUseCacheAndCacheTime) {
                return nil;
            }
        }
    }
    
    LQRequestParamsModel *requestParamsModel = [LQRequestParamsModel dataModelWithServerType:serverType requestPath:apiPath requestParam:params requestType:requestType timeOut:timeoutInterval uploadProgressBlock:^(NSProgress *taskProgress) {

        if (uploadProgressBlock) {
            uploadProgressBlock(taskProgress);
        }
    } downloadProgressBlock:^(NSProgress *taskProgress) {
        if (downloadProgressBlock) {
            downloadProgressBlock(taskProgress);
        }
    } uploadBlock:^(id<AFMultipartFormData> uploadHelp) {
        
        if (uploadBlock) {
            uploadBlock(uploadHelp);
        }
        
    } completeBlock:^(NSURLSessionTask *task, id data, NSError *error) {
        LQRequestResult *comResult = [LQRequestResult dealWithSessionTask:task RequestData:data requestError:error];
        if (!error && data && cachePolicy != LQRequestNonuseCacheData) {
            [LQCacheManager saveDataWithData:data cacheKey:cacheKey cachePolicy:cachePolicy invalidTimeLength:cacheTimeLength withBlock:nil];
        }
        completeReturn(comResult);
    }];
    manager.currentTask = [[LQRequestEngine sharedInstance] callRequestWithRequestModel:requestParamsModel];
    return manager;
}


#pragma mark 取消网络请求
- (void)cancelRequest
{
    if (self.currentTask) {
        [self.currentTask cancel];
        self.currentTask = nil;
    }
}

- (void)dealloc
{
    [self cancelRequest];
}

@end
