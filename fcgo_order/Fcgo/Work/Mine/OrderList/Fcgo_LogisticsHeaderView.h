//
//  Fcgo_LogisticsHeaderView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_LogisticsHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) UILabel  *freightNumLabel,*freightNum;
@property (nonatomic,strong) UILabel  *freightState;
@property (nonatomic,strong) UILabel  *freightCompanyLabel,*freightCompany;
@property (nonatomic,strong) UIImageView * arrowImageView;
@property (nonatomic,strong) UIView   *bottomView;

@property (nonatomic,strong) Fcgo_IndexButton *showBtn;//点击查看物流

@property (nonatomic,copy) void(^showBlock)(BOOL isShow);
@property (nonatomic,copy) void(^copyBlock)(void);

+ (instancetype)headViewWithTableView:(UITableView *)tableView;

@end
