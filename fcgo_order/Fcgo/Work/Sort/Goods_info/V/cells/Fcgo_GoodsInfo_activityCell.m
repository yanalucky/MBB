//
//  Fcgo_GoodsInfo_activityCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfo_activityCell.h"

@interface Fcgo_GoodsInfo_activityCell ()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *subitLabel;
@property (weak, nonatomic) IBOutlet UILabel     *choseLabel;
@property (weak, nonatomic) IBOutlet UIImageView *enterImgView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_GoodsInfo_activityCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    self.selectionStyle  = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    self.titleLabel.textColor = UIFontMainGrayColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.centerY.mas_equalTo(weakSelf.contentView.mas_centerY).mas_offset(-2.5);
        
    }];
    
    //self.alreadyLabel.backgroundColor =kRedColor;
    [self.enterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.titleLabel.mas_centerY);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.subitLabel.font = [UIFont systemFontOfSize:12];
    self.subitLabel.textColor = UIFontRedColor;
    self.subitLabel.layer.cornerRadius = 2;
    self.subitLabel.layer.borderColor = UIFontRedColor.CGColor;
    self.subitLabel.layer.borderWidth = 0.5;
    self.subitLabel.layer.masksToBounds = YES;
    
    [self.subitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
    }];
    
    self.choseLabel.font = [UIFont systemFontOfSize:14];
    self.choseLabel.textColor = UIFontRedColor;
    
    [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.subitLabel.mas_centerY);
        make.width.mas_offset(kAutoWidth6(200));
        make.left.mas_equalTo(self.subitLabel.mas_right).mas_offset(5);
    }];
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

- (void)setActivityModel:(Fcgo_ActivityModel *)activityModel
{
    _activityModel = activityModel;
    self.titleLabel.text = @"活动:";
    
    NSArray *actArray = [activityModel.name componentsSeparatedByString:@"："];
    self.subitLabel.text = actArray[0];
    self.choseLabel.text = actArray[1];
    
    CGFloat width =  [self.subitLabel.text boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size.width;
    [self.subitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.width.mas_offset(width+10);
        make.height.mas_equalTo(self.titleLabel.mas_height);
    }];
    [self.choseLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.subitLabel.mas_centerY);
        make.width.mas_offset(kAutoWidth6(200));
        make.left.mas_equalTo(self.subitLabel.mas_right).mas_offset(5);
    }];
}
@end

