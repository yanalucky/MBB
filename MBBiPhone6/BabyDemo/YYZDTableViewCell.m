//
//  YYZDTableViewCell.m
//  MBB1
//
//  Created by 陈彦 on 15/11/17.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import "YYZDTableViewCell.h"
#import "UIImageView+WebCache.m"


@implementation YYZDTableViewCell{
    BOOL _haveImg;
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self makeCell];
        
    }
    return self;
}
-(void)makeCell{
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _haveImg = NO;
    _title = [[UILabel alloc] init];
    self.title.textColor = [UIColor blackColor];
    [self addSubview:_title];
    
    _detail = [[UILabel alloc] init];
    
    self.detail.textColor = [UIColor grayColor];
    [self addSubview:_detail];
    
    _imageV = [[UIImageView alloc] init];
    [self addSubview:_imageV];
    
    
}


-(void)makeCellWithTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle andImageURL:(NSURL *)imageURL{
    
    self.title.text = title;
    self.title.font = [UIFont yaHeiFontOfSize:14*Ratio];
    NSMutableAttributedString *attributedString0 = [[NSMutableAttributedString alloc]initWithString:self.title.text];;
    NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle0 setLineSpacing:10];
    [attributedString0 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle0 range:NSMakeRange(0, self.title.text.length)];
    self.title.attributedText = attributedString0;
    
    
    self.detail.text = detailTitle;
    self.detail.font = [UIFont yaHeiFontOfSize:13*Ratio];
    self.detail.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.detail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.detail.text.length)];
    self.detail.attributedText = attributedString;

    if (imageURL) {
        [_imageV sd_setImageWithURL:imageURL];
        _haveImg = YES;
    }else{
        _haveImg = NO;
    }
    
    
    
}
-(void)layoutSubviews{
    
//    CGRect rect = [self.detail.text boundingRectWithSize:CGSizeMake(290, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont yaHeiFontOfSize:13] forKey:NSFontAttributeName] context:nil];
//    CGSize size = [self.detail sizeThatFits:CGSizeMake(290, 20000)];
   [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
       make.left.equalTo(self).offset(15*Ratio);
       make.top.equalTo(self).offset(5*Ratio);
       make.height.equalTo(@(20*Ratio));
       make.width.equalTo(self).offset(-30*Ratio);
       
   }];

    [_detail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15*Ratio);
        make.top.equalTo(self.title.mas_bottom).offset(15*Ratio);
        make.bottom.equalTo(self).offset((_haveImg == YES)?(-105*Ratio):(-5*Ratio));
        make.width.equalTo(self).offset(-30*Ratio);
    }];
    
    
    [_imageV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(_detail.mas_bottom).offset(5*Ratio);
        make.width.mas_equalTo(175*Ratio);
        make.bottom.equalTo(self);
    }];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
