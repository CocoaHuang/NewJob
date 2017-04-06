//
//  WebViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/11.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "WebViewController.h"
#import "LQRequestManager.h"


@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    MY_Log(@"-------%@",self.transParamsDict);
    
//    [LQRequestManager requestWithServerType:ServiceA path:nil controller:self param:nil requestType:LQRequestTypeGet completeReturn:^(LQRequestResult *result) {
//        
//    }];
    
    
    
    
    [self setupWebViewWithFrame:self.view.bounds];
    [self.view addSubview:self.mainWebView];
    NSString *path = @"https://item.taobao.com/item.htm?spm=a21bo.50862.201875.23.Kw8Wto&scm=1007.12493.65979.100200300000001&id=527952851167&pvid=849e7ea5-1915-4470-82d7-2440e3e7c5e8";
    
//    NSString *path = [self.transParamsDict valueForKey:@"id"];
    
    NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [self starLoadRequestWithRequest:requ isUseProgress:YES];
    NSLog(@"-=-=%@",self.transParamsDict);
//     Do any additional setup after loading the view.
//    MY_Log(@"-------------%@",[UIApplication sharedApplication].currentViewContrl);
    MY_Log(@"-------------%@",LQCurrentViewController);
    
    MY_Log(@"viewDidLoad");
    
    
    // 1. 创建监听者
    /*
     CFAllocatorRef allocator 分配存储空间
     CFOptionFlags activities 要监听哪个状态，kCFRunLoopAllActivities监听所有状态
     Boolean repeats 是否持续监听RunLoop的状态
     CFIndex order 优先级，默认为0
     Block activity RunLoop当前的状态
     */
    
//    __block int i = 0;
//    CFRunLoopObserverRef ober = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault , kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
//        
//        //        kCFRunLoopEntry = (1UL << 0),
//        //        kCFRunLoopBeforeTimers = (1UL << 1),
//        //        kCFRunLoopBeforeSources = (1UL << 2),
//        //        kCFRunLoopBeforeWaiting = (1UL << 5),
//        //        kCFRunLoopAfterWaiting = (1UL << 6),
//        //        kCFRunLoopExit = (1UL << 7),
//        
//        switch (activity) {
//            case kCFRunLoopEntry:
//            {
//                NSLog(@"进入");
//                break;
//            }
//            case kCFRunLoopBeforeTimers:
//            {
//                NSLog(@"即将处理timers事件");
//                break;
//            }
//            case kCFRunLoopBeforeSources:
//            {
//                NSLog(@"即将处理源事件");
//                break;
//            }
//            case kCFRunLoopBeforeWaiting:
//            {
//                NSLog(@"即将休眠");
//                
//                break;
//            }
//            case kCFRunLoopAfterWaiting:
//            {
//                NSLog(@"唤醒");
//                break;
//            }
//            case kCFRunLoopExit:
//            {
//                NSLog(@"退出");
//                break;
//            }
//            default:
//                break;
//        }
//        
//        MY_Log(@"-----%d",i ++);
//    });
//    CFRunLoopAddObserver(CFRunLoopGetCurrent(), ober, kCFRunLoopCommonModes);

//    [self test1];

}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    MY_Log(@"viewDidAppear");
}


- (void)test1
{
    MY_Log(@"开始");
    int j = 0;
    for (int i = 0; i < 100000000; i ++) {
        j += i;
    }
    MY_Log(@"结束");
    
//    2017-03-07 11:04:24.814 LQApp[13433:380145] viewDidLoad
//    2017-03-07 11:04:28.098 LQApp[13433:380145] viewDidAppear
    
    
//    2017-03-07 11:05:16.700 LQApp[13484:380941] viewDidLoad
//    2017-03-07 11:05:20.014 LQApp[13484:380941] viewDidAppear
    
//    2017-03-07 11:07:11.514 LQApp[13565:382359] 当前跟控制器：<LQBaseTabBarViewController: 0x7fd0df537200>
//    2017-03-07 11:07:12.622 LQApp[13565:382359] viewDidAppear
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    MY_Log(@"销毁");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
