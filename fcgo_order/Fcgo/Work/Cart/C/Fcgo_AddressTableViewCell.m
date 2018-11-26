//
//  Fcgo_AddressTableViewCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddressTableViewCell.h"

@implementation Fcgo_AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setInterface];
    
    // Initialization code
}

-(void)setInterface{
    
    _addressLab.text = @"";
    _addressLab.textColor = UIFontBlack282828;
    _addressLab.font = [UIFont systemFontOfSize:15];
    _addressLab.numberOfLines = 0;
    [_leftImgView setImage:[UIImage imageNamed:@"address"]];
    
    _selectImgV.hidden = YES;
    
}
-(void)makeCellWithAddress:(NSString *)address andIsSel:(BOOL)issel{
    _addressLab.text = address;
    _addressLab.textColor = (issel == 1)?[UIColor colorWithRed:246/255.0 green:17/255.0 blue:116/255.0 alpha:1]:UIFontBlack282828;
    UIImage *image = [UIImage imageNamed:(issel == 1)?@"icon_-red--position":@"adress"];
    [_leftImgView setImage:image];
    _selectImgV.hidden = !issel;
}
-(void)layoutSubviews{
    
    [_leftImgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
        make.centerY.equalTo(self);
    }];
    
    //CGSize size =[_addressLab sizeThatFits:CGSizeMake(kScreenWidth - 55, 3000)];
    [_addressLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(35);
        //make.size.mas_equalTo(CGSizeMake(kScreenWidth -80, size.height));
        make.right.mas_offset(-45);
        make.centerY.equalTo(self);
    }];
    [_selectImgV mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.size.mas_equalTo(CGSizeMake(17, 17));
        make.centerY.equalTo(self);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

//    _addressLab.textColor = [UIColor colorWithRed:246/255.0 green:17/255.0 blue:116/255.0 alpha:1];
    // Configure the view for the selected state
}

@end
