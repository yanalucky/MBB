//
//  BodyLengthViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/11.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BodyLengthViewController : UIViewController

@property(nonatomic , assign) int name;

@property(nonatomic , assign) BOOL sex;

@property(nonatomic , assign) int month;

@property(nonatomic , assign) float data;

@property(nonatomic , strong) UILabel *number;

-(instancetype)initWithSex:(BOOL)sex andName:(int)numb;

-(void)changeDataBlock:(void(^)(NSString *number)) block;


@end
