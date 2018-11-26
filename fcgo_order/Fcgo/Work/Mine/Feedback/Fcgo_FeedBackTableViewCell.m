//
//  Fcgo_FeedBackTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_FeedBackTableViewCell.h"

@interface Fcgo_FeedBackTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;
@property (weak, nonatomic) IBOutlet Fcgo_IndexButton *checkBtn;

@end

@implementation Fcgo_FeedBackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.bottom.mas_offset(0);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(14);
    
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_offset(30);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-15);
    }];
}

- (IBAction)check:(Fcgo_IndexButton *)sender
{
    if (!sender.select)
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
    else
    {
        [sender setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    sender.select = !sender.select;
    
    if (self.feedBackBlock) {
        self.feedBackBlock(sender);
    }
}

- (void)setChecked:(BOOL)checked
{
    _checked = checked;
    if (checked)
    {
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"select_on"] forState:UIControlStateNormal];
    }
    else
    {
        [self.checkBtn setBackgroundImage:[UIImage imageNamed:@"select_off"] forState:UIControlStateNormal];
    }
    self.checkBtn.select = checked;
}

- (void)setTitleString:(NSString *)titleString
{
    _titleString = titleString;
    self.titleLabel.text = titleString;
}


@end
