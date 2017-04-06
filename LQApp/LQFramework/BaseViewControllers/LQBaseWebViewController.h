//
//  LQBaseWebViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/11.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseScrollViewController.h"


@protocol LQBaseWebViewDelegate <NSObject>
@optional

- (BOOL)lqWebViewShouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
- (void)lqWebViewDidStartLoad;
- (void)lqWebViewDidFinishLoad;


@end

@interface LQBaseWebViewController : LQBaseScrollViewController <UIWebViewDelegate, LQBaseWebViewDelegate>

- (void)setupWebViewWithFrame:(CGRect)iFame;
@property (nonatomic, strong) UIWebView *mainWebView;
@property (nonatomic, assign) BOOL isUseProgress;
@property (nonatomic, assign) BOOL isShowRefteshBtn;
- (void)starLoadRequestWithRequest:(NSURLRequest *)request isUseProgress:(BOOL)isUseProgress;
- (void)refreshBtnClick:(UIWebView *)mainWebView;

@end
