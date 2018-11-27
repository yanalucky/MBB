//
//  CalendarViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/28.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"


@interface CalendarViewController : UIViewController<JTCalendarDataSource>


@property (strong, nonatomic) JTCalendarContentView *calendarContentView;

@property (strong, nonatomic) NSLayoutConstraint *calendarContentViewHeight;

@property (strong, nonatomic) JTCalendar *calendar;

@property (strong, nonatomic) UIButton *selectedDateBtn;

@end


