//
//  Fcgo_OrderDetailBottomTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailBottomTableViewCell.h"

@interface Fcgo_OrderDetailBottomTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation Fcgo_OrderDetailBottomTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(13);
    
    [self.descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_offset(-15);
    }];
    self.descriptionLabel.textColor = UIFontMainGrayColor;
    self.descriptionLabel.font = UIFontSize(13);
}

- (void)setupWithModel:(Fcgo_OrderDetailModel *)model Index:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            self.titleLabel.text = @"订  单  号:";
            self.descriptionLabel.text = model.orderNo;
            self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;
        case 1:
        {
            self.titleLabel.text = @"下单时间:";
            self.descriptionLabel.text = model.createTime;
            self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;
        case 2:
        {
            self.titleLabel.text = @"支付方式:";
            self.descriptionLabel.text = model.payType;
             self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;
        case 3:
        {
            self.titleLabel.text = @"商品合计:";
            self.descriptionLabel.text = [NSString stringWithFormat:@"¥ %.2f",round([model.totalPriceYUAN floatValue]*100)/100-round([model.totalFreightYUAN floatValue]*100)/100+ round([model.totalCouponYUAN floatValue]*100)/100+round([model.totalActivityYUAN floatValue]*100)/100];
             self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;

        case 4:
        {
            self.titleLabel.text = @"运       费:";
            self.descriptionLabel.text = [NSString stringWithFormat:@"¥ %@",model.totalFreightYUAN];
             self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;

        case 5:
        {
            self.titleLabel.text = @"活动优惠:";
            self.descriptionLabel.text =[NSString stringWithFormat:@"-¥%.2f",round([model.totalCouponYUAN floatValue]*100)/100+round([model.totalActivityYUAN floatValue]*100)/100];
             self.descriptionLabel.textColor = UIFontMiddleGrayColor;
        }
            break;
        case 6:
        {
            double realPay = model.totalPriceYUAN.doubleValue;//(round([model.totalPrice floatValue]*100)/100 - model.totalActivity.floatValue) / 100 - model.totalCoupon.floatValue;// + model.totalFreight.floatValue - model.totalCoupon.floatValue - model.totalActivity.floatValue;
            self.titleLabel.text = @"实际支付:";
            NSString *orderPrice = [NSString stringWithFormat:@"%.2f",realPay];
            
            self.descriptionLabel.text = [NSString stringWithFormat:@"¥ %@",orderPrice];
             self.descriptionLabel.textColor = UIFontRedColor;
            
        }
            break;
        default:
            break;
    }
    
}



@end
