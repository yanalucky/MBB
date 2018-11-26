//
//  Fcgo_OrderLinePayRow0Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderLinePayRow0Cell.h"

@interface Fcgo_OrderLinePayRow0Cell ()

@property (weak, nonatomic) IBOutlet UILabel *orderBornLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderUpLoadLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property (weak, nonatomic) IBOutlet UIView *middleLineView;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_OrderLinePayRow0Cell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    [self.orderBornLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.right.mas_offset(0);
    }];
    self.orderBornLabel.font = [UIFont systemFontOfSize:15];
    self.orderBornLabel.textColor = UIFontMainGrayColor;
    
    
    [self.orderUpLoadLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.orderBornLabel.mas_bottom).mas_offset(10);
        
    }];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.orderUpLoadLabel.text];
    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 1)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
    
    [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(1, self.orderUpLoadLabel.text.length-1-8)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(1, self.orderUpLoadLabel.text.length-1-8)];
    
    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(self.orderUpLoadLabel.text.length-8, 8)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(self.orderUpLoadLabel.text.length-8, 8)];
    self.orderUpLoadLabel.attributedText = content;
    
    
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderUpLoadLabel.mas_bottom).mas_offset(10);
        make.left.right.mas_offset(0);
    }];
    
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:self.orderTotalLabel.text];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(4, self.orderTotalLabel.text.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4, self.orderTotalLabel.text.length-4)];
    self.orderTotalLabel.attributedText = content1;
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderTotalLabel.mas_bottom).mas_offset(20);
        make.left.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.middleLineView.backgroundColor = UIBackGroundColor;
    
    [self.payWayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.middleLineView.mas_bottom).mas_offset(0);
        make.height.mas_offset(40);
    }];
    self.payWayLabel.font = [UIFont systemFontOfSize:14];
    self.payWayLabel.textColor = UIFontMainGrayColor;
    
    
    NSMutableAttributedString *content2 = [[NSMutableAttributedString alloc]initWithString:self.payWayLabel.text];
    [content2 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 7)];
    [content2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 7)];
    [content2 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(7, self.payWayLabel.text.length-7)];
    [content2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(7, self.payWayLabel.text.length-7)];
    self.payWayLabel.attributedText = content2;
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setModel:(Fcgo_OrderPayModel *)model
{
    _model = model;double price = model.totalp.doubleValue; //model.postage.doubleValue + model.totalp.doubleValue + model.materials.doubleValue - model.coupons.doubleValue;
    //double price = model.postage.doubleValue + model.totalp.doubleValue + model.materials.doubleValue - model.coupons.doubleValue;
    NSString *priceString = [NSString stringWithFormat:@"应付金额 ¥ %.2f",price/100];
    
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:priceString];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(4, priceString.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4, priceString.length-4)];
    self.orderTotalLabel.attributedText = content1;
}

- (void)setListModel:(Fcgo_OrderListModel *)listModel
{
    _listModel = listModel;
    
    double price = listModel.totalPrice.doubleValue;
    NSString *priceString = [NSString stringWithFormat:@"应付金额 ¥ %.2f",price/100];
    
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:priceString];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(4, priceString.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4, priceString.length-4)];
    self.orderTotalLabel.attributedText = content1;
}

- (void)setOrderDetailModel:(Fcgo_OrderDetailModel *)orderDetailModel
{
    _orderDetailModel = orderDetailModel;
    
    double price = orderDetailModel.totalPrice.doubleValue;
    NSString *orderPrice = [NSString stringWithFormat:@"%.2f",round(price)/100];
    
    NSString *priceString = [NSString stringWithFormat:@"应付金额 ¥ %@",orderPrice];
    
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:priceString];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(4, priceString.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4, priceString.length-4)];
    self.orderTotalLabel.attributedText = content1;
}

@end



