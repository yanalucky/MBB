//
//  PaySuccessViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/7/22.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaySuccessViewController : UIViewController


@property(strong , nonatomic) NSString *menuId;
@property(strong , nonatomic) NSString *doctorId;
@property(strong , nonatomic) NSString *hospitalId;

@property(assign , nonatomic) BOOL isLong;


@property(assign , nonatomic) BOOL isRegist;

@end
