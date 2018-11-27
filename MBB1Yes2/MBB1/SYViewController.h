//
//  SYViewController.h
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SYViewController : FatherViewController<UITableViewDataSource,UITableViewDelegate>
@property (assign , nonatomic) BOOL sex;
@property (strong , nonatomic) UIView *right0;
@property (strong , nonatomic) UIView *right1;
@property (strong , nonatomic) UIImageView *headerV;


@property (strong , nonatomic) NSMutableArray *monthDataArr;
@end
