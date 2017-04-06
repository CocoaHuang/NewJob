//
//  PushViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "PushViewController.h"

@interface PushViewController ()

@property (nonatomic, strong) NSHashTable *hsTabel;

@property (nonatomic, assign) int i;

@property (nonatomic, strong) NSRunLoop *rm;

@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self test8];
    
    
    NSLog(@"hash_%@",self.hsTabel);
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
////        MY_Log(@"---%p",[NSRunLoop currentRunLoop]);
//
//        
//        
//        CFRunLoopStop(CFRunLoopGetCurrent())
//        ;
//    });

}


- (void)test9
{
    
}

- (void)test8
{
    
    NSBlockOperation *task1 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 5; i ++) {
                MY_Log(@"task1执行---%@",task1.name);
            }
        });
        
    }];
    
    NSBlockOperation *task2 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 5; i ++) {
                MY_Log(@"task2执行---%@",task2.name);
            }
            
        });

    }];

    
    NSBlockOperation *task3 = [NSBlockOperation blockOperationWithBlock:^{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (int i = 0; i < 5; i ++) {
                MY_Log(@"task3执行---%@",task3.name);
            }
        });
    }];
    
    NSBlockOperation *task4 = [NSBlockOperation blockOperationWithBlock:^{
        MY_Log(@"全部执行完成");
        
    }];

    
    [task2 addDependency:task1];
    [task3 addDependency:task2];
    [task4 addDependency:task3];
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperations:@[task1, task2, task3, task4] waitUntilFinished:YES];
    
    
    
}

- (void)test7
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"%@", [NSThread currentThread]);
    }];
    //添加多个Block
    for (NSInteger i = 0; i < 5; i++) {
        [operation addExecutionBlock:^{
            NSLog(@"第%ld次：%@", i, [NSThread currentThread]);
        }];
    }
    //2.开始任务
    [operation start];
}


- (void)test4
{
    dispatch_queue_t que = dispatch_queue_create("com.my.queue", DISPATCH_QUEUE_SERIAL);
    self.i = 0;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSPort *por = [NSPort port];
//        [[NSRunLoop currentRunLoop] addPort:por forMode:@"com.runLoop"];
        MY_Log(@"---%p",[NSRunLoop currentRunLoop]);
        self.rm = [NSRunLoop currentRunLoop];
        [self nslog:que];
    });
//    [self nslog];
}

- (void)nslog:(dispatch_queue_t)que
{
    for (int i = 0; i < 10000; i ++) {
//        MY_Log(@"%d",i);
    }
    self.i ++;
    if (self.i < 10000) {
        dispatch_sync(que, ^{
            MY_Log(@"---%p",[NSRunLoop currentRunLoop]);
            [self nslog:que];
        });
    }
}

- (void)test1
{
    NSObject *obj1 = [[NSObject alloc] init];
    NSObject *obj2 = [[NSObject alloc] init];
    NSObject *obj3 = [[NSObject alloc] init];
    
    
    
    
    
    NSString *str11 = [[NSString alloc] init];
    NSString *str22 = @"2";
    NSString *str33 = @"3";
    
    NSMutableString *muArr = [NSMutableString stringWithFormat:@"2"];
    NSLog(@"st1的引用计数%@---%@",[muArr valueForKey:@"retainCount"],[str11 valueForKey:@"retainCount"]);

    str11 = muArr;

    NSLog(@"st1的引用计数%@---%@",[str11 valueForKey:@"retainCount"],[str11 valueForKey:@"retainCount"]);
    
    
    [self.hsTabel addObject:obj1];
    [self.hsTabel addObject:obj2];
    [self.hsTabel addObject:obj3];
    [self.hsTabel addObject:str11];
    [self.hsTabel addObject:str22];
    [self.hsTabel addObject:str33];
    
    
    NSLog(@"st1的引用计数%@",[str11 valueForKey:@"retainCount"]);
    
    
    
    //    NSArray *arr = @[str1, str2, str3, str4, str5];
    NSArray *arr = nil;
    
    NSLog(@"hash_%@,arr_%@",self.hsTabel,arr);
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.navigationController leftPopAboveViewController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSHashTable *)hsTabel
{
    if (_hsTabel == nil) {
        _hsTabel = [NSHashTable weakObjectsHashTable];
    }
    return _hsTabel;
}

- (void)dealloc
{
    
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
