//
//  Fcgo_EmployeeDetailCell.m
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_EmployeeDetailCell.h"

@interface Fcgo_EmployeeDetailCell ()
@property (nonatomic, strong) UIImageView   *headerImageView;
@end

@implementation Fcgo_EmployeeDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

#pragma mark - private method
- (void)tapHeaderAction {
    !self.touchHeader ?: self.touchHeader();
}

#pragma mark - UI
- (void)setupUI {
    CGFloat margin = 10.f;
    // label
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = UIFontSize(15);
    tipLabel.text = @"员工照片";
    [self.contentView addSubview:tipLabel];
    CGFloat width = 80.f;
    // header
    UIImageView *headerImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_head-portrait"]];
    headerImageView.contentMode = UIViewContentModeScaleAspectFill;
    headerImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:headerImageView];
    _headerImageView = headerImageView;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHeaderAction)];
    [headerImageView addGestureRecognizer:tap];
    // layout
    {
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(margin);
            make.centerY.equalTo(self.contentView);
        }];
        [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(margin);
            make.right.mas_offset(-margin);
            make.size.mas_equalTo(CGSizeMake(width, width));
            make.bottom.mas_offset(-margin).priorityLow();
        }];
    }
}
@end

@interface Fcgo_EmployeeTxtInfoCell ()
@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UITextField   *detailTextField;
@property (nonatomic, strong) UIImageView   *arrowImageView;
@end

@implementation Fcgo_EmployeeTxtInfoCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

#pragma mark - public method
- (void)setDetailColor:(UIColor *)color tip:(NSString *)tip detail:(NSString *)detail edited:(BOOL)edited placeholder:(NSString *)placeholder arrow:(BOOL)hidden {
    _detailTextField.textColor = color ?: UIFontBlackColor;
    _tipLabel.text = tip;
    _detailTextField.text = detail.length ? detail : placeholder;//detail;
    _detailTextField.userInteractionEnabled = edited;
    _arrowImageView.hidden = hidden;
}

#pragma mark - UI
- (void)setupUI {
    CGFloat margin = 10.f;
    // label
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = UIFontSize(15);
    [self.contentView addSubview:tipLabel];
    _tipLabel = tipLabel;
    // detail
    UITextField *detailTextField = [[UITextField alloc] init];
    detailTextField.font = UIFontSize(15);
    detailTextField.textAlignment = NSTextAlignmentRight;
    detailTextField.userInteractionEnabled = NO;
    [self.contentView addSubview:detailTextField];
    _detailTextField = detailTextField;
    // arrow
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    [self.contentView addSubview:arrowImageView];
    _arrowImageView = arrowImageView;
    // layout
    {
        [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(margin);
            make.centerY.mas_equalTo(self.contentView);
        }];
        [detailTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(tipLabel.mas_right).offset(margin);
            make.centerY.equalTo(tipLabel);
            make.right.mas_equalTo(arrowImageView.mas_left).offset(-margin);
        }];
        [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-margin);
            make.centerY.equalTo(tipLabel);
            make.size.mas_equalTo(CGSizeMake(9.5, 18));
        }];
    }
}
@end
