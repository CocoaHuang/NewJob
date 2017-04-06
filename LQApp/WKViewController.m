//
//  WKViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/12.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "WKViewController.h"

@interface WKViewController ()

@end

@implementation WKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
        
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupWKbViewWithFrame:self.view.bounds];
    [self.view addSubview:self.mainWebView];
    NSString *path = @"https://item.taobao.com/item.htm?spm=a21bo.50862.201875.23.Kw8Wto&scm=1007.12493.65979.100200300000001&id=527952851167&pvid=849e7ea5-1915-4470-82d7-2440e3e7c5e8";
    NSURLRequest *requ = [NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    
    [self starLoadRequestWithRequest:requ isUseProgress:YES];
}

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
