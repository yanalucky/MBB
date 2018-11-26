//
//  ShopCartYBCell.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/14.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"
#import "Fcgo_CartModel.h"
#import "Fcgo_CartIndexButton.h"
#import "Fcgo_IndexButton.h"
@interface ShopCartYBCell : UITableViewCell<PPNumberButtonDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *goodStyleImg;
@property (weak, nonatomic) IBOutlet Fcgo_CartIndexButton *selectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel *goodsStatus;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsAttrs;
@property (weak, nonatomic) IBOutlet UILabel *goodsSingleAndAdvicePrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet Fcgo_CartIndexButton *deleteBtn;
@property (nonatomic,strong) PPNumberButton *numberButton;

@property (nonatomic,strong) UIControl *tapControl;

@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (nonatomic,strong) Fcgo_CartModel *model;

@property (nonatomic,copy) void(^jumpBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy) void(^selectBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy) void(^deleteBlock)(Fcgo_CartModel *model);
@property (nonatomic,copy) void(^countBlock)(Fcgo_CartModel *model);

@end