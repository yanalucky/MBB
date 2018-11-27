//
//  UIFont+yahei.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/17.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UIFont+yahei.h"

@implementation UIFont (yahei)

+(UIFont *)yaHeiFontOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"MicrosoftYaHei" size:fontSize];
    
    
    return font;
}
+(UIFont *)yaHeiFontBoldOfSize:(CGFloat)fontSize{
    UIFont *font = [UIFont fontWithName:@"MicrosoftYaHei-Bold" size:fontSize];
    return font;
}

@end
