//
//  Fcgo_GoodsInfoHeaderTimeView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoHeaderTimeView.h"
@interface Fcgo_GoodsInfoHeaderTimeView ()

@property (nonatomic,strong) UILabel *timeStatusLabel,*timeLabel;

@end
@implementation Fcgo_GoodsInfoHeaderTimeView

+ (instancetype)headViewWithTableView:(UITableView *)tableView headIdentifier:(NSString *)headIdentifier
{
    Fcgo_GoodsInfoHeaderTimeView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headIdentifier];
    [headView setupUI];
    return headView;
}

- (void)setupUI
{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshTime) name:@"countdown" object:nil];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth*148/1242)];
    bgImageView.image = [UIImage imageWithName:@"integral_goodsdetail" ofType:@"png"];
    
    UILabel *integralLabel = [[UILabel alloc]init];
    integralLabel.textColor = UIFontWhiteColor;
    integralLabel.font = UIBoldFontSize(18);
    integralLabel.textAlignment = NSTextAlignmentLeft;
    integralLabel.text = @"整点抢";
    [bgImageView addSubview:integralLabel];
    [self.contentView addSubview:bgImageView];
    [integralLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.left.mas_offset(15);
    }];
    
    [bgImageView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.right.mas_offset(-15);
    }];
    [bgImageView addSubview:self.timeStatusLabel];
    [self.timeStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgImageView.mas_centerY);
        make.right.mas_offset(-100);
    }];
}


- (UILabel *)timeStatusLabel
{
    if (!_timeStatusLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontWhiteColor;
        label.font = [UIFont systemFontOfSize:13];
        label.textAlignment = NSTextAlignmentRight;
        _timeStatusLabel = label;
    }
    return _timeStatusLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontWhiteColor;
        label.font = [UIFont boldSystemFontOfSize:18];
        label.textAlignment = NSTextAlignmentRight;
        _timeLabel = label;
    }
    return _timeLabel;
}

- (void)refreshTime
{
    //已过期
    if (!self.infoModel) {
        return;
    }
    if (!self.infoModel.activityModel.end) {
        return;
    }
    if (self.infoModel.activityModel.status.integerValue == 2) {
        return;
    }
    
    WEAKSELF(weakSelf);
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.infoModel.activityModel.time_interval];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:self.infoModel.activityModel.end.doubleValue/1000];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.infoModel.activityModel.start.doubleValue/1000];
    
    NSString *status;
    NSTimeInterval timeInterval = 0.0;
    if (self.infoModel.activityModel.status.intValue == 1) {
        status = @"距离结束还剩";
        timeInterval = [endDate timeIntervalSinceDate:serverDate];
    }
    if (self.infoModel.activityModel.status.intValue == 0)
    {
        status = @"距离开始还剩";
        timeInterval = [startDate timeIntervalSinceDate:serverDate];
    }
    
    long long timeout = timeInterval;
    if(timeout<=0){ //倒计时结束，关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            //倒计时完成。用block回调刷新表格
            if (self.reloadBlock) {
                self.reloadBlock();
            }
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
            weakSelf.timeStatusLabel.text = status;
            weakSelf.timeLabel.text = [NSString stringWithFormat:@"%@:%@:%@",hour,mintue,second];
        });
    }
}


@end
