//
//  Fcgo_BackDetailCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BackDetailCell.h"

@implementation Fcgo_BackDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self remakeCell];
    }
    return self;
}
-(void)remakeCell{
    _titleLab = [[UILabel alloc] init];
    _titleLab.textColor = UIFontBlack282828;
    _titleLab.font = UIFontSize(13);
    [self addSubview:_titleLab];
    [self addSubview:self.numberButton];
    self.numberButton.currentNumber = 1;
    
    UILabel *lineLab = [[UILabel alloc] init];
    lineLab.backgroundColor = UINavSepratorLineColor;
    [self addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(kAutoWidth6(12));
        make.height.mas_equalTo(0.5);
    }];
}



-(void)makeCellWithTitle:(NSString *)title andNum:(NSInteger)num isBackNum:(BOOL)isBack{
    self.titleLab .text = title;
    self.titleLab.textColor = isBack?UIStringColor(@"#7b7b7b"):UIFontBlack282828;
    self.titleLab.font = isBack?UIFontSize(15):UIFontSize(13);
    self.numberButton.currentNumber = num;
}
-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, kAutoWidth6(44)));
        make.left.equalTo(self).offset(kAutoWidth6(12));
    }];
    
    [_numberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(111), kAutoHeight6(30)));
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWidth6(12));
    }];
    
}

- (PPNumberButton *)numberButton
{
    if (!_numberButton) {
        PPNumberButton *numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(kScreenWidth - 112, 12.5, 100, 30)];
        // 开启抖动动画
        numberButton.shakeAnimation = YES;
        numberButton.delegate = self;
        //设置边框颜色
        numberButton.borderColor = UIRGBColor(216, 216, 216, 1);
        numberButton.increaseTitle = @"＋";
        numberButton.decreaseTitle = @"－";
        numberButton.minValue = 0;
        _numberButton = numberButton;
    }
    return _numberButton;
}

- (void)pp_numberButton:(__kindof UIView *)numberButton number:(NSString *)number
{
//    self.model.number = number.intValue;
    if (self.countBlock) {
        self.countBlock(self, number);
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
