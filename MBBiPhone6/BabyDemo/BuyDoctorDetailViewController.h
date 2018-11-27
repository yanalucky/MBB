//
//  BuyDoctorDetailViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConfigDoctorList.h"

@interface BuyDoctorDetailViewController : UIViewController

@property (strong , nonatomic) ServerConfigDoctorList *doctor;


@property (strong , nonatomic) NSString *hospitalName;

@property (strong , nonatomic) NSString *currentMenu;


@property (nonatomic , assign) BOOL isSel;

@end
