//
//  YESLViewController.h
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YESLViewController : FatherViewController
@property (assign , nonatomic) BOOL sex;

@property (strong , nonatomic) UIView *mainView;
@property (strong , nonatomic) UIView *nextView;
@property (strong , nonatomic) NSMutableArray *dataArr;
@end
