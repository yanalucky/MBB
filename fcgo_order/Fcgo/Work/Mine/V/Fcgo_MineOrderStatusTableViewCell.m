//
//  Fcgo_MineOrderStatusTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineOrderStatusTableViewCell.h"


@interface Fcgo_MineOrderStatusTableViewCell ()



@end

@implementation Fcgo_MineOrderStatusTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.waitPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.mas_offset(0);
        make.width.mas_offset(kScreenWidth/4);
    }];
    
    self.waitPayBtn.btnImageView.image = [UIImage imageNamed:@"waitPay_mine"];
    self.waitPayBtn.btnLabel.text = @"待付款";
    [self.waitPayBtn setupUI];
    
    
    [self.dealBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.waitPayBtn.mas_right).mas_offset(0);
        make.top.bottom.mas_offset(0);
        make.width.mas_offset(kScreenWidth/4);
    }];
    
    self.dealBtn.btnImageView.image = [UIImage imageNamed:@"deal_mine"];
    self.dealBtn.btnLabel.text = @"处理中";
    [self.dealBtn setupUI];
    
    [self.receivedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.dealBtn.mas_right).mas_offset(0);
        make.top.bottom.mas_offset(0);
        make.width.mas_offset(kScreenWidth/4);
    }];
    self.receivedBtn.btnImageView.image = [UIImage imageNamed:@"received_mine"];
    self.receivedBtn.btnLabel.text = @"待收货";
    [self.receivedBtn setupUI];
    
    
    [self.afterSaleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.mas_offset(0);
        make.width.mas_offset(kScreenWidth/4);
    }];
    
    self.afterSaleBtn.btnImageView.image = [UIImage imageNamed:@"afterSale_mine"];
    self.afterSaleBtn.btnLabel.text = @"售后/退款";
    [self.afterSaleBtn setupUI];
}

- (IBAction)waitPay:(Fcgo_MineContainImageViewLabelButton *)sender
{
    if (self.waitPayBlock) {
        self.waitPayBlock();
    }
}

- (IBAction)deal:(Fcgo_MineContainImageViewLabelButton *)sender
{
    if (self.dealBlock) {
        self.dealBlock();
    }
}

- (IBAction)received:(Fcgo_MineContainImageViewLabelButton *)sender
{
    if (self.receivedBlock) {
        self.receivedBlock();
    }
}

- (IBAction)afterSale:(Fcgo_MineContainImageViewLabelButton *)sender
{
    if (self.afterSaleBlock) {
        self.afterSaleBlock();
    }
}

- (void)cellMethodsBlockWithWaitPayBlock:(WaitPayBlock)waitPayBlock
                             ofDealBlock:(DealBlock)dealBlock
                         ofReceivedBlock:(ReceivedBlock)receivedBlock
                        ofAfterSaleBlock:(AfterSaleBlock)afterSaleBlock
{
    self.waitPayBlock = waitPayBlock;
    self.dealBlock = dealBlock;
    self.receivedBlock = receivedBlock;
    self.afterSaleBlock = afterSaleBlock;
}

@end
