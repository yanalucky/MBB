//
//  Fcgo_SetupHeadImageTableViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SetupHeadImageTableViewCell.h"

@interface Fcgo_SetupHeadImageTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@end

@implementation Fcgo_SetupHeadImageTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(kAutoWidth6(40));
        make.height.mas_offset(kAutoWidth6(40));
    }];
    
    self.headImageView.layer.cornerRadius  = kAutoWidth6(20);
    self.headImageView.layer.borderColor   = UINavSepratorLineColor.CGColor;
    self.headImageView.layer.borderWidth   = 0.5;
    self.headImageView.layer.masksToBounds = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.headImageView.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    
    NSString *string = [Fcgo_UserTools shared].userHeaderImageUrl;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:string] placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
    //self.headImageView.image = [UIImage imageWithName:@"headImage" ofType:@"png"];
}
 
- (void)setTitleString:(NSString *)titleString
{
    self.titleLabel.text = titleString;
}

- (void)setHeadImageString:(NSString *)headImageString
{
    if (headImageString) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:headImageString] placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
    }
    else{
       self.headImageView.image = [UIImage imageNamed:@"icon_head-portrait"];
    }
    
}

@end
