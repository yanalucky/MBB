//
//  Fcgo_OrderList_YB_ViewTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderList_YB_ViewTableViewCell.h"

@interface Fcgo_OrderList_YB_ViewTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView      *topLineView;
@property (weak, nonatomic) IBOutlet UILabel     *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel     *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UIButton    *orderNumCopyBtn;
@property (weak, nonatomic) IBOutlet UIView      *middleLineView;

@property (weak, nonatomic) IBOutlet UIScrollView *goodsImageScrollView;//存放不定量的图片
@property (weak, nonatomic) IBOutlet UILabel     *goodsTotalCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;


@property (weak, nonatomic) IBOutlet UIView      *middleTwoLineView;
@property (weak, nonatomic) IBOutlet UILabel     *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel     *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *freightLabel;
@property (weak, nonatomic) IBOutlet UIView      *middleThreeLineView;

@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *payBtn;      //去支付
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *cancelBtn;   //取消
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *serviceBtn;  //客服
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *remindBtn;   //提醒发货
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *againBtn;    //再次购买


@end

@implementation Fcgo_OrderList_YB_ViewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    if (@available(iOS 11.0, *)) {
        _goodsImageScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.topLineView.backgroundColor = UIBackGroundColor;
    
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.topLineView.mas_bottom).mas_offset(20);
        make.left.mas_offset(15);
    }];
    
    self.orderNumberLabel.textColor = UIFontMiddleGrayColor;
    self.orderNumberLabel.font = UIFontSize(13);
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerY.mas_equalTo(weakSelf.orderNumberLabel.mas_centerY);
        make.right.mas_offset(-15);
    }];
    
    self.orderStatusLabel.textColor = UIFontRedColor;
    self.orderStatusLabel.font = UIFontSize(13);
    
    self.orderNumCopyBtn.backgroundColor = UIFontClearColor;
    [self.orderNumCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(45);
        make.right.mas_equalTo(weakSelf.orderStatusLabel.mas_left).mas_offset(0);
    }];
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderNumberLabel.mas_centerY).mas_offset(20);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleLineView.backgroundColor = UISepratorLineColor;
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.middleLineView.mas_bottom).mas_offset(10+kAutoWidth6(35) - 8);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    [self.goodsTotalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.arrowImageView);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-10);
        
    }];
    self.goodsTotalCountLabel.textColor = UIFontMiddleGrayColor;
    self.goodsTotalCountLabel.font = UIFontSize(13);
    
    [self.goodsImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.middleLineView.mas_bottom).mas_offset(10);
        make.left.mas_offset(15);
        make.height.mas_offset(70);
        make.right.mas_equalTo(weakSelf.goodsTotalCountLabel.mas_left).mas_offset(-10);
    }];
    
    [self.middleTwoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageScrollView.mas_bottom).mas_offset(kAutoWidth6(10));
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleTwoLineView.backgroundColor = UISepratorLineColor;
    self.middleTwoLineView.hidden = YES;
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.middleTwoLineView.mas_bottom).mas_offset(20);
        make.height.mas_offset(40);
        make.left.mas_offset(15);
    }];
    self.totalLabel.textColor = UIFontMainGrayColor;
    self.totalLabel.font = UIFontSize(12);
    
    [self.orderPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.totalLabel.mas_right).mas_offset(kAutoWidth6(5));
        make.centerY.mas_equalTo(weakSelf.totalLabel);
    }];
    self.orderPriceLabel.textColor = UIFontRedColor;
    self.orderPriceLabel.font = UIFontSize(17);
    
    [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.orderPriceLabel.mas_right).mas_offset(kAutoWidth6(5));
        make.centerY.mas_equalTo(weakSelf.totalLabel);
    }];
    self.freightLabel.textColor = UIFontMiddleGrayColor;
    self.freightLabel.font = UIFontSize(12);
    
    [self.middleThreeLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.totalLabel.mas_bottom).mas_offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleThreeLineView.backgroundColor = UISepratorLineColor;
    
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
    
    self.payBtn.hidden       = 1;
    self.cancelBtn.hidden    = 1;
    self.serviceBtn.hidden   = 1;
    self.remindBtn.hidden    = 1;
    self.againBtn.hidden     = 1;
   
}

- (void)setStatusType:(OrderStatusType)statusType
{
    _statusType = statusType;
    
    self.payBtn.hidden       = 1;
    self.cancelBtn.hidden    = 1;
    self.serviceBtn.hidden   = 1;
    self.remindBtn.hidden    = 1;
    self.againBtn.hidden     = 1;

    
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
            [self.serviceBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_offset(-15);
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

- (void)setModel:(Fcgo_OrderListModel *)model
{
    _model = model;
    
    self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号: %@",model.orderNo];
    
    //设置多张图片
    [self setGoodsImageWithModel:model];
    
    self.goodsTotalCountLabel.text = [NSString stringWithFormat:@"共%lu种商品",(unsigned long)model.goodsList.count];
    
    NSString *orderPrice = [NSString stringWithFormat:@"%.2f",round([model.totalPriceYUAN floatValue]*100)/100];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"¥%@",orderPrice];
    self.freightLabel.text = [NSString stringWithFormat:@"(包含运费¥%@)",model.totalFreightYUAN];
    
    switch (model.orderStatus.intValue) {
        case 1:
        {
            self.orderStatusLabel.text = @"待付款";
            self.statusType = OrderStatusWaitPayType;
        }
            break;
        case 2:
        {
            self.orderStatusLabel.text = @"待审核";
            self.statusType = OrderStatusTestPayType;
        }
            break;
        case 3:
        {
            self.orderStatusLabel.text = @"已支付";
            self.statusType = OrderStatusDealType;
        }
            break;
        case 10:
        {
            self.orderStatusLabel.text = @"已受理";
            self.statusType = OrderStatusWaitSendType;
        }
            break;
        case 20:
        {
            self.orderStatusLabel.text = @"部分发货";
            self.statusType = OrderStatusWaitReceiveType;
        }
            break;
        case 25:
        {
            self.orderStatusLabel.text = @"已发货";
            self.statusType = OrderStatusWaitReceiveType;
        }
            break;
        case 30:
        {
            self.orderStatusLabel.text = @"清关不通过";
            self.statusType = OrderStatusCancelType;
        }
            break;
        case 40:
        {
            self.orderStatusLabel.text = @"已签收";
            self.statusType = OrderStatusSiginedType;
        }
            break;
        case 100:
        {
            self.orderStatusLabel.text = @"已完成";
            self.statusType = OrderStatusFinishType;
        }
            break;
        case 50:
        {
            self.orderStatusLabel.text = @"已取消";
            self.statusType = OrderStatusCancelType;
        }
            break;
        case 60:
        {
            self.orderStatusLabel.text = @"退款完成";
            self.statusType = OrderStatusCancelType;
        }
            break;
        default:
            break;
    }
}

- (void)setGoodsImageWithModel:(Fcgo_OrderListModel *)model
{
    // 先移除，后添加
    [[self.goodsImageScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    // NSUInteger column = 5;
    NSInteger num = 0;
    if (model.goodsList.count>3) {
        num = 3;
    }
    else
    {
        num = model.goodsList.count;
    }
    for (NSInteger i = 0; i < num; i++) {
        UIImageView *goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12+(kAutoWidth6(77)*i), 0, 70, 70)];
        Fcgo_OrderListGoodsModel *goodsModel = model.goodsList[i];
        [goodsImageView sd_setImageWithURL:[NSURL URLWithString:goodsModel.picurl]placeholderImage:[UIImage imageNamed:@"580X580"]];
        goodsImageView.userInteractionEnabled = 0;
        [self.goodsImageScrollView addSubview:goodsImageView];
    }
}

- (IBAction)pay:(UIButton *)sender
{
    if (self.payBlock) {
        self.payBlock(self.model);
    }
}

- (IBAction)cancel:(UIButton *)sender
{
    if (self.cancelBlock) {
        self.cancelBlock(self.model);
    }
}

- (IBAction)service:(UIButton *)sender
{
    if (self.serviceBlock) {
        self.serviceBlock(self.model);
    }
}

- (IBAction)remind:(UIButton *)sender
{
    if (self.remindBlock) {
        self.remindBlock(self.model);
    }
}

- (IBAction)again:(UIButton *)sender
{
    if (self.againBlock) {
        self.againBlock(self.model);
    }
}

- (IBAction)orderCopyBtnClick:(UIButton *)sender
{
    if (self.model) {
        UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
        [pasteboard setString:self.model.orderNo];
        [WSProgressHUD showImage:nil status:@"订单号已复制"];
        //[WSProgressHUD showSuccessWithStatus:@"订单号已复制"];
    }
}

@end
