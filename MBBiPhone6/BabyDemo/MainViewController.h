//
//  MainViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FatherViewController.h"
#import "JTCalendar.h"
#import "NoticeModel.h"



@interface MainViewController : FatherViewController<JTCalendarDataSource>



@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;



@property (copy, nonatomic) void(^imgBlock)(UIImage *image);

@property (strong, nonatomic) UIImageView *header;

@end
