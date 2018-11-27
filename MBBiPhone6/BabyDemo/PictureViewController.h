//
//  PictureViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/25.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureViewController : UIViewController

@property (nonatomic , assign) int number;
@property(nonatomic , assign) int month;
@property(nonatomic , assign) BOOL sex;

@property(nonatomic , strong) NSArray *imgDataArr;
@property(nonatomic , strong) NSArray *currentMonthFeatureArr;

-(instancetype)initWithMonth:(int)month andSex:(BOOL)sex;

@end
