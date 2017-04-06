//
//  LQBaseScrollViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/23.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseScrollViewController.h"
#import "LQDIYRefreshHeader.h"
#import "LQDIYRefreshFooter.h"


@interface LQBaseScrollViewController ()

@property (nonatomic, strong) LQDIYRefreshHeader *refreshHeader;
@property (nonatomic, strong) LQDIYRefreshFooter *refreshFooter;

@property (nonatomic, strong) UITableView *table;

@end

@implementation LQBaseScrollViewController


- (void)addRefreshControlForScroll:(UIScrollView *)scroll addType:(LQAddRefreshType)addType
{
    if (addType == AddAllRefresh) {
        scroll.mj_header = self.refreshHeader;
        scroll.mj_footer = self.refreshFooter;
    }
    else if (addType == AddTopRefresh) {
        scroll.mj_header = self.refreshHeader;
    }
    else {
        scroll.mj_footer = self.refreshFooter;
    }
}

- (void)refreshComplete:(MJRefreshComponent *)refreshControl
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 拿到当前的上拉刷新控件，结束刷新状态
        if (refreshControl == _refreshHeader) {
            if ([self respondsToSelector:@selector(refreshCompleteHandle:)]) {
                [self refreshCompleteHandle:AddTopRefresh];
            }
            [_refreshHeader endRefreshing];
        }
        else {
            if ([self respondsToSelector:@selector(refreshCompleteHandle:)]) {
                [self refreshCompleteHandle:AddBotRefresh];
            }
            [_refreshFooter endRefreshing];
        }
    });
}

- (LQDIYRefreshHeader *)refreshHeader
{
    if (_refreshHeader == nil) {
        _refreshHeader = [LQDIYRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshComplete:)];
    }
    return _refreshHeader;
}

- (LQDIYRefreshFooter *)refreshFooter
{
    if (_refreshFooter == nil) {
        _refreshFooter = [LQDIYRefreshFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshComplete:)];
    }
    return _refreshFooter;
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
