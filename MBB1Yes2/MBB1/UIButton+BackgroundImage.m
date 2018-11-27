//
//  UIButton+BackgroundImage.m
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "UIButton+BackgroundImage.h"

@implementation UIButton (BackgroundImage)
-(void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state backgroundImage:(UIImage *)image1 forState:(UIControlState)state1{
    [self setBackgroundImage:image forState:state];
    [self setBackgroundImage:image1 forState:state1];
    [self setBackgroundImage:image1 forState:UIControlStateHighlighted];
}
@end
