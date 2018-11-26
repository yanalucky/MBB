//
//  Fcgo_GoodsInfo_selectedCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfo_selectedCell.h"

@interface Fcgo_GoodsInfo_selectedCell ()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *choseLabel;
@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;
@property (weak, nonatomic) IBOutlet UIImageView *enterImgView;

@end

@implementation Fcgo_GoodsInfo_selectedCell

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
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    //self.alreadyLabel.backgroundColor =kRedColor;
    [self.enterImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView).mas_offset(-2.5);
        make.right.mas_offset(-15);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    self.choseLabel.font = [UIFont systemFontOfSize:15];
    self.choseLabel.textColor = UIFontSortGrayColor;
    
    [self.choseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel.mas_centerY);
        make.width.mas_offset(kAutoWidth6(280));
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(5);
    }];
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setSelectedArray:(NSArray *)selectedArray
{
    _selectedArray = selectedArray;
    NSString *titleString = selectedArray[0];
    NSString *selectedString = selectedArray[1];
    self.titleLabel.text = titleString;
    self.choseLabel.text = selectedString;
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.bottom.right.mas_offset(0);
        make.height.mas_offset(5);
    }];
}



@end

