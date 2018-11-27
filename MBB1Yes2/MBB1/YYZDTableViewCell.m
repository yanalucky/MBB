//
//  YYZDTableViewCell.m
//  MBB1
//
//  Created by 陈彦 on 15/11/17.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import "YYZDTableViewCell.h"
#import "LoginUserDetaillist.h"
#import "UIImageView+WebCache.h"
@implementation YYZDTableViewCell{
    LoginUserDetaillist *_cellModel;
}

- (void)awakeFromNib {
    
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)makeCellWithModel:(LoginUserDetaillist *)model andSex:(BOOL)isGirl{
    _cellModel = model;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    self.title.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,detail.appraisaltitle];
//    self.title.text = model.appraisaltitle;
    self.title.font = [UIFont yaHeiFontOfSize:22];
    
    if (isGirl == YES) {
        self.title.textColor = BOY_WORDCOLOR;

    }else{
        self.title.textColor = GIRL_WORDCOLOR;
    }
    NSMutableAttributedString *attributedString0 = [[NSMutableAttributedString alloc]initWithString:self.title.text];;
    NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle0 setLineSpacing:30];
    [attributedString0 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle0 range:NSMakeRange(0, self.title.text.length)];
    self.title.attributedText = attributedString0;
    
    
    self.detail.text = model.appraisalcontent;
    self.detail.textColor = WORDDARKCOLOR;
    self.detail.font = [UIFont yaHeiFontOfSize:20];
    self.detail.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:self.detail.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.detail.text.length)];
    self.detail.attributedText = attributedString;
    
    
//    self.detail.backgroundColor = [UIColor yellowColor];
    if (model.imgurl.length > 0) {
        NSURL *url = [NSURL URLWithString:[NSString urlStringOfImage:model.imgurl]];
        [self.imageV sd_setImageWithURL:url];
        
        
    }
    
    
//    self.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
    
    
    
}
-(void)layoutSubviews{
    self.title.frame = CGRectMake(5, 3, 769, 30);
    CGRect rect = [_cellModel.appraisalcontent boundingRectWithSize:CGSizeMake(769, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont yaHeiFontOfSize:20] forKey:NSFontAttributeName] context:nil];
    self.detail.frame = CGRectMake(5, 35, rect.size.width, rect.size.height+ (rect.size.height/30+1)*10);
    
    self.imageV.frame = CGRectMake(0, self.detail.frame.origin.y+ self.detail.frame.size.height + 10, 360, 270);

    
}

@end
