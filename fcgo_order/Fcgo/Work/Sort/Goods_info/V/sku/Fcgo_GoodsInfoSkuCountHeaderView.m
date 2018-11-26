//
//  Fcgo_GoodsInfoSkuCountHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/27.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfoSkuCountHeaderView.h"

@interface Fcgo_GoodsInfoSkuCountHeaderView ()
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation Fcgo_GoodsInfoSkuCountHeaderView

+ (instancetype)headViewWithCollectionView:(UICollectionView *)collectionView headIdentifier:(NSString *)headIdentifier forIndexPath:(NSIndexPath *)indexPath{
    Fcgo_GoodsInfoSkuCountHeaderView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headIdentifier forIndexPath:indexPath];
    [headView setupUI];
    return headView;
}

- (void)setupUI
{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);;
        make.width.mas_offset(100);
    }];
    self.titleLabel.text = @"数量";
    [self addSubview:self.numberButton];
    self.numberButton.minValue = 1;
    self.numberButton.inputFieldFont = 13;
}

- (PPNumberButton *)numberButton
{
    if (!_numberButton) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth - kAutoWidth6(110)- 15, 10, kAutoWidth6(110), 30)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        //设置边框颜色
        numberButton.borderColor = UIFontMainGrayColor;
        numberButton.increaseTitle = @"＋";
        numberButton.decreaseTitle = @"－";
        [self addSubview:_numberButton = numberButton];
    }
    return _numberButton;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
        _titleLabel = label;
    }
    return _titleLabel;
}
@end
