//
//  LQBaseWKWebViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/12.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseScrollViewController.h"
#import <WebKit/WebKit.h>


@protocol LQBaseWKWebViewDelegate <NSObject>

@optional

- (BOOL)lqWKWebViewdecidePolicyForNavigationAction:(WKNavigationAction *)navigationAction;
- (void)lqWKWebViewDidFinishLoad;

@end


@interface LQBaseWKWebViewController : LQBaseScrollViewController <WKUIDelegate,WKNavigationDelegate,LQBaseWKWebViewDelegate>

@property (nonatomic, strong) WKWebView *mainWebView;
- (void)setupWKbViewWithFrame:(CGRect)iFame;
@property (nonatomic, assign) BOOL isUseProgress;
@property (nonatomic, assign) BOOL isShowRefteshBtn;
- (void)starLoadRequestWithRequest:(NSURLRequest *)request isUseProgress:(BOOL)isUseProgress;


@end
