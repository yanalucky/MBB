//
//  Fcgo_AfterServiceStyleCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterServiceStyleCell.h"

@implementation Fcgo_AfterServiceStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    
    // Initialization code
}

-(void)setUI{
    self.titleLabel.textColor = UIFontBlack282828;
    self.titleLabel.font = UIFontSize(15);
    _lineLab.backgroundColor = UIRGBColor(246, 244, 242, 1);
}
-(void)makeCellWithTitle:(NSString *)title image:(NSString *)imgName{
    self.titleLabel.text = title;
    self.leftImg.image = [UIImage imageNamed:imgName];
}

-(void)layoutSubviews{
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kAutoWidth6(10));
        make.width.and.height.mas_equalTo(kAutoWidth6(21));
        make.centerY.equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.leftImg.mas_right).offset(kAutoWidth6(12));
        make.height.mas_equalTo(kAutoWidth6(21));
        make.width.mas_equalTo(kAutoWidth6(200));
    }];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kAutoWidth6(15));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(6), kAutoHeight6(12)));
    }];
    [self.lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(kAutoHeight6(0.5));
        make.bottom.equalTo(self);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
