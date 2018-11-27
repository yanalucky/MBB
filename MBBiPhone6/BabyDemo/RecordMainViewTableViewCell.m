//
//  RecordMainViewTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/5.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "RecordMainViewTableViewCell.h"

@implementation RecordMainViewTableViewCell{
    UILabel *verticalLine;
    UIView *_starView;
    UILabel *_horizontalLine;
    UILabel *_monthLab;
    int _numberOfStar;
    BOOL _isLeft;
    NSInteger _month;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self createCell];
    }
    return self;
}


-(void)createCell{
    verticalLine = [[UILabel alloc] init];
    verticalLine.backgroundColor = MBColor(249, 211, 229, 1);
    [self addSubview:verticalLine];
    
    
    _starView = [[UIView alloc] init];
    [self addSubview:_starView];
    
    _horizontalLine = [[UILabel alloc] init];
    _horizontalLine.backgroundColor = MBColor(249, 211, 229, 1);
    [self addSubview:_horizontalLine];
    
    _monthLab = [[UILabel alloc] init];
    _monthLab.textColor = [UIColor grayColor];
    _monthLab.font = [UIFont yaHeiFontOfSize:15*Ratio];
    [self addSubview:_monthLab];
    
    
    
}

-(void)makeCellWithMonth:(NSString *)month andNumberOfStar:(NSString *)numberStar andIsLeft:(BOOL)isleft{
    _month = [month intValue];
    _numberOfStar = [numberStar intValue];
    _isLeft = isleft;
    _monthLab.text = [NSString stringWithFormat:@"月龄%.2ld个月",(long)_month];
    
    for (id view in _starView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    for (int i=0; i<_numberOfStar; i++) {
        UIImageView *star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"star"];
        [_starView addSubview:star];
    }

    if (_numberOfStar == 0) {
        UIImageView *star = [[UIImageView alloc] init];
        star.image = [UIImage imageNamed:@"star_none"];
        [_starView addSubview:star];
    }
    
}


//高度 75
-(void)layoutSubviews{
    [verticalLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(1*Ratio));
        make.height.equalTo(@(57*Ratio));
        make.bottom.equalTo(self);
        make.centerX.equalTo(self);
    }];
    [_starView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10*Ratio);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(15*((_numberOfStar > 0)?_numberOfStar:1)*Ratio, 15*Ratio));
       
    }];
    UIImageView *lastStar = nil;
    for (int i=0; i<_starView.subviews.count; i++) {
        UIImageView *star = (UIImageView *)[_starView subviews][i];
        [star mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(15*Ratio, 15*Ratio));
            make.centerY.equalTo(_starView);
            if (lastStar) {
                make.left.equalTo(lastStar.mas_right);
            }else{
                make.left.equalTo(_starView);
            }
            
        }];
        lastStar = star;
        
    }
    
    
    
    [_horizontalLine mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40*Ratio-(_numberOfStar*5), 1*Ratio));
        make.centerY.equalTo(_starView);
        if (_isLeft) {
            make.right.equalTo(_starView.mas_left).offset(-5*Ratio);
        }else{
            make.left.equalTo(_starView.mas_right).offset(5*Ratio);
        }
        
    }];
    
    [_monthLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80*Ratio, 20*Ratio));
        make.centerY.equalTo(_starView);
        if (_isLeft) {
            make.right.equalTo(_horizontalLine.mas_left).offset(-5*Ratio);
        }else{
            make.left.equalTo(_horizontalLine.mas_right).offset(5*Ratio);
        }
    }];
}













- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
