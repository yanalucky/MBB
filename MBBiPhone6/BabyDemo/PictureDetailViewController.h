//
//  PictureDetailViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/5/20.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureDetailViewController : UIViewController

@property(nonatomic , assign) int number;

@property(nonatomic , strong) NSArray *pictureArr;
@property(nonatomic , strong) NSArray *currentMonthFeatureArr;

@end
