//
//  Fcgo_uploadPicTabCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_uploadPicTabCell.h"

@implementation Fcgo_uploadPicTabCell{
    UILabel *_titleLab;
    UILabel *_uploadState;
    UIImageView *_rightImg;
}

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
    _titleLab.textColor = UIStringColor(@"#7b7b7b");
    _titleLab.font = [UIFont systemFontOfSize:14];
    [self addSubview:_titleLab];
  
    _uploadState = [[UILabel alloc] init];
    _uploadState.textColor =UIFontRedColor;
    _uploadState.textAlignment = NSTextAlignmentRight;
    _uploadState.text = @"未上传";
    _uploadState.font = [UIFont systemFontOfSize:14];
    [self addSubview:_uploadState];
    
    _rightImg = [[UIImageView alloc] init];
    _rightImg.image = [UIImage imageNamed:@"icon_arrow"];
    [self addSubview:_rightImg];
    
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



-(void)makeCellWithTitle:(NSString *)title andDidload:(BOOL)isfinish{
    _titleLab.text = title;
    if (isfinish) {
        _uploadState.textColor = UIFontBlack282828;
        _uploadState.text = @"已上传";
    }else{
        _uploadState.textColor =UIFontRedColor;
        _uploadState.text = @"未上传";
    }
   
    
}
-(void)layoutSubviews{
    [_titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(280, kAutoWidth6(44)));
        make.left.equalTo(self).offset(kAutoWidth6(12));
    }];
    
    [_uploadState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWidth6(36));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(50), kAutoWidth6(44)));
    }];
    
    
    
    [_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(12), kAutoWidth6(12)));
    }];
}

/*
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, UIRGBColor(246, 244, 242, 1).CGColor);
    CGContextStrokeRect(context, CGRectMake(kAutoWidth6(12), rect.size.height, rect.size.width - kAutoWidth6(12), kAutoHeight6(1)));
    
}*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
