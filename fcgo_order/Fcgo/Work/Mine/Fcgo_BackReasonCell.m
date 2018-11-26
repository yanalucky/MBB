//
//  Fcgo_BackReasonCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BackReasonCell.h"

@implementation Fcgo_BackReasonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    
    // Initialization code
}
-(void)setUI{
    self.titleLab.font = UIFontSize(15);
    self.titleLab.textColor = UIFontBlack282828;
    [self.selBtn setBackgroundImage:[[UIImage imageNamed:@"select_off"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    self.selBtn.userInteractionEnabled = NO;
    [self.selBtn setBackgroundImage:[[UIImage imageNamed:@"select_on"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateSelected];
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = UINavSepratorLineColor;
    [self addSubview: line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.and.centerX.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}
-(void)makeCellWithTitle:(NSString *)title isSel:(BOOL)isSel{
    self.titleLab.text = title;
    self.selBtn.selected = isSel;
}

-(void)layoutSubviews{
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(200), kAutoHeight6(40)));
    }];
    
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWidth6(12));
        make.width.and.height.mas_equalTo(kAutoWidth6(25));
    }];
    
    
  
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
