//
//  LQBaseCollectViewController.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseScrollViewController.h"
#import "LQBaseCollectionView.h"

@interface LQBaseCollectViewController : LQBaseScrollViewController

@property (nonatomic, strong) LQBaseCollectionView *lqCollectionView;
@property (nonatomic, strong) NSMutableArray *lqCollectMuDataArr;

@end
