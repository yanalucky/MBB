//
//  Fcgo_TimeCountDownView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_TimeCountDownView.h"

@interface Fcgo_TimeCountDownView ()

@property (strong, nonatomic) UILabel *timeLabel;
@property (strong, nonatomic) UILabel *leftHourLabel;
@property (strong, nonatomic) UILabel *leftHourColon;//小时后面的冒号
@property (strong, nonatomic) UILabel *leftMinLabel;
@property (strong, nonatomic) UILabel *leftMinColon;
@property (strong, nonatomic) UILabel *leftSedLabel;//秒
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIImageView *iconImg;
@property (strong, nonatomic) UIView      *bottomView;

@end

@implementation Fcgo_TimeCountDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontWhiteColor;
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshLessTime) name:@"countdown" object:nil];
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.mas_centerY);
        make.left.mas_offset(15);
    }];
    
    [self addSubview:self.leftHourLabel];
    [self.leftHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.timeLabel.mas_right).mas_offset(12);
        make.height.mas_offset(18);
        make.width.mas_offset(18);
    }];
    
    [self addSubview:self.leftHourColon];
    [self.leftHourColon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftHourLabel.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);;
        make.height.mas_offset(16);
        make.width.mas_offset(8);
    }];
    
    [self addSubview:self.leftMinLabel];
    [self.leftMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.leftHourColon.mas_right).mas_offset(1);
        make.height.mas_offset(18);
        make.width.mas_offset(18);
    }];
    
    [self addSubview:self.leftMinColon];
    [self.leftMinColon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftMinLabel.mas_right).mas_offset(1);
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);;
        make.height.mas_offset(17);
        make.width.mas_offset(8);
    }];
    
    [self addSubview:self.leftSedLabel];
    [self.leftSedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.leftMinColon.mas_right).mas_offset(1);
        make.height.mas_offset(18);
        make.width.mas_offset(18);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);
        make.right.mas_offset(-15);
    }];
    self.titleLabel.hidden = 1;
    
    [self addSubview:self.iconImg];
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.timeLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.titleLabel.mas_left).mas_offset(-8);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    self.iconImg.hidden = 1;
    
    [self addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(0);
        make.right.mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setType:(WholePointType)type
{
    _type = type;
    self.leftHourLabel.hidden = 0;
    self.leftHourColon.hidden = 0;
    self.leftMinLabel.hidden  = 0;
    self.leftMinColon.hidden  = 0;
    self.leftSedLabel.hidden  = 0;
    
    if (type == WholePointEndType) {
        self.timeLabel.text = @"已结束";
        //        self.leftHourLabel.hidden = 1;
        //        self.leftHourColon.hidden = 1;
        //        self.leftMinLabel.hidden  = 1;
        //        self.leftMinColon.hidden  = 1;
        //        self.leftSedLabel.hidden  = 1;
    }
    else if (type == WholePointStartType)
    {
        self.timeLabel.text = @"正在抢购";
        
    }
    else if (type == WholePointNotStartType)
    {
        self.timeLabel.text = @"距离开始";
        
    }
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontMainGrayColor;
        lab.font = UIFontSize(14);
        _timeLabel = lab;
    }
    return _timeLabel;
}

- (UILabel *)leftHourLabel
{
    if (!_leftHourLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontWhiteColor;
        lab.font = UIBoldFontSize(11);
        lab.backgroundColor = UIStringColor(@"#595959");
        lab.layer.cornerRadius = 2;
        lab.layer.masksToBounds = YES;
        lab.textAlignment = NSTextAlignmentCenter;
        _leftHourLabel = lab;
    }
    return _leftHourLabel;
}

- (UILabel *)leftHourColon
{
    if (!_leftHourColon) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontMainGrayColor;
        lab.font = UIFontSize(15);
        lab.text = @":";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = UIFontClearColor;
        _leftHourColon = lab;
    }
    return _leftHourColon;
}

- (UILabel *)leftMinLabel
{
    if (!_leftMinLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontWhiteColor;
        lab.font = UIBoldFontSize(11);
        lab.backgroundColor = UIStringColor(@"#595959");
        lab.layer.cornerRadius = 2;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.layer.masksToBounds = YES;
        _leftMinLabel = lab;
    }
    return _leftMinLabel;
}

- (UILabel *)leftMinColon
{
    if (!_leftMinColon) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontMainGrayColor;
        lab.font = UIFontSize(15);
        lab.text = @":";
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = UIFontClearColor;
        _leftMinColon = lab;
    }
    return _leftMinColon;
}

- (UILabel *)leftSedLabel
{
    if (!_leftSedLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontWhiteColor;
        lab.font = UIBoldFontSize(11);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.backgroundColor = UIStringColor(@"#595959");
        lab.layer.cornerRadius = 2;
        lab.layer.masksToBounds = YES;
        _leftSedLabel = lab;
    }
    return _leftSedLabel;
}

- (UIImageView *)iconImg
{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.image = [UIImage imageNamed:@"icon_seckill"];
    }
    return _iconImg;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textColor = UIFontRedColor;
        lab.font = UIFontSize(14);
        lab.text = @"秒杀专场";
        _titleLabel = lab;
    }
    return _titleLabel;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = UISepratorLineColor;
        _bottomView = view;
    }
    return _bottomView;
}

- (void)refreshLessTime
{
    
    WEAKSELF(weakSelf);
    if (!self.model) {
        return;
    }
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.model.time_interval];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:self.model.end.doubleValue/1000];
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:self.model.start.doubleValue/1000];
    //已过期
    NSString *status;
   if (self.type == WholePointEndType) {
        status = @"活动已结束";
        weakSelf.leftHourLabel.text = @"00";
        weakSelf.leftMinLabel.text = @"00";
        weakSelf.leftSedLabel.text = @"00";
    }
    else
    {
       NSTimeInterval timeInterval = 0.0;
        if (self.type == WholePointStartType) {
            status = @"距离结束还剩";
            timeInterval = [endDate timeIntervalSinceDate:serverDate];
           
        }
        if (self.type == WholePointNotStartType)
        {
            status = @"距离开始还剩";
            timeInterval = [startDate timeIntervalSinceDate:serverDate];
        }
        //long long timeout = timeInterval;
        long long timeout = [[NSNumber numberWithDouble:timeInterval] longLongValue];
        if(timeout<0){ //倒计时结束，关闭
            dispatch_async(dispatch_get_main_queue(), ^{
               //倒计时完成。用block回调刷新表格
                weakSelf.model = nil;
                if (weakSelf.timeFinishBlock) {
                    weakSelf.timeFinishBlock();
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
                weakSelf.leftHourLabel.text = hour;
                
                if (minutes<10) {
                    mintue = [NSString stringWithFormat:@"0%d",minutes];
                }else{
                    mintue = [NSString stringWithFormat:@"%d",minutes];
                }
                weakSelf.leftMinLabel.text = mintue;
                if (seconds<10) {
                    second = [NSString stringWithFormat:@"0%d",seconds];
                }else{
                    second = [NSString stringWithFormat:@"%d",seconds];
                }
                weakSelf.leftSedLabel.text = second;
            });
            //timeout--;
        }
    }
}

@end
