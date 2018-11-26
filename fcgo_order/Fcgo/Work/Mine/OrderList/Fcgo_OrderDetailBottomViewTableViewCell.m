//
//  Fcgo_OrderDetailBottomViewTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailBottomViewTableViewCell.h"

@interface Fcgo_OrderDetailBottomViewTableViewCell ()

@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *payBtn;      //去支付
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *cancelBtn;   //取消
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *serviceBtn;  //客服
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *remindBtn;   //提醒发货
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *againBtn;    //再次购买

@property (weak, nonatomic) IBOutlet UIButton    *signBtn;

@end

@implementation Fcgo_OrderDetailBottomViewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    self.contentView.backgroundColor = UIBackGroundColor;
    self.payBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.payBtn.layer.borderWidth   = 0.5;
    self.payBtn.layer.cornerRadius  = 3;
    self.payBtn.layer.masksToBounds = 1;
    [self.payBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [self.payBtn setBackgroundColor:UIFontWhiteColor];
    
    self.cancelBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.cancelBtn.layer.borderWidth   = 0.5;
    self.cancelBtn.layer.cornerRadius  = 3;
    self.cancelBtn.layer.masksToBounds = 1;
    [self.cancelBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.cancelBtn setBackgroundColor:UIFontWhiteColor];
    
    self.serviceBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.serviceBtn.layer.borderWidth   = 0.5;
    self.serviceBtn.layer.cornerRadius  = 3;
    self.serviceBtn.layer.masksToBounds = 1;
    [self.serviceBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.serviceBtn setBackgroundColor:UIFontWhiteColor];
    
    self.remindBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.remindBtn.layer.borderWidth   = 0.5;
    self.remindBtn.layer.cornerRadius  = 3;
    self.remindBtn.layer.masksToBounds = 1;
    [self.remindBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.remindBtn setBackgroundColor:UIFontWhiteColor];
    
    self.againBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.againBtn.layer.borderWidth   = 0.5;
    self.againBtn.layer.cornerRadius  = 3;
    self.againBtn.layer.masksToBounds = 1;
    [self.againBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [self.againBtn setBackgroundColor:UIFontWhiteColor];
    
    self.signBtn.layer.borderColor   = UIFontMainGrayColor.CGColor;
    self.signBtn.layer.borderWidth   = 0.5;
    self.signBtn.layer.cornerRadius  = 3;
    self.signBtn.layer.masksToBounds = 1;
    [self.signBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [self.signBtn setBackgroundColor:UIFontWhiteColor];
    
    self.payBtn.hidden       = 1;
    self.cancelBtn.hidden    = 1;
    self.serviceBtn.hidden   = 1;
    self.remindBtn.hidden    = 1;
    self.againBtn.hidden     = 1;
    self.signBtn.hidden     = 1;
    
}

- (void)setStatusType:(OrderStatusType)statusType
{
    _statusType = statusType;
    
    self.payBtn.hidden       = 1;
    self.cancelBtn.hidden    = 1;
    self.serviceBtn.hidden   = 1;
    self.remindBtn.hidden    = 1;
    self.againBtn.hidden     = 1;
    self.signBtn.hidden      = 1;
    
    WEAKSELF(weakSelf)
    switch (statusType) {
        case OrderStatusWaitPayType:
        {
            [self.payBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.payBtn.hidden =  0;
            
            [self.cancelBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.payBtn.mas_left).mas_offset(-10);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.cancelBtn.hidden = 0;
            
        }
            break;
        case OrderStatusTestPayType:
        {
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.serviceBtn.hidden = 0;
        }
            break;
            
        case OrderStatusDealType:
        {
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.serviceBtn.hidden =  0;
        }
            break;
        case OrderStatusWaitSendType:
        {
            [self.remindBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.remindBtn.hidden =  0;
            
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.remindBtn.mas_left).mas_offset(-10);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.serviceBtn.hidden = 0;
            
        }
            break;
        case OrderStatusWaitReceiveType:
        {
            [self.signBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.signBtn.hidden =  0;
            
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.signBtn.mas_left).mas_offset(-10);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.serviceBtn.hidden = 0;
        }
            break;
        case OrderStatusSiginedType:
        {
            [self.againBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.againBtn.hidden =  0;
            
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(weakSelf.againBtn.mas_left).mas_offset(-10);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.serviceBtn.hidden = 0;
        }
            break;
        case OrderStatusFinishType:
        {
            [self.againBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.againBtn.hidden =  0;
        }
            break;
        case OrderStatusCancelType:
        {
            [self.againBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
                make.height.mas_offset(25);
                make.width.mas_offset(70);
                make.bottom.mas_offset(-10);
            }];
            self.againBtn.hidden =  0;
        }
            break;
        default:
            break;
    }
}

- (void)setOrderType:(NSInteger)orderType
{
    _orderType = orderType;
    switch (orderType) {
        case 1:
        {
           self.statusType = OrderStatusWaitPayType;
        }
            break;
        case 2:
        {
            self.statusType = OrderStatusTestPayType;
        }
            break;
        case 3:
        {
           self.statusType = OrderStatusDealType;
        }
            break;
        case 10:
        {
            self.statusType = OrderStatusWaitSendType;
        }
            break;
        case 20:
        {
            //部分发货
            self.statusType = OrderStatusWaitReceiveType;
        }
            break;
        case 25:
        {
            self.statusType = OrderStatusWaitReceiveType;
        }
            break;
        case 30:
        {
            self.statusType = OrderStatusCancelType;
        }
            break;
            
        case 40:
        {
            self.statusType = OrderStatusSiginedType;
        }
            break;
        case 100:
        {
            self.statusType = OrderStatusFinishType;
        }
            break;
        case 50:
        {
            self.statusType = OrderStatusCancelType;
        }
            break;
        case 60:
        {
            self.statusType = OrderStatusCancelType;
        }
            break;
        default:
            break;
    }

}

- (IBAction)pay:(UIButton *)sender
{
    if (self.payBlock) {
        self.payBlock();
    }
}
- (IBAction)cancel:(UIButton *)sender
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}
- (IBAction)service:(UIButton *)sender
{
    if (self.serviceBlock) {
        self.serviceBlock();
    }
}
- (IBAction)remind:(UIButton *)sender
{
    if (self.remindBlock) {
        self.remindBlock();
    }
}

- (IBAction)again:(UIButton *)sender
{
    if (self.againBlock) {
        self.againBlock();
    }
}

- (IBAction)sign:(UIButton *)sender
{
    if (self.orderType == 20) {
        WEAKSELF(weakSelf);
        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"签收操作是对订单所有商品进行签收,你还有部分商品未发货,确认签收?" cancelTitle:@"再等等" confirmTitle:@"确定" block:^{
            [weakSelf siginOrder];
        }];
    }
    else{
        [self siginOrder];
    }
    
    
    
}

- (void)siginOrder
{
    if (self.signBlock) {
        self.signBlock();
    }
}

@end
