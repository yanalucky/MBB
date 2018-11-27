//
//  UIImage+Sex.m
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "UIImage+Sex.h"

@implementation UIImage (Sex)
+(UIImage *)imageNamed:(NSString *)name ofSex:(BOOL)isGirl{
    
    NSString *normal;
    if (isGirl == YES) {
        normal = [NSString stringWithFormat:@"1-%@",name];
    }else{
        normal = [NSString stringWithFormat:@"0-%@",name];
    }
    UIImage *normalIV = [[UIImage imageNamed:normal] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return normalIV;
}

@end
