//
//  UIFont+yaHei.m
//  MBB1
//
//  Created by 陈彦 on 15/9/14.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "UIFont+yaHei.h"

@implementation UIFont (yaHei)

+(UIFont *)yaHeiFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"Microsoft YaHei" size:fontSize];

    return font;
}

@end
