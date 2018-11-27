//
//  BuyOrderViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ServerConfigDoctorList;
@interface BuyOrderViewController : UIViewController

@property (nonatomic , strong) ServerConfigDoctorList *doctor;
@property (nonatomic , strong) NSString *infoStr;

@end
