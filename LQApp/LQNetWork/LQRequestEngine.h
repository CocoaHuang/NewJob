//
//  LQRequestEngine.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/14.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LQRequestConfigure.h"
#import "LQRequestParamsModel.h"


@interface LQRequestEngine : NSObject

+ (instancetype)sharedInstance;

- (NSURLSessionTask *)callRequestWithRequestModel:(LQRequestParamsModel *)requestModel;

@end
