//
//  Fcgo_OrderDetailTableHeaderView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderDetailTableHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) UILabel      *titleLabel;
@property (nonatomic,strong) UIControl    *logisticsControl;//点击查看物流

@property (nonatomic,strong) UILabel      *orderStatusLabel;
@property (nonatomic,strong) UIImageView  *arrowImageView;

@property (nonatomic,copy) void(^logisticsBlock)(void);

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
