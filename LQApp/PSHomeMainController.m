//
//  PSHomeMainController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "PSHomeMainController.h"
#import "PushViewController.h"
#import "LQServerFactory.h"
#import "LQRequestManager.h"
#import "YYPhotoGroupView.h"
#import "WebViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "LQCacheManager.h"
#import <objc/runtime.h>


@interface PSHomeMainController () <UIScrollViewDelegate>

@property (nonatomic, strong) LQRequestManager *mainManager;
@property (nonatomic, strong) UIImageView *img;

@property (nonatomic, strong) UIView *oneView;

@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) CAShapeLayer *shaLayer;

@property (nonatomic, strong) UIView *lastView;

@property (nonatomic, strong) CAReplicatorLayer *reLayer;

@property (nonatomic, strong) NSPort *por;

@end

@implementation PSHomeMainController

////内敛函数  相当于 一个大的宏定义 （适用小，简单的函数）
//static inline int test1() {
//    return 2;
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
//    [LQCacheManager clearAllCacheData];
//    
//    if (self.mainManager) {
//        [self.mainManager cancelRequest];
//    }
//    
//    self.mainManager = [LQRequestManager requestWithrequestType:LQRequestTypeGet serverType:ServiceA requestPath:nil requestparam:nil isUseCache:YES cacheTime:60 completeReturn:^(LQRequestResult *result) {
//        MY_Log(@"2");
//        MY_Log(@"%@",result);
//    }];
//
//    
//    [self.view addSubview:self.img];
//    
//    [self addSub];
//    
//    [self setupRelayer];
    
//    [self.view addSubview:self.oneView];
//    
//    
//    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
//        MY_Log(@"%p",[NSRunLoop currentRunLoop]);
//
//        CFRunLoopStop([NSRunLoop currentRunLoop].getCFRunLoop);
//        MY_Log(@"%p",[NSRunLoop currentRunLoop]);
//
//        [self performSelector:@selector(test2) afterDelay:1];
//        
//    });
    
}

- (void)test10
{
    //线程保活
    for (int i = 0; i < 10000; i ++) {
        NSThread *red = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];
        [red start];
        [self performSelector:@selector(stopThread) onThread:red withObject:nil waitUntilDone:YES];
    }
}

- (void)run
{
    NSRunLoop *curRun = [NSRunLoop currentRunLoop];
    [curRun addPort:self.por forMode:NSDefaultRunLoopMode];
    CFRunLoopRef ref = CFRunLoopGetCurrent();
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(NULL, kCFRunLoopAllActivities, YES, 10000, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
       
        if (activity == kCFRunLoopExit) {
            MY_Log(@"runloop 退出");
        }
        if (activity == kCFRunLoopEntry) {
            MY_Log(@"runloop 进入");
        }

    });
    CFRunLoopAddObserver(ref, observer, kCFRunLoopDefaultMode);
    [curRun run];
}

- (void)stopThread
{
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSThread *re = [NSThread currentThread];
    [re cancel];
}

- (NSPort *)por
{
    if (_por == nil) {
        _por = [NSPort port];
    }
    return _por;
}




- (void)test2
{
    MY_Log(@"被执行");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
        PushViewController *pu = [[PushViewController alloc] init];
        [self.navigationController pushViewController:pu animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

+ (void)test1
{
}


- (id)forwardingTargetForSelector:(SEL)aSelector
{
    
    return self;
}

//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    
//    return YES;
//}

+ (BOOL)resolveClassMethod:(SEL)sel
{
    return YES;
}



- (UIImageView *)img
{
    if (_img == nil) {
        _img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"center@2x"]];
        _img.frame = CGRectMake(100, 100, 30, 30);
        _img.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            UIView *fromView = nil;
            YYPhotoGroupItem *item = [YYPhotoGroupItem new];
            item.thumbView = _img;
            item.largeImageURL = nil;
            item.largeImageSize = CGSizeMake(fromView.width, fromView.height);
            fromView = _img;
            YYPhotoGroupView *v = [[YYPhotoGroupView alloc] initWithGroupItems:@[item]];
            [v presentFromImageView:fromView toContainer:self.view.window animated:YES completion:nil];
        }];
        [_img addGestureRecognizer:tap];
    }
    return _img;
}

- (UIView *)oneView
{
    if (_oneView == nil) {
        
        _oneView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
        _oneView.backgroundColor = [UIColor purpleColor];
        _oneView.layer.borderWidth = 20;
        _oneView.layer.borderColor = [UIColor blackColor].CGColor;
    }
    return _oneView;
}


- (void)addSub
{
    CGFloat viewW = SCREEN_WIDTH / 3.f;
    [self.view addSubview:self.mainScroll];
    for (int i = 0; i < 4; i ++) {
        UIView *scrollSubView = [[UIView alloc] initWithFrame:CGRectMake(i * viewW, 0, viewW, 100)];
        scrollSubView.backgroundColor = [UIColor purpleColor];
        [self.mainScroll addSubview:scrollSubView];
    }
    [self.mainScroll setContentSize:CGSizeMake(viewW * 4, 0)];
    
    self.lastView.frame = CGRectMake(viewW * 4, 0, 25, 100);
    self.shaLayer.frame = CGRectMake(0, 0, 25, 100);
    [self.lastView.layer addSublayer:self.shaLayer];
    [self.mainScroll addSubview:self.lastView];
    

}


- (UIScrollView *)mainScroll
{
    if (_mainScroll == nil) {
        _mainScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 300, SCREEN_WIDTH, 100)];
        _mainScroll.delegate = self;
    }
    return _mainScroll;
}

- (CAShapeLayer *)shaLayer
{
    if (_shaLayer == nil) {
        _shaLayer = [CAShapeLayer layer];
        _shaLayer.backgroundColor = [UIColor redColor].CGColor;
    }
    return _shaLayer;
}

- (UIView *)lastView
{
    if (_lastView == nil) {
        _lastView = [[UIView  alloc] init];
        _lastView.backgroundColor = [UIColor whiteColor];
    }
    return _lastView;
}

#pragma mark delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat viewW = SCREEN_WIDTH / 3.f;
    CGFloat contenSizeW = viewW * 4.f;
    
    if (scrollView.contentOffset.x + SCREEN_WIDTH >= contenSizeW + 25) {
        self.lastView.frame = CGRectMake(scrollView.contentOffset.x + SCREEN_WIDTH - 25, 0, 25, 100);
        
        
        CGFloat pianyi = scrollView.contentOffset.x + SCREEN_WIDTH - contenSizeW - 25;
        
        
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(25, 0)];
        [path addLineToPoint:CGPointMake(25, 100)];
        [path addLineToPoint:CGPointMake(0, 100)];
        [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(-pianyi, 50)];
        self.shaLayer.fillColor = [UIColor redColor].CGColor;
        self.shaLayer.path = path.CGPath;
        
    }
    else {
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(25, 0)];
        [path addLineToPoint:CGPointMake(25, 100)];
        [path addLineToPoint:CGPointMake(0, 100)];
        [path addQuadCurveToPoint:CGPointMake(0, 0) controlPoint:CGPointMake(0, 50)];
        self.shaLayer.fillColor = [UIColor redColor].CGColor;
        self.shaLayer.path = path.CGPath;
        self.lastView.frame = CGRectMake(viewW * 4, 0, 25, 100);
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat viewW = SCREEN_WIDTH / 3.f;
    CGFloat contenSizeW = viewW * 4.f;
    CGFloat pianyi = scrollView.contentOffset.x + SCREEN_WIDTH - contenSizeW - 25;
    
    
    
    if (pianyi > 25) {
        MY_Log(@"----开始执行");
        [self remoteTransitionToViewControllerWithURL:[NSURL URLWithString:@"aaa://BaseViewController/RemoteTransitionToViewControllerWithParams:?pushName==WebViewController$id==https://www.baidu.com"] animated:YES completion:^(NSDictionary *info) {
            NSLog(@"-------------------%@",info);
        }];
    }
}



- (void)setupRelayer
{
    self.reLayer.frame = CGRectMake(0, 180, SCREEN_WIDTH, 100);
    [self.view.layer addSublayer:self.reLayer];
}


- (CAReplicatorLayer *)reLayer
{
    if (_reLayer == nil) {
        _reLayer = [CAReplicatorLayer layer];
        CALayer *subLayer = [CALayer layer];
        subLayer.backgroundColor = [UIColor redColor].CGColor;
        subLayer.frame = CGRectMake(0, 0, 20, 20);
        subLayer.cornerRadius = 10.f;
        
        CABasicAnimation *an = [CABasicAnimation animationWithKeyPath:@"position.y"];
        
        an.fromValue = @(-100);
        an.byValue = @0;
        an.toValue = @400;
        
        an.duration = 1;
        an.repeatCount = INTMAX_MAX;
        an.autoreverses = YES;
        [subLayer addAnimation:an forKey:@"oneAn"];
        
        _reLayer.instanceCount = 10;
        _reLayer.instanceDelay = an.duration * 3 / 10;
        _reLayer.instanceTransform = CATransform3DMakeTranslation(25, 0, 0);
        [_reLayer addSublayer:subLayer];
    }
    return _reLayer;
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
