//
//  LQMediator+LQAction_BaseViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQMediator+LQAction_BaseViewController.h"

@implementation LQMediator (LQAction_BaseViewController)

- (UIViewController *)basicNativePushViewControllerWithVCName:(NSString *)vcName andParams:(NSDictionary *)params
{
#pragma mark  针对target下的action进行动态调度  1.根据服务器给的调度文件进行动态调度  2.根据接口进行动态调度
    UIViewController *vc = nil;
    if (!vcName || ![vcName isKindOfClass:[NSString class]]) {
        return vc;
    }
    NSDictionary *creatVcParams = @{@"LQMediatorTargetVCName" : vcName};
    vc = [self performTarget:@"BaseViewController" action:@"NativeTransitionToViewControllerWithParams:" params:creatVcParams];
    if (!vc) {
        return nil;
    }
    vc.transParamsDict = params;
    return vc;
}



//- (UIViewController *)baseRemotePushViewControllerWithParams:(NSDictionary *)params
//{
//    NSString *vcName = [params valueForKey:kLQMediatorVC];
////    id completeBlock = [params valueForKey:kLQMediatorBlock];
////    [self basePushViewControllerWithName:vcName complete:completeBlock];
//    UIViewController *vc = nil;
//    vc = [self baseNativePushViewControllerWithParams:vcName];
//    return vc;
//}

@end
