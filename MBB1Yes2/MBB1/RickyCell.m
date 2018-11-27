//
//  RickyCell.m
//  TableViewNoDataDemo
//
//  Created by 王保霖 on 15/10/28.
//  Copyright © 2015年 Ricky. All rights reserved.
//

#import "RickyCell.h"

@implementation RickyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self makeInterfance];
    }
    return self;
}

-(void)makeInterfance{
    
    btn =[UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:btn];
    
}

-(void)makeCellWithStr:(NSString *)str andISCustome:(BOOL)iscustom andISGirl:(BOOL)isgirl{

    _isme = iscustom;
    _sex =isgirl;
    if (iscustom) {
        _text= str;
    }else{
        _text = [NSString stringWithFormat:@"客服：%@",str];
    }
    
    [btn setTitle:str forState:UIControlStateNormal];
    
    btn.titleLabel.font =[UIFont systemFontOfSize:15];
//    [btn setBackgroundImage:[UIImage imageNamed:@"0-kefu-kuang2"] forState:UIControlStateNormal];
    btn.titleLabel.numberOfLines = 0;
    btn.enabled= NO;
}


-(void)layoutSubviews{
    
    
    CGSize titleSize = [_text boundingRectWithSize:CGSizeMake(300,1000000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    
    UIImage *image =[UIImage imageNamed:@"kefu-kuang2" ofSex:_sex];
    UIImage *image1 = [UIImage imageNamed:@"kefu-kuang1" ofSex:_sex];
    UIEdgeInsets insets = UIEdgeInsetsMake(10,10,20,10);
    UIEdgeInsets insets1 = UIEdgeInsetsMake(20, 10, 10,10);
//    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    image1 = [image1 resizableImageWithCapInsets:insets1 resizingMode:UIImageResizingModeStretch];
    
    
    
    
    if(!_isme)
    {
     
        btn.frame = CGRectMake(10, 0,330,titleSize.height+20);
        
        [btn setBackgroundImage:image1 forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.titleEdgeInsets = insets1;
        
    }
    else
    {
        btn.frame = CGRectMake(self.bounds.size.width-330-10, 0,330,titleSize.height+20);
        [btn setBackgroundImage:image forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentLeft;
        btn.titleEdgeInsets = insets;

    }
}

@end
