//
//  LQBaseTabBarViewController.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQBaseTabBarViewController.h"
#import "LQBaseViewController.h"
#import "LQBaseNavViewController.h"
#import "LQTabBarView.h"
#import "LQBaseTabBar.h"

@interface LQBaseTabBarViewController ()

@property (nonatomic, strong) LQTabBarView *baseTabBarView;

@end

@implementation LQBaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)setup
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self addSubNavController];
}

- (void)addSubNavController
{
    
    LQBaseTabBar *baseTaBar = [[LQBaseTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TABBAR_DEFAULT_DEIGHT)];
    [self setValue:baseTaBar forKey:@"tabBar"];

    NSArray *itemTitleArr = @[@"盘搜",@"",@"个人",@"照片"];
    NSArray *itemNormalImgArr = @[@"tabbar_home",@"center@2x",@"center@2x",@"center@2x"];
    NSArray *itemSelectImgArr = @[@"tabbar_home_sl",@"tabbar_fuwu_sl",@"tabbar_person_sl",@"tabbar_person_sl"];
    NSArray *itemSubNavArr = @[@"PSHomeMainController",@"ZYHomeGGViewController",@"PSPersonMainController",@"LQPhoneViewController"];
    
    
    for (int i = 0; i < itemTitleArr.count; i ++) {
        [self addNavControllWithName:itemSubNavArr[i] itemTitle:itemTitleArr[i] normalImage:itemNormalImgArr[i] selectImage:itemSelectImgArr[i] normalColor:COLOR_RGB_ALPHA(147, 147, 147,1) selectColor:COLOR_RGB_ALPHA(204, 34, 44,1)];
    }
    
    self.tabBar.translucent = NO;
    self.tabBar.backgroundImage = [[UIImage imageNamed:@"taobar_bg"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    self.tabBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tabbar_bg"]];
//    [self.tabBar addSubview:self.baseTabBarView];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    [super setSelectedIndex:selectedIndex];
    self.baseTabBarView.selectIndex = selectedIndex;
}

- (void)addNavControllWithName:(NSString *)vcName itemTitle:(NSString *)itemTitle normalImage:(NSString *)normalItemImage selectImage:(NSString *)selectItemImage normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor
{
    Class vc = NSClassFromString(vcName);
    LQBaseViewController *rootVc = [[vc alloc] init];
    LQBaseNavViewController *navVc = [[LQBaseNavViewController alloc] initWithRootViewController:rootVc];

    navVc.tabBarItem.title = itemTitle;
    navVc.tabBarItem.image = [[UIImage imageNamed:normalItemImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectItemImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [navVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : normalColor} forState:UIControlStateNormal];
    [navVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : selectColor} forState:UIControlStateSelected];
    
    NSMutableArray *muArr = [NSMutableArray arrayWithArray:self.viewControllers];
    [muArr addObject:navVc];
    self.viewControllers = muArr;
    rootVc.hidesBottomBarWhenPushed = NO;

//    [self.baseTabBarView addItemWithTitle:itemTitle normalImg:normalItemImage selectImg:selectItemImage normalColor:normalColor selectColor:selectColor];
}

- (LQTabBarView *)baseTabBarView
{
    if (_baseTabBarView == nil) {
        _baseTabBarView = [[LQTabBarView alloc] initWithFrame:self.tabBar.bounds];
        [_baseTabBarView setBackgroundColor:[UIColor whiteColor]];
        @weakify(self);
        _baseTabBarView.tabBarSelectItemBlock = ^(NSInteger index){
            @strongify(self)
            self.selectedIndex = index;
        };
    }
    return _baseTabBarView;
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
