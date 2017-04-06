//
//  LQViewCell.h
//  LQApp
//
//  Created by 杭州掌赢科技 on 2017/3/8.
//  Copyright © 2017年 HangZhouZhangYing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LQViewCell : UITableViewCell
//
//IBOutletCollection集合中对象的顺序是不确定的。我们通过调试方法可以看到集合中对象的顺序跟我们连接的顺序是一样的。但是这个顺序可能会因为不同版本的Xcode而有所不同。所以我们不应该试图在代码中去假定这种顺序。
//不管IBOutletCollection(ClassName)中的控件是什么，属性的类型始终是NSArray。实际上，我们可以声明是任何类型，如NSSet，NSMutableArray，甚至可以是UIColor，但不管我们在此设置的是什么类，IBOutletCollection属性总是指向一个NSArray数组。

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *LabelArr;


@end
