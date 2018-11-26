//
//  Fcgo_TopAnimationViewTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_TopAnimationViewTableViewCell.h"

@interface Fcgo_TopAnimationViewTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;

@end

@implementation Fcgo_TopAnimationViewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}
- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.checkImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(kAutoWidth6(18));
        make.width.mas_offset(kAutoWidth6(18));
        make.centerY.mas_offset(0);
        make.right.mas_offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.checkImageView.mas_left).mas_offset(-12);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    self.bottomLineView.backgroundColor = UINavSepratorLineColor;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}


@end
