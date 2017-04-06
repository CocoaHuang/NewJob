//
//  LQRequestParamsModel.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/14.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQRequestParamsModel.h"

@implementation LQRequestParamsModel

+ (instancetype)dataModelWithServerType:(LQServiceType)serverType
                            requestPath:(NSString *)requestPath
                           requestParam:(NSDictionary *)requestParams
                            requestType:(LQRequestType)requestType
                                timeOut:(NSTimeInterval)timeoutInterval
                    uploadProgressBlock:(ProgressBlock)uploadProgressBlock
                  downloadProgressBlock:(ProgressBlock)downloadProgressBlock
                            uploadBlock:(UploadDataBlock)uploadBlock
                          completeBlock:(completeRequestBlock)cRequestBlock
{
    LQRequestParamsModel *dataModel = [[LQRequestParamsModel alloc]init];
    dataModel.serverType = serverType;
    dataModel.requestPath = requestPath;
    dataModel.requestParams = requestParams;
    dataModel.requestType = requestType;
    dataModel.uploadProgressBlock = uploadProgressBlock;
    dataModel.downloadProgressBlock = downloadProgressBlock;
    dataModel.uploadBlock = uploadBlock;
    dataModel.cRequestBlock = cRequestBlock;
    dataModel.timeoutInterval = timeoutInterval;
    return dataModel;
}


@end
