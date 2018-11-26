//
//  Fcgo_EmployeeCell.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_EmployeeCell.h"

@interface Fcgo_EmployeeCell ()
@property (nonatomic, strong) UIImageView   *headerImageView;
@property (nonatomic, strong) UILabel      *nameLabel;
@property (nonatomic, strong) UILabel      *detailLabel;
@property (nonatomic, strong) UIImageView   *arrowImageView;
@end

@implementation Fcgo_EmployeeCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
        self.nameLabel.text = @"张二狗";
        self.detailLabel.text = @"紫东创意园店-店长";
        self.headerImageView.backgroundColor = UIFontRedColor;
    }
    return self;
}

#pragma mark - UI
- (void)setupUI {
    CGFloat margin = 10.f;
    CGFloat width = 60.f;
    // header
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.layer.cornerRadius = width / 2.0;
    headerImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:headerImageView];
    _headerImageView = headerImageView;
    // name
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.textColor = UIFontBlackColor;
    nameLabel.font = UIFontSize(15);
    [self.contentView addSubview:nameLabel];
    _nameLabel = nameLabel;
    // detail
    UILabel *detailLabel = [[UILabel alloc] init];
    detailLabel.textColor = UIFontMiddleGrayColor;
    detailLabel.font = UIFontSize(14);
    detailLabel.numberOfLines = 2;
    [self.contentView addSubview:detailLabel];
    _detailLabel = detailLabel;
    // arrow
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    [self.contentView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    
    // layout
    {
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_offset(margin);
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.bottom.mas_offset(-margin).priorityHigh();
        }];
        [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(headerImageView.mas_right).offset(margin);
            make.top.equalTo(headerImageView);
            make.right.mas_equalTo(arrowImageView.mas_left).offset(-margin);
            make.height.equalTo(headerImageView).multipliedBy(0.3);
        }];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(nameLabel);
            make.top.mas_equalTo(nameLabel.mas_bottom);
            make.height.equalTo(headerImageView).multipliedBy(0.7);
        }];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(9.5, 18));
            make.right.mas_offset(-margin);
        }];
    }
}

@end
