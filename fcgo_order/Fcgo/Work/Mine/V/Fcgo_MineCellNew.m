//
//  Fcgo_MineCellNew.m
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineCellNew.h"
#import "Fcgo_MineImageTextButton.h"

@interface Fcgo_MineCellNew()
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIView    *lineView;
@property (nonatomic, strong) UIView    *contentBottomView;
@property (nonatomic, strong) UIView    *colorView;
@end

@implementation Fcgo_MineCellNew

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}

- (void)setModel:(Fcgo_MineCellModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    [_contentBottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (model.data.count) {
        UIButton *lastButton = nil;
        CGFloat width = kScreenWidth / 4.0f;
        for (NSInteger i = 0; i < model.data.count; i ++) {
            Fcgo_MineCellItemModel *obj = model.data[i];
            Fcgo_MineImageTextButton *btn = [self getButtonWithTitle:obj.title imaged:obj.image type:obj.type];
            
            
            
            
            [_contentBottomView addSubview:btn];
            
            [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastButton) {
                    if (i % 4 == 0) {
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(lastButton.mas_bottom).offset(7);
                    } else {
                        make.left.mas_equalTo(lastButton.mas_right);
                        make.top.mas_equalTo(lastButton);
                    }
                } else {
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(7);
                }
                make.width.mas_equalTo(width);
            }];
            lastButton = btn;
        }
        [_contentBottomView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(lastButton.mas_bottom).offset(12);
            make.bottom.mas_equalTo(self.colorView.mas_top).priorityLow();
        }];
    }
}

- (void)btnAction:(UIButton *)sender {
    !self.touchType ?: self.touchType(sender.tag);
}

#pragma mark - UI
- (void)setupUI {
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = UIBoldFontSize(15);
    titleLabel.textColor = UIFontBlack282828;
    [self.contentView addSubview:_titleLabel = titleLabel];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = UIBackGroundColor;
    [self.contentView addSubview:_lineView = lineView];
    
    UIView *content = [UIView new];
    [self.contentView addSubview:_contentBottomView = content];
    
    UIView *colorView = [UIView new];
    colorView.backgroundColor = UIBackGroundColor;
    [self.contentView addSubview:_colorView = colorView];
    
    // layout UI
    {
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.right.mas_offset(-12);
            make.height.mas_equalTo(kAutoWidth6(44));
            make.top.mas_equalTo(0);
        }];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(titleLabel.mas_bottom);
            make.height.mas_equalTo(1);
        }];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(lineView.mas_bottom);
        }];
        [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(12);
            make.top.mas_equalTo(content.mas_bottom).priorityLow();
        }];
    }
}

- (Fcgo_MineImageTextButton *)getButtonWithTitle:(NSString *)title
                                          imaged:(NSString *)imaged
                                            type:(kHeadTouchType)type {
    Fcgo_MineImageTextButton *btn = [Fcgo_MineImageTextButton buttonWithType:UIButtonTypeCustom];
    btn.btnLabel.text = title;
    btn.btnLabel.textColor = UIStringColor(@"#7B7B7B");
    btn.btnImageView.image = [UIImage imageNamed:imaged];
    btn.tag = type;
    btn.iconCountLabel.backgroundColor = UIFontWhiteColor;
    btn.iconCountLabel.textColor = UIFontRedColor;
    btn.iconCountLabel.layer.borderColor = UIFontRedColor.CGColor;
    btn.iconCountLabel.layer.borderWidth = 1;
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [btn setupUI];
    [btn.btnImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(kAutoWidth6(30));
        make.right.mas_offset(kAutoWidth6(-30));
        make.top.mas_offset(kAutoWidth6(8));
        make.height.mas_equalTo(btn.btnImageView.mas_width);
    }];
    
    return btn;
}

@end
