//
//  LQTabBarView.m
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/1/10.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import "LQTabBarView.h"
#import "LQBaseButton.h"

@interface LQTabBarView ()

@property (nonatomic, weak) LQBaseButton *selectBtn;

@end

@implementation LQTabBarView


- (void)addItemWithTitle:(NSString *)itemTitle normalImg:(NSString *)itemNormal selectImg:(NSString *)selectImg normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor
{
    LQBaseButton *itemBtn = [LQBaseButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setTitle:itemTitle forState:UIControlStateNormal];
//    [itemBtn setTitleColor:COLOR_RGB_ALPHA(147, 147, 147,1) forState:UIControlStateNormal];
//    [itemBtn setTitleColor:COLOR_RGB_ALPHA(204, 34, 44,1) forState:UIControlStateSelected];
    [itemBtn setTitleColor:normalColor forState:UIControlStateNormal];
    [itemBtn setTitleColor:selectColor forState:UIControlStateSelected];
    [itemBtn.titleLabel setFont:[UIFont systemFontOfSize:10]];
    [itemBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [itemBtn setImage:[UIImage imageNamed:itemNormal] forState:UIControlStateNormal];
    [itemBtn setImage:[[UIImage imageNamed:selectImg] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    itemBtn.tag = self.subviews.count;
    [self addSubview:itemBtn];
    [itemBtn addTarget:self action:@selector(itemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    if (itemBtn.tag == 0) {
        itemBtn.selected = YES;
        _selectBtn = itemBtn;
    }
}

- (void)itemBtnClick:(LQBaseButton *)sender
{
    [self changeSelectIndex:sender];
}

- (void)changeSelectIndex:(LQBaseButton *)sender
{
    if (sender.tag != _selectBtn.tag)
    {
        sender.selected = YES;
        _selectBtn.selected = NO;
        _selectBtn = sender;
        self.tabBarSelectItemBlock(sender.tag);
    }
    else
    {
        return;
    }
}

- (void)setSelectIndex:(NSUInteger)selectIndex
{
    if (self.subviews.count == 0) {
        return;
    }
    LQBaseButton *btn =  self.subviews[selectIndex];
    [self changeSelectIndex:btn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat itemW = SCREEN_WIDTH / self.subviews.count;
    CGFloat imgW = 24.f;
    CGFloat imgX = (itemW - imgW) * 0.5;
    CGFloat margin = 6.5;
//    CGRect imgRect = CGRectMake(imgX, margin, imgW, imgW);
    CGRect imgRect = CGRectMake(imgX, margin, imgW, imgW);
    CGFloat titleW = itemW;
    CGFloat titleH = 5;
    CGRect titleRect = CGRectMake(0, 40, titleW, titleH);
    for (int i = 0; i < self.subviews.count; i ++)
    {
        LQBaseButton *itemBtn = self.subviews[i];
        itemBtn.cusImgFrame = imgRect;
        itemBtn.cusTitleFrame = titleRect;
        itemBtn.frame = CGRectMake(i * itemW, 0, itemW, TABBAR_DEFAULT_DEIGHT);
    }
}


//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
//{
//    if (!self.clipsToBounds && !self.hidden && self.alpha > 0)
//    {
//
//        UIView *result = [super hitTest:point withEvent:event];
//        if (result) {
//            return result;
//        }
//        else {
//            for (UIView *subview in self.subviews.reverseObjectEnumerator)
//            {
//                //将当前点击point转换到subview坐标系中
//                CGPoint subPoint = [subview convertPoint:point fromView:self];
//                result = [subview hitTest:subPoint withEvent:event];
//                if (result) {
//                    return result;
//                }
//            }
//        }
//    }
//    return nil;
//}


//- (BOOL)pointInside:(CGPoint)point withEvent:(nullable UIEvent *)event
//{
//    for (UIView *sub in self.subviews) {
//        if (CGRectContainsPoint(sub.frame, point)) {
//            return YES;
//        }
//    }
//    return NO;
//}






@end
