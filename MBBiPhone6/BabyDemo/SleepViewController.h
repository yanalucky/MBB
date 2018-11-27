//
//  SleepViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/18.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SleepViewController : UIViewController

@property(nonatomic , assign) int month;

@property(nonatomic , assign) int name;

@property(nonatomic , strong) UIButton *number;

@property(nonatomic , assign) NSString *data;

@property(nonatomic , assign) NSString *data1;

-(instancetype)initWithMonth:(int)month andName:(int)numb;

-(void)changeDataBlock:(void(^)(BOOL _isDefecate, NSString *number0 , NSString *number1)) block;


@end
