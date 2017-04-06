//
//  ZYHomeGGViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//
#import "ZYHomeGGViewController.h"
#import "WebViewController.h"
#import "LQMediator+LQAction_BaseViewController.h"
#import "LQMYScrollView.h"

static NSString *myCell = @"myCell";

@interface ZYHomeGGViewController ()

@property (nonatomic, weak) LQMYScrollView *scr;
@property (nonatomic, weak) UILabel *lb;

@property (nonatomic, strong) UIPanGestureRecognizer *lqPan;

@property (nonatomic, assign) CGPoint beginPoint;

@property (nonatomic, assign) int i;

@end

@implementation ZYHomeGGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    CGFloat centreX = (SCREEN_WIDTH - 40) * 0.5;
    
    
    LQMYScrollView *scr = [[LQMYScrollView alloc] init];
    scr.center = CGPointMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5);
    scr.bounds = CGRectMake(0, 0, centreX * 2, centreX * 2);
    scr.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scr];
    
    [scr addGestureRecognizer:self.lqPan];
    
    UILabel *label = [[UILabel alloc] init];
    label.center = CGPointMake(centreX, 20);
    label.bounds = CGRectMake(0, 0, 50, 20);
    label.text = @"123";
    label.textAlignment = NSTextAlignmentCenter;
    [scr addSubview:label];
    self.scr = scr;
    self.lb = label;
    
    self.i = 1;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    

    
    [UIView animateWithDuration:0.1 animations:^{
        self.scr.transform = CGAffineTransformMakeRotation((self.i ++) / M_PI);
        self.lb.transform = CGAffineTransformMakeRotation(- (self.i ++) / M_PI);
    }];
    
    
}

- (void)panAction:(UIPanGestureRecognizer *)pan
{
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.beginPoint = [pan locationInView:self.scr];
        
        
        MY_Log(@"began--%@",NSStringFromCGPoint([pan locationInView:self.scr]));
    }
    else if (pan.state == UIGestureRecognizerStateChanged) {
        
        CGPoint endPoint = [pan locationInView:self.scr];
        //计算  endPoint - self.beginPoint
        
        
        CGFloat height = endPoint.y - self.beginPoint.y;
        CGFloat width = endPoint.x - self.beginPoint.x;
        CGFloat rads = atan(height/width);
        
        self.scr.transform = CGAffineTransformMakeRotation((self.i ++) / M_PI);
        
        
        
        self.beginPoint = endPoint;
        
        
        
        
        
        
        
        MY_Log(@"changed--%@",NSStringFromCGPoint([pan locationInView:self.scr]));
    }
    else {
        MY_Log(@"end--%@",NSStringFromCGPoint([pan locationInView:self.scr]));
    }
    
    
    
    
}


- (UIPanGestureRecognizer *)lqPan
{
    if (_lqPan == nil) {
        _lqPan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    }
    return _lqPan;
}

































//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    WebViewController *vc = [[WebViewController alloc] init];
//    
//    vc.transParamsDict = @{@"num" : @"1234"};
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
    //本地调用
//    [self nativeTransitionToViewControllerWithName:@"WebViewController" andParams:@{@"2" : @"3"} animated:YES];

    //远程 发起本地调用
//    [self remoteTransitionToViewControllerWithURL:[NSURL URLWithString:@"aaa://BaseViewController/RemoteTransitionToViewControllerWithParams:?pushName==WKViewController$id==https://www.baidu.com"] animated:YES completion:^(NSDictionary *info) {
//        NSLog(@"-------------------%@",info);
//    }];

//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
