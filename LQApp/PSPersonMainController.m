//
//  PSPersonMainController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "PSPersonMainController.h"
#import "WKViewController.h"


@interface PSPersonMainController () <CAAnimationDelegate>

@property (nonatomic, strong) UIView *oneView;

@property (nonatomic, strong) UIImageView *oneImg;
@property (nonatomic, strong) UIImageView *towImg;

@property (nonatomic, strong) NSMutableArray *numArr;

@end

@implementation PSPersonMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    [self setup];

}

- (void)setup
{
//    [self.view addSubview:self.oneView];
    
//    self.oneView.transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.5, 0.5), CGAffineTransformMakeTranslation(0, 300));
//    
//    [UIView animateWithDuration:2 animations:^{
//       
//        //还原到self.oneView的初使状态
//        self.oneView.transform = CGAffineTransformIdentity;
//        
//    }];
    
//    [UIView animateKeyframesWithDuration:10 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
//        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
//            self.oneView.transform = CGAffineTransformMakeTranslation(0, self.oneView.top + 100);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.4 animations:^{
//           
//            
//            
//            self.oneView.transform = CGAffineTransformMakeTranslation(0, self.oneView.top + 20);
//
//            
////            self.oneView.transform = CGAffineTransformMakeScale(0.3, 0.3);
//        }];
//        
//        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
//            
////            self.oneView.transform = CGAffineTransformMakeTranslation(0, self.oneView.top + 50);
//
//           
//            self.oneView.transform = CGAffineTransformMakeRotation(M_PI);
//        }];
//    } completion:^(BOOL finished) {
//        
//    }];
    [self text7];
}


- (void)text7
{
    
    [self numArr];
    for (unsigned i = 0; i < self.numArr.count; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            @synchronized (self) {
                MY_Log(@"%@", self.numArr[i]);
            }
        });
    }
}


- (void)test1
{
    [self.view addSubview:self.oneImg];
    [self.view addSubview:self.towImg];
    
    UIView *mask = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    mask.backgroundColor = [UIColor clearColor];
    
    for (int i = 0; i < 10; i ++) {
        
        UIView *sub = [[UIView alloc] initWithFrame:CGRectMake(i * 30, 0, 30, 300)];
        sub.backgroundColor = [UIColor whiteColor];
        [mask addSubview:sub];
        
    }
    self.towImg.maskView = mask;
    
    
    CGFloat time = 0.8;
    for (int i = 0; i < mask.subviews.count; i ++) {
        UIView *one = mask.subviews[i];
        [UIView animateWithDuration:time delay:i * 0.3 * time options:UIViewAnimationOptionCurveLinear animations:^{
            one.alpha = 0;
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
}

- (void)test2
{
    [self.view addSubview:self.oneImg];
    
    self.oneImg.layer.anchorPoint = CGPointMake(0.5, SCREEN_HEIGHT / 2 - 10);
    
    
}

- (void)test3
{
    [self.view addSubview:self.oneImg];
    
    NSLog(@"%@----%@",NSStringFromCGPoint(self.oneImg.layer.anchorPoint),NSStringFromCGPoint(self.oneImg.layer.position));
    
    
//    self.oneImg.layer.anchorPoint = CGPointMake(0, 0);
//    
//    NSLog(@"%@----%@",NSStringFromCGPoint(self.oneImg.layer.anchorPoint),NSStringFromCGPoint(self.oneImg.layer.position));
    
    
    self.oneImg.layer.position = CGPointMake(SCREEN_WIDTH / 2 - 10, SCREEN_HEIGHT / 2);
    
    NSLog(@"%@----%@",NSStringFromCGPoint(self.oneImg.layer.anchorPoint),NSStringFromCGPoint(self.oneImg.layer.position));


}

- (void)test4
{
    [self.view addSubview:self.oneImg];
    CABasicAnimation *pr = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pr.duration = 3;
    pr.repeatCount = 1;
    pr.autoreverses = YES;
    
    pr.toValue = @0.1f;
    pr.delegate = self;
    
    [self.oneImg.layer addAnimation:pr forKey:@"abc"];
}

- (void)test5
{
    CAShapeLayer *shalay = [CAShapeLayer layer];
    shalay.fillColor = [UIColor blueColor].CGColor;
    shalay.frame = CGRectMake(SCREEN_WIDTH * 0.5, SCREEN_HEIGHT * 0.5, 50, 50);
    shalay.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(25, 25) radius:25 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
    [self.view.layer addSublayer:shalay];
}


#pragma mark AnimationDelegate
- (void)animationDidStart:(CAAnimation *)anim
{
    MY_Log(@"开始");
    
    
    [self.oneImg.layer removeAnimationForKey:@"abc"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        MY_Log(@"完成");
    }
    else {
        MY_Log(@"停止");
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
//    WKViewController *vc = [[WKViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIView *)oneView
{
    if (_oneView == nil) {
        _oneView = [[UIView alloc] init];
        _oneView.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        _oneView.bounds = CGRectMake(0, 0, 300, 300);
        _oneView.backgroundColor = [UIColor redColor];
    }
    return _oneView;
}

- (UIImageView *)oneImg
{
    if (_oneImg == nil) {
        
        _oneImg = [[UIImageView alloc] init];
        _oneImg.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        _oneImg.bounds = CGRectMake(0, 0, 300, 300);
        _oneImg.image = [UIImage imageNamed:@"guide_img_1"];
    }
    return _oneImg;
}


- (UIImageView *)towImg
{
    if (_towImg == nil) {
        _towImg = [[UIImageView alloc] init];
        _towImg.center = CGPointMake(SCREEN_WIDTH / 2, SCREEN_HEIGHT / 2);
        _towImg.bounds = CGRectMake(0, 0, 300, 300);
        _towImg.image = [UIImage imageNamed:@"guide_img_4"];
    }
    return _towImg;
}

- (NSMutableArray *)numArr
{
    if (!_numArr) {
        _numArr = [NSMutableArray array];
        for (int i = 0; i < 100; i ++) {
            [_numArr addObject:[NSNumber numberWithInt:i]];
        }
    }
    return _numArr;
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
