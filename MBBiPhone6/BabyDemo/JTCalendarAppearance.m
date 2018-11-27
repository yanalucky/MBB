//
//  JTCalendarAppearance.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarAppearance.h"

@implementation JTCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if(!self){
        return nil;
    }
        
    [self setDefaultValues];
    
    return self;
}

- (void)setDefaultValues
{
    self.isWeekMode = NO;
    
    self.weekDayFormat = JTCalendarWeekDayFormatShort;
    
    self.ratioContentMenu = 2.;
    self.dayCircleRatio = 1.;
    self.dayDotRatio = 2. / 10.;
    
    self.menuMonthTextFont = [UIFont systemFontOfSize:17.*Ratio];
    self.weekDayTextFont = [UIFont systemFontOfSize:10*Ratio];
//    self.dayTextFont = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.dayTextFont = [UIFont yaHeiFontOfSize:14*Ratio];
    
    self.menuMonthTextColor = [UIColor blackColor];
    self.weekDayTextColor = [UIColor colorWithRed:153./255. green:153./255. blue:153./255. alpha:1.];
    
    [self setDayDotColorForAll:[UIColor colorWithRed:101./255. green:44./255. blue:104./255. alpha:1]];
    [self setDayTextColorForAll:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]];
    
    self.dayTextColorOtherMonth = [UIColor colorWithRed:152./256. green:147./256. blue:157./256. alpha:1.];
    self.dayCircleColorSelected = [UIColor colorWithRed:216/255.0 green:24/255.0 blue:127/255.0 alpha:1];
    self.dayTextColorSelected = [UIColor whiteColor];
    self.dayDotColorSelected = [UIColor colorWithRed:101./255. green:44./255. blue:104./255. alpha:1];
    
    self.dayCircleColorSelectedOtherMonth = self.dayCircleColorSelected;
    self.dayTextColorSelectedOtherMonth = self.dayTextColorSelected;
    self.dayDotColorSelectedOtherMonth = self.dayDotColorSelected;
    
    self.dayCircleColorToday = [UIColor colorWithRed:0x33/256. green:0xB3/256. blue:0xEC/256. alpha:.5];
    self.dayTextColorToday = [UIColor whiteColor];
    self.dayDotColorToday = [UIColor colorWithRed:101./255. green:44./255. blue:104./255. alpha:1];
    
    self.dayCircleColorTodayOtherMonth = self.dayCircleColorToday;
    self.dayTextColorTodayOtherMonth = self.dayTextColorToday;
    self.dayDotColorTodayOtherMonth = self.dayDotColorToday;
    
    
    self.isHiddenCYView = YES;
}

- (NSCalendar *)calendar
{
    static NSCalendar *calendar;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        calendar.timeZone = [NSTimeZone localTimeZone];
    });
    
    return calendar;
}

- (void)setDayDotColorForAll:(UIColor *)dotColor
{
    self.dayDotColor = dotColor;
    self.dayDotColorSelected = dotColor;
    
    self.dayDotColorOtherMonth = dotColor;
    self.dayDotColorSelectedOtherMonth = dotColor;
    
    self.dayDotColorToday = dotColor;
    self.dayDotColorTodayOtherMonth = dotColor;
}

- (void)setDayTextColorForAll:(UIColor *)textColor
{
    self.dayTextColor = textColor;
    self.dayTextColorSelected = textColor;
    
    self.dayTextColorOtherMonth = textColor;
    self.dayTextColorSelectedOtherMonth = textColor;
    
    self.dayTextColorToday = textColor;
    self.dayTextColorTodayOtherMonth = textColor;
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
