//
//  Fcgo_SheetAnimationViewTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SheetAnimationViewTableViewCell.h"

@interface Fcgo_SheetAnimationViewTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@end


@implementation Fcgo_SheetAnimationViewTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}
- (void)setupUI
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(18);
    
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
    
    if (![titleString isEqualToString:@"取消"]) {
        self.titleLabel.textColor = UIFontRedColor;
    }else{
        self.titleLabel.textColor = UIFontMainGrayColor;
    }
    
    self.titleLabel.text = titleString;
    
    
}


@end
