//
//  UILabel+Nature.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UILabel+Nature.h"

@implementation UILabel (Nature)

-(void)makeLabelWithText:(NSString *)text andTextColor:(UIColor *)textColor andFont:(UIFont *)font{
    
    self.font = font;
    self.text = text;
    self.textColor = textColor;
    
}

@end
