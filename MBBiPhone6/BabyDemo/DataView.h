//
//  DataView.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataView : UIView

@property (strong , nonatomic) UIButton *button;

@property (strong , nonatomic) NSString *title;

@property (strong , nonatomic) NSString *unit;


-(void)makeViewWithTitle:(NSString *)title andUnit:(NSString *)unit andNumberData:(NSString *)number;

@end
