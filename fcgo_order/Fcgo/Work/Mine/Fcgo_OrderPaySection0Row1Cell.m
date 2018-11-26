//
//  Fcgo_OrderPaySection0Row1Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_OrderPaySection0Row1Cell.h"

@interface Fcgo_OrderPaySection0Row1Cell ()

@property (weak, nonatomic) IBOutlet UILabel *orderBornLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTimelabel;
@property (weak, nonatomic) IBOutlet UILabel *orderTotalLabel;
@property (weak, nonatomic) IBOutlet UIView *middleLineView;
@property (weak, nonatomic) IBOutlet UILabel *payWayLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation Fcgo_OrderPaySection0Row1Cell

- (void)dealloc {
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI {
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    [self.orderBornLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.left.right.mas_offset(0);
    }];
    self.orderBornLabel.font = [UIFont systemFontOfSize:15];
    self.orderBornLabel.textColor = UIFontMainGrayColor;
    
    
    [self.orderTimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.orderBornLabel.mas_bottom).mas_offset(10);
        
    }];
    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:self.orderTimelabel.text];
    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 2)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 2)];
    
    [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(2, self.orderTimelabel.text.length-2-5)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(2, self.orderTimelabel.text.length-2-5)];
    
    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(self.orderTimelabel.text.length-5, 5)];
    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(self.orderTimelabel.text.length-5, 5)];
    self.orderTimelabel.attributedText = content;
    
    
    [self.orderTotalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderTimelabel.mas_bottom).mas_offset(10);
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
    
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setModel:(Fcgo_OrderPayModel *)model {
    WEAKSELF(weakSelf);
    _model = model;
    double price = model.totalp.doubleValue; //model.postage.doubleValue + model.totalp.doubleValue + model.materials.doubleValue - model.coupons.doubleValue;
    
    NSString *orderPrice = [NSString stringWithFormat:@"%.2f",round(price)/100];
    NSString *priceString = [NSString stringWithFormat:@"应付金额 ¥ %@",orderPrice];
    NSMutableAttributedString *content1 = [[NSMutableAttributedString alloc]initWithString:priceString];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 4)];
    [content1 addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(4, priceString.length-4)];
    [content1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(4, priceString.length-4)];
    self.orderTotalLabel.attributedText = content1;
    
    NSDate* serverDate = [NSDate dateWithTimeIntervalSince1970:model.now.doubleValue/1000];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:model.end.doubleValue/1000];
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:serverDate];
    __block long long timeout = timeInterval;
    
    if (timeout!=0) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        dispatch_source_set_event_handler(_timer, ^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(weakSelf.timer);
                    weakSelf.timer = nil;
                    //倒计时完成。用block回调刷新表格
                    if (weakSelf.timeFinishBlock) {
                         weakSelf.timeFinishBlock();
                    }
                }else{
                    long days = (long long)(timeout/(3600*24));
                    long hours = (long long)((timeout-days*24*3600)/3600);
                    long minutes = (long long)(timeout-days*24*3600-hours*3600)/60;
                    long seconds = (long long)timeout-days*24*3600-hours*3600-minutes*60;
                    
                    NSString *hour = nil;
                    NSString *mintue = nil;
                    NSString *second = nil;
                
                    long hour_s = hours+ (days*24);
                    if (hour_s<10) {
                        hour = [NSString stringWithFormat:@"0%ld",hour_s];
                    }else{
                        hour = [NSString stringWithFormat:@"%ld",hour_s];
                    }
                    if (minutes<10) {
                        mintue = [NSString stringWithFormat:@"0%ld",minutes];
                    }else{
                        mintue = [NSString stringWithFormat:@"%ld",minutes];
                    }
                    if (seconds<10) {
                        second = [NSString stringWithFormat:@"0%ld",seconds];
                    }else{
                        second = [NSString stringWithFormat:@"%ld",seconds];
                    }
                
                    NSString *timeString = [NSString stringWithFormat:@"请在 %@时%@分%@秒 内完成支付",hour,mintue,second];
                    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:timeString];
                    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(0, 2)];
                    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, 2)];
                
                    [content addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:NSMakeRange(2, timeString.length-2-5)];
                    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(2, timeString.length-2-5)];
                    [content addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:NSMakeRange(timeString.length-5, 5)];
                    [content addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(timeString.length-5, 5)];
                    weakSelf.orderTimelabel.attributedText = content;
                    
                    timeout--;
                }
            });
        });
        dispatch_resume(_timer);
    }
}


@end
