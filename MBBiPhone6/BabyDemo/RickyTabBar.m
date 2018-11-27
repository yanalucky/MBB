//
//  RickyTabBar.m
//  BabyDemo
//
//  Created by 王保霖 on 16/3/9.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "RickyTabBar.h"

@implementation RickyTabBar

-(instancetype)initWithFrame:(CGRect)frame{

    if(self = [super initWithFrame:frame]){
    
         [self setBackgroundImage:[UIImage imageNamed:@"tabbg"]];
    }
    
    return self;
}

-(void)layoutSubviews{
 
    [super layoutSubviews];
    
    //这里可以对Tabbar的button的位置进行修改
}

@end
