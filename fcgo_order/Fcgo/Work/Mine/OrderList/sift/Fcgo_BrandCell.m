//
//  Fcgo_BrandCell.m
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_BrandCell.h"
#import "Fcgo_SiftModel.h"

@interface Fcgo_BrandCell ()
@property (nonatomic, strong) Fcgo_SiftModel *model;
@property (nonatomic, strong) NSIndexPath   *indexPath;
@property (nonatomic, strong) UILabel       *titleLabel;
@property (nonatomic, strong) UIView        *bottomView;
@end

@implementation Fcgo_BrandCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
    }
    return self;
}

#pragma mark -
- (void)buttonAction:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selected:indexPath:)]) {
        Fcgo_SiftSelectModel *obj = self.model.list[sender.tag];
        [self.delegate selected:obj indexPath:self.indexPath];
    }
}

- (void)setModel:(Fcgo_SiftModel *)model indexPath:(NSIndexPath *)indexPath width:(CGFloat)width {
    _model = model;
    _indexPath = indexPath;
    CGFloat margin = 15.f;
    CGFloat selectWidth = (width - margin * 4) / 3;
    CGFloat selectHeight = 25.f;
    _titleLabel.text = model.title;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(margin);
        make.right.mas_equalTo(-margin);
        make.height.mas_equalTo(25);
    }];
    [_bottomView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.top.mas_equalTo(_titleLabel.mas_bottom);
        make.right.mas_equalTo(-margin);
        make.bottom.mas_equalTo(-margin);
    }];
    if (model.list) {
        UIButton *lastButton = nil;
        for (NSInteger i = 0; i < model.list.count; i ++) {
            Fcgo_SiftSelectModel *obj = model.list[i];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:obj.title forState:UIControlStateNormal];
            button.layer.cornerRadius = 4;
            button.layer.masksToBounds = YES;
            button.layer.borderColor = UIFontRedColor.CGColor;
            button.layer.borderWidth = 1;
            button.titleLabel.font = UIFontSize(13);//UIFontSacleSize(12);
            [button setTitleColor:UIFontSortGrayColor forState:UIControlStateNormal];
            [button setTitleColor:UIFontWhiteColor forState:UIControlStateSelected];
            button.selected = obj.selected;
            if (obj.selected) {
                button.backgroundColor = UIFontRedColor;
            }
            else {
                button.backgroundColor = UIFontWhiteColor;
                button.layer.borderColor = UIFontMiddleGrayColor.CGColor;
            }
            button.tag = i;
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.bottomView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                if (lastButton) {
                    if (i % 3 == 0) {
                        make.left.mas_equalTo(0);
                        make.top.mas_equalTo(lastButton.mas_bottom).offset(margin);
                    }
                    else {
                        make.left.mas_equalTo(lastButton.mas_right).offset(margin);
                        make.top.mas_equalTo(lastButton);
                    }
                }
                else {
                    make.left.mas_equalTo(0);
                    make.top.mas_equalTo(margin);
                }
                make.size.mas_equalTo(CGSizeMake(selectWidth, selectHeight));
            }];
            lastButton = button;
        }
        [lastButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(-margin).priorityLow();
        }];
    }
}

#pragma mark - UI
- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = UIFontSize(15);
    [self.contentView addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    UIView *bottomView = [[UIView alloc] init];
    [self.contentView addSubview:bottomView];
    _bottomView = bottomView;
}

@end
