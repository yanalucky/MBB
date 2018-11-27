//
//  DoctorViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/6/28.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerConfigDoctorList.h"

@interface DoctorViewController : UIViewController

@property (strong , nonatomic) ServerConfigDoctorList *doctor;


@property (strong , nonatomic) NSString *hospitalName;


@property (strong , nonatomic) void(^selMeBlock)();


@property (nonatomic , assign) BOOL isSel;

@end
