//
//  Fcgo_OrderDetailTopTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderDetailTopTableViewCell.h"

@interface Fcgo_OrderDetailTopTableViewCell ()



@property (weak, nonatomic) IBOutlet UIImageView *orderStatusImageView;
@property (weak, nonatomic) IBOutlet UIImageView *orderStatusIconImageView;
@property (weak, nonatomic) IBOutlet UILabel     *orderStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusDescLabel;

@property (weak, nonatomic) IBOutlet UIImageView *adressImageView;
@property (weak, nonatomic) IBOutlet UILabel     *customerNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *customerTelLabel;
@property (weak, nonatomic) IBOutlet UILabel     *customerAdressLabel;
@property (weak, nonatomic) IBOutlet UIView      *botttomView;

@end

@implementation Fcgo_OrderDetailTopTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshLessTime) name:@"countdown" object:nil];
    [self setupUI];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
     ];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.orderStatusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_offset(77);
    }];
    self.orderStatusImageView.backgroundColor = UIStringColor(@"#76a6be"); //UIFontRedColor;//
    [self.orderStatusIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        //make.centerY.mas_equalTo(weakSelf.orderStatusImageView.mas_centerY);
        
        make.top.mas_offset(kAutoWidth6(12));
        make.height.width.mas_offset(21);
    }];
    
    [self.orderStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderStatusIconImageView.mas_top);
        make.left.mas_equalTo(weakSelf.orderStatusIconImageView.mas_right).mas_offset(12);
        make.centerY.mas_equalTo(weakSelf.orderStatusIconImageView.mas_centerY);
    }];
    
    self.orderStatusLabel.textColor = UIFontWhiteColor;
    self.orderStatusLabel.font = [UIFont systemFontOfSize:17];
    
    [self.orderStatusDescLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderStatusLabel.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(weakSelf.orderStatusIconImageView.mas_right).mas_offset(12);
        make.right.mas_offset(-15);
    }];
    
    self.orderStatusDescLabel.textColor = UIFontWhiteColor;
    self.orderStatusDescLabel.font = [UIFont systemFontOfSize:13];

    [self.adressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderStatusImageView.mas_bottom).mas_offset(kAutoWidth6(25));
        make.left.mas_offset(15);
        make.height.width.mas_offset(20);
    }];
    
    [self.customerNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.adressImageView.mas_centerY).mas_offset(kAutoWidth6(-5));
        make.left.mas_equalTo(weakSelf.adressImageView.mas_right).mas_offset(kAutoWidth6(15));
    }];
    
    self.customerNameLabel.textColor = UIFontMainGrayColor;
    self.customerNameLabel.font = UIFontSize(14);
    
    [self.customerTelLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.customerNameLabel.mas_centerY);
        make.right.mas_offset(-15);
    }];
    
    self.customerTelLabel.textColor = UIFontMainGrayColor;
    self.customerTelLabel.font = UIFontSize(14);
    
    [self.customerAdressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.adressImageView.mas_centerY).mas_offset(kAutoWidth6(5));
        make.left.mas_equalTo(weakSelf.adressImageView.mas_right).mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    self.customerAdressLabel.textColor = UIFontMainGrayColor;
    self.customerAdressLabel.font = UIFontSize(14);
    
    [self.botttomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
    self.botttomView.backgroundColor = UIBackGroundColor;
}

- (void)setModel:(Fcgo_OrderDetailModel *)model
{
    _model = model;
    NSString *status;
    NSString *iconString = @"ico_white-order";
    NSString *desc;
    
    switch (model.orderStatus.intValue) {
        case 1:
        {
            status = @"待付款";
            //iconString = @"wait_order";
            desc = @"";
        }
            break;
        case 2:
        {
            status = @"付款审核中";
            //iconString = @"wait_order";
             desc = @"工作人员正在审核,请耐心等待";
        }
            break;
        case 3:
        {
            status = @"已支付";
            //iconString = @"wait_order";
            desc = @"工作人员正在处理,请耐心等待";
        }
            break;
        case 10:
        {
            status = @"已受理";
            //iconString = @"wait_order";
            desc = @"工作人员审核已通过,等待发货";

        }
            break;
        case 20:
        {
            status = @"部分发货";
            //iconString = @"wait_order";
            desc = @"快递正在路上,请注意查收";

        }
            break;
        case 25:
        {
            status = @"已发货";
            //iconString = @"wait_order";
            desc = @"快递正在路上,请注意查收";
            
        }
            break;
        case 30:
        {
            status = @"清关不通过";
            //iconString = @"wait_order";
            desc = @"很抱歉,您的报关信息审核不通过,请申请退款";
            
        }
            break;
        case 40:
        {
            status = @"已签收";
            //iconString = @"finish_order";
            desc = @"商品已签收,谢谢您的惠顾";
        }
            break;
        case 100:
        {
            status = @"已完成";
            //iconString = @"finish_order";
            desc = @"订单已完成,谢谢您的惠顾";
        }
            break;
        case 50:
        {
            status = @"已取消";
            //iconString = @"cancel_order";
            desc = @"订单已取消,谢谢您的惠顾";
            
        }
            break;
        case 60:
        {
            status = @"退款完成";
            //iconString = @"cancel_order";
            desc = @"订单已完成,谢谢您的惠顾";
            
        }
            break;
        default:
            break;
    }
    
    self.orderStatusIconImageView.image = [UIImage imageNamed:iconString];
    self.orderStatusLabel.text = status;
    self.orderStatusDescLabel.text = desc;
    //self.orderNumberLabel.text = [NSString stringWithFormat:@"订单号: %@",model.orderNo];
    //self.orderTimeLabel.text = model.orderCreated;
    self.customerNameLabel.text = model.acceptConsigee;
    self.customerTelLabel.text = model.acceptConsigeephone;
    self.customerAdressLabel.text = model.acceptAddress;
}

- (void)refreshLessTime
{
    WEAKSELF(weakSelf);
    if (!self.model)
    {
        return;
    }
    if (self.model.orderStatus.intValue != 1) {
        return;
    }
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.model.time_interval];
    
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:self.model.lastTime.doubleValue/1000];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:serverDate];
    long long timeout = timeInterval;
    if( timeout <=0 ){ //倒计时结束，关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            
            /////测试
            static int  a = 0;
            if (a>1) {
                return ;
            }
            weakSelf.model = nil;
            //倒计时完成。用block回调刷新表格
            if (weakSelf.timeFinishBlock) {
                weakSelf.timeFinishBlock();
            }
            a+=1;
        });
    }else{
        int days = (int)(timeout/(3600*24));
        int hours = (int)((timeout-days*24*3600)/3600);
        int minutes = (int)(timeout-days*24*3600-hours*3600)/60;
        int seconds = (int)timeout-days*24*3600-hours*3600-minutes*60;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *hour = nil;
            NSString *mintue = nil;
            NSString *second = nil;
            
            int hour_s = hours+ (days*24);
            if (hour_s<10) {
                hour = [NSString stringWithFormat:@"0%d",hour_s];
            }else{
                hour = [NSString stringWithFormat:@"%d",hour_s];
            }
            if (minutes<10) {
                mintue = [NSString stringWithFormat:@"0%d",minutes];
            }else{
                mintue = [NSString stringWithFormat:@"%d",minutes];
            }
           if (seconds<10) {
                second = [NSString stringWithFormat:@"0%d",seconds];
            }else{
                second = [NSString stringWithFormat:@"%d",seconds];
            }
            weakSelf.orderStatusDescLabel.text = [NSString stringWithFormat:@"您的订单已提交，请在 %@时%@分%@秒 内完成支付，\n超时的订单将取消",hour,mintue,second];
        });
    }
}



@end
