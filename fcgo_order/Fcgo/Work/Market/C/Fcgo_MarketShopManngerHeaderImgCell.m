//
//  Fcgo_MarketShopManngerHeaderImgCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MarketShopManngerHeaderImgCell.h"

#import "Fcgo_SetupHeadImageTableViewCell.h"

@interface Fcgo_MarketShopManngerHeaderImgCell()

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end

@implementation Fcgo_MarketShopManngerHeaderImgCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    
    
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_offset(-10);
        make.width.mas_offset(16*19/36);
        make.height.mas_offset(16);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.right.mas_equalTo(weakSelf.arrowImageView.mas_left).mas_offset(-8);
        make.width.mas_offset(kAutoWidth6(40));
        make.height.mas_offset(kAutoWidth6(40));
    }];
    
    self.headImageView.layer.cornerRadius  = kAutoWidth6(20);
    self.headImageView.layer.borderColor   = UIFontWhiteColor.CGColor;
    self.headImageView.layer.borderWidth   = 1;
    self.headImageView.layer.masksToBounds = YES;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_equalTo(weakSelf.headImageView.mas_left).mas_offset(-10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(15);
    
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.popoho.com/uploads/allimg/130111/1409132426-1.jpg"] placeholderImage:[UIImage imageNamed:@"icon_head-portrait"]];
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


