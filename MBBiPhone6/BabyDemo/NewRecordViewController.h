//
//  NewRecordViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/5.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordStarDataModels.h"

@interface NewRecordViewController : UIViewController


@property(nonatomic , assign) int month;

@property(nonatomic , strong) RecordStarRecordStar *recordStar;

@property(nonatomic , strong) NSString *theLastRecordStr;

@property(nonatomic , assign) BOOL isHiddenSubmit;

@property(nonatomic , assign) BOOL canChangeData;



@property(nonatomic , strong) NSString *showTime;
@property(nonatomic , strong) NSString *recordStatus;
@property(nonatomic , assign) int timeStatus;

@end
