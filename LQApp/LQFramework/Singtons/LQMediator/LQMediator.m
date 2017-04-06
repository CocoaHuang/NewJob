//
//  LQMediator.m
//  LQFramework
//
//  Created by 杭州掌赢科技 on 2017/1/19.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQMediator.h"

@implementation LQMediator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static LQMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[LQMediator alloc] init];
        //获取调度表
    });
    return mediator;
}

/*
 scheme://[target]/[action]?[params]
 url sample:
 aaa://targetA/actionB?id=1234
 */

- (id)performActionWithUrl:(NSURL *)url completion:(void (^)(NSDictionary *))completion
{
    //路由逻辑
    //warning todo 修改aaa为你自己app的scheme    URL路由的逻辑处理获取到targetA，actionB，params
    if (![url.scheme isEqualToString:@"aaa"])
    {
        // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，你们可以在这里自己做需要的逻辑
        return nil;
    }

    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    
    //pushName==WebViewController$id==https://www.hao123.com?a=1&b=2
    for (NSString *param in [urlString componentsSeparatedByString:@"$"])
    {
        NSArray *elts = [param componentsSeparatedByString:@"=="];
        if([elts count] < 2) continue;
        [params setObject:[elts lastObject] forKey:[elts firstObject]];
    }
//    NSLog(@"参数---%@",params);
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    
    if ([actionName hasPrefix:@"Native"]) {
        //验证
        return nil;
    }

    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑

    id result = [self performTarget:url.host action:actionName params:params];
    
    if (completion) {
        if (result) {
            completion(@{@"result":result});
        } else {
            completion(nil);
        }
    }
    return result;
}


- (id)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params
{
    NSString *targetClassString = [NSString stringWithFormat:@"LQTarget_%@", targetName];
    NSString *actionString = [NSString stringWithFormat:@"LQAction_%@", actionName];
    Class targetClass = NSClassFromString(targetClassString);
    
    id target = [[targetClass alloc] init];
    SEL action = NSSelectorFromString(actionString);
    
    if (target == nil)
    {
        // 这里是处理无响应请求的地方之一，这个demo做得比较简单，如果没有可以响应的target，就直接return了。实际开发过程中是可以事先给一个固定的target专门用于在这个时候顶上，然后处理这种请求的
        return nil;
    }
    
    
    if ([target respondsToSelector:action])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        
    }
    else
    {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        
        if ([target respondsToSelector:action]) {
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
        } else
        {
            //这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            return nil;
        }
    }
}


//路由 {
        //组件调度表
        //URLSchem
        //权限
//}


//组件：{
//    VC
//    暴露的接口
//}
//
//中间件：{
//    本地：直接调用target-action
//    远程：通过匹配组件URLSchem   进行调度
//    维护 URLSchem表}
//}



@end
