//
//  LQBaseScrollViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/23.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseViewController.h"

typedef NS_ENUM(NSInteger, LQRefreshType)
{
    FirstRefreshType, //viewwillappare 刷新
    TopRefreshType,   //下拉刷新
    BotRefreshType,   //上拉加载
};


typedef NS_ENUM(NSInteger, LQAddRefreshType)
{
    AddAllRefresh,   //上，下
    AddTopRefresh,   //下拉刷新
    AddBotRefresh,   //上拉加载
};


@protocol LQBaseScrollViewControllerDelegate <NSObject>
@optional

- (void)refreshCompleteHandle:(LQAddRefreshType)refreshType;

@end


@interface LQBaseScrollViewController : LQBaseViewController <LQBaseScrollViewControllerDelegate>

- (void)addRefreshControlForScroll:(UIScrollView *)scroll addType:(LQAddRefreshType)addType;



@end
