//
//  Fcgo_AddressSelectedCell.m
//  Fcgo
//
//  Created by by_r on 2017/10/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddressSelectedCell.h"

@interface Fcgo_AddressSelectedCell()
@property (nonatomic, strong) UIView    *topContentView;
@property (nonatomic, strong) UILabel   *nameLabel;
@property (nonatomic, strong) UILabel   *phoneLabel;
@property (nonatomic, strong) UILabel   *defaultLabel;
@property (nonatomic, strong) UILabel   *addressLabel;
@property (nonatomic, strong) UIImageView   *selectedImageView;

@property (nonatomic, strong) UIView    *bottomContentView;
@property (nonatomic, strong) UIView    *firstLine;
@property (nonatomic, strong) UIView    *secondLine;
@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UIButton  *arrowButton;
@property (nonatomic, strong) UIView    *goodsContentView;
@end

@implementation Fcgo_AddressSelectedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}

- (void)setModel:(Fcgo_AddressModel *)model {
    _model = model;
    
    _nameLabel.text = model.consigee;
    _phoneLabel.text = model.consigeePhone;
    _addressLabel.text = [NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail];;
    
    _defaultLabel.hidden = !model.deFault.integerValue;
    if (model.haveData) {
        _selectedImageView.hidden = YES;
        if (model.isOpen) {
            [_goodsContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            UIButton *lastButton = nil;
            CGFloat width = 60.f;
            CGFloat margin = (kScreenWidth - 20 - width * 5) / 4.f;
            for (NSInteger i = 0; i < 7; i ++) {
//                int row = i / 5; // 行号
//                int loc = i % 5; // 列号
//                CGFloat x = loc*(margin + width);
//                CGFloat y = margin + row*(margin + width);
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor = [UIColor redColor];
                [_goodsContentView addSubview:btn];
                if (lastButton) {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        if (i % 5 == 0) {
                            make.left.mas_equalTo(0);
                            make.top.mas_equalTo(lastButton.mas_bottom).offset(12);
                        } else {
                            make.left.mas_equalTo(lastButton.mas_right).offset(margin);
                            make.top.mas_equalTo(lastButton);
                        }
                        make.size.mas_equalTo(CGSizeMake(width, width));
                    }];
                } else {
                    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(12);
                        make.size.mas_equalTo(CGSizeMake(width, width));
                    }];
                }
                lastButton = btn;
            }
            [_goodsContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_secondLine);
                make.right.mas_equalTo(_arrowButton);
                make.top.mas_equalTo(_secondLine.mas_bottom);
                make.bottom.mas_equalTo(lastButton.mas_bottom).offset(12);
            }];
            
            [self.arrowButton setImage:[UIImage imageNamed:@"dj_sort_arrow_up"] forState:UIControlStateNormal];
            _secondLine.hidden = NO;
        } else {
            _secondLine.hidden = YES;
            [self.arrowButton setImage:[UIImage imageNamed:@"dj_sort_arrow_down"] forState:UIControlStateNormal];
            [_goodsContentView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(_secondLine);
                make.right.mas_equalTo(_arrowButton);
                make.top.mas_equalTo(_secondLine.mas_bottom);
            }];
        }
        [_addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-10).priorityHigh();
        }];
    } else {
        _selectedImageView.hidden = !model.selected;
        [_bottomContentView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        [_addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(_selectedImageView.mas_left).offset(-10);
        }];
    }
}

- (void)arrowButtonAction {
    if (self.open) {
        self.open(self.model);
    }
}

#pragma mark - UI
- (void)setupUI {
    _topContentView = [UIView new];
    [self.contentView addSubview:_topContentView];
    
    _nameLabel = [self createLabelWithFontSize:15];
    [_topContentView addSubview:_nameLabel];
    
    _phoneLabel = [self createLabelWithFontSize:15];
    [_topContentView addSubview:_phoneLabel];
    
    _defaultLabel = [self createLabelWithFontSize:15];
    //_defaultLabel.backgroundColor = UIRGBColor(246, 51, 120, 1);
    //_defaultLabel.textColor = [UIColor whiteColor];
    _defaultLabel.textAlignment = NSTextAlignmentCenter;
    _defaultLabel.text = @"默认";
    //_defaultLabel.layer.cornerRadius = 6;
   // _defaultLabel.layer.masksToBounds = YES;
    
    _defaultLabel.textColor = UIFontWhiteColor;
    _defaultLabel.backgroundColor = UIFontRedColor;
    _defaultLabel.font = UIFontSize(11);
    _defaultLabel.layer.cornerRadius = 3;
    _defaultLabel.layer.masksToBounds = 1;
    [_topContentView addSubview:_defaultLabel];
    
    _addressLabel = [self createLabelWithFontSize:15];
    _addressLabel.textColor = UIRGBColor(123, 123, 123, 1);
    _addressLabel.numberOfLines = 0;
    [_topContentView addSubview:_addressLabel];
    
    _selectedImageView = [UIImageView new];
    _selectedImageView.image = [UIImage imageNamed:@"select_on"];
    [_topContentView addSubview:_selectedImageView];
    
    [_topContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_addressLabel.mas_bottom).offset(12);
    }];
    
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(12);
        make.width.mas_lessThanOrEqualTo(110);
    }];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_nameLabel.mas_right).offset(10);
        make.top.mas_equalTo(13);
        make.width.mas_lessThanOrEqualTo(110);
    }];
    [_defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_phoneLabel.mas_right).offset(10);
        make.centerY.mas_equalTo(_phoneLabel);
        make.width.mas_offset(50);
        make.height.mas_offset(18);
    }];
    
    
    
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel);
        make.top.mas_equalTo(_nameLabel.mas_bottom).offset(12);
        make.right.mas_equalTo(_selectedImageView.mas_left).offset(-10);
    }];
    [_selectedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_topContentView);
        make.right.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    
    _bottomContentView = [UIView new];
    _bottomContentView.clipsToBounds = YES;
    [self.contentView addSubview:_bottomContentView];
    
    _firstLine = [UIView new];
    _firstLine.backgroundColor = UIRGBColor(234, 234, 234, 1);
    [_bottomContentView addSubview:_firstLine];
    
    _tipLabel = [self createLabelWithFontSize:15];
    _tipLabel.textColor = _addressLabel.textColor;
    _tipLabel.text = @"当前城市无法购买部分商品";
    [_bottomContentView addSubview:_tipLabel];
    
    _arrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_arrowButton addTarget:self action:@selector(arrowButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_arrowButton setImage:[UIImage imageNamed:@"down_icon_arrow"] forState:UIControlStateNormal];
    [_bottomContentView addSubview:_arrowButton];
    
    _secondLine = [UIView new];
    _secondLine.backgroundColor = _firstLine.backgroundColor;
    [_bottomContentView addSubview:_secondLine];
    
    _goodsContentView = [UIView new];
    _goodsContentView.clipsToBounds = YES;
    [_bottomContentView addSubview:_goodsContentView];
    
    [_bottomContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(_topContentView.mas_bottom);
        make.bottom.mas_equalTo(_goodsContentView.mas_bottom).priorityLow();
    }];
    [_firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_addressLabel);
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(_arrowButton.mas_left).priorityLow();
    }];
    [_arrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10).priorityHigh();
        make.centerY.mas_equalTo(_tipLabel);
    }];
    [_secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipLabel);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(_tipLabel.mas_bottom).offset(12);
        make.height.equalTo(_firstLine);
    }];
    [_goodsContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_tipLabel);
        make.right.mas_equalTo(_arrowButton);
        make.top.mas_equalTo(_secondLine.mas_bottom);
    }];
}

- (UILabel *)createLabelWithFontSize:(CGFloat)size {
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:size];
    return label;
}

@end
