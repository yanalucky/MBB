//
//  JTCalendarMonthWeekDaysView.m
//  JTCalendar
//
//  Created by Jonathan Tribouharet
//

#import "JTCalendarMonthWeekDaysView.h"

@implementation JTCalendarMonthWeekDaysView

static NSArray *cacheDaysOfWeeks;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self){
        return nil;
    }
    
    [self commonInit];
    
    return self;
}

- (void)commonInit
{
    
    NSMutableArray *days = (NSMutableArray *)[self daysOfWeek];
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        
        if (day.length > 2) {
            
            day = [[day uppercaseString] substringToIndex:3];
            [days replaceObjectAtIndex:i withObject:day];
            
            if ([day isEqualToString:@"SUN"]||[day isEqualToString:@"周日"]) {
                [days replaceObjectAtIndex:i withObject:@"日"];
            }else if ([day isEqualToString:@"MON"]||[day isEqualToString:@"周一"]) {
                [days replaceObjectAtIndex:i withObject:@"一"];
            }else if ([day isEqualToString:@"TUE"]||[day isEqualToString:@"周二"]) {
                [days replaceObjectAtIndex:i withObject:@"二"];
            }else if ([day isEqualToString:@"WED"]||[day isEqualToString:@"周三"]) {
                [days replaceObjectAtIndex:i withObject:@"三"];
            }else if ([day isEqualToString:@"THU"]||[day isEqualToString:@"周四"]) {
                [days replaceObjectAtIndex:i withObject:@"四"];
            }else if ([day isEqualToString:@"FRI"]||[day isEqualToString:@"周五"]) {
                [days replaceObjectAtIndex:i withObject:@"五"];
            }else if ([day isEqualToString:@"SAT"]||[day isEqualToString:@"周六"]) {
                [days replaceObjectAtIndex:i withObject:@"六"];
            }

        }
        
        
    }
    for(NSString *day in days){
        UILabel *view = [UILabel new];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.textAlignment = NSTextAlignmentCenter;
        view.text = day;
        
        [self addSubview:view];
        
    }
    
    self.backgroundColor = [UIColor clearColor];
}

- (NSArray *)daysOfWeek
{
    if(cacheDaysOfWeeks){
        return cacheDaysOfWeeks;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSMutableArray *days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
        
    // Redorder days for be conform to calendar
    {
        NSCalendar *calendar = self.calendarManager.calendarAppearance.calendar;
        NSUInteger firstWeekday = (calendar.firstWeekday + 6) % 7; // Sunday == 1, Saturday == 7
                
        for(int i = 0; i < firstWeekday; ++i){
            id day = [days firstObject];
            [days removeObjectAtIndex:0];
            [days addObject:day];
        }
    }
    for(NSInteger i = 0; i < days.count; ++i){
        NSString *day = days[i];
        day = [[day uppercaseString] substringToIndex:(day.length > 2)?3:2];
        [days replaceObjectAtIndex:i withObject:day];
        
        if ([day isEqualToString:@"SUN"]||[day isEqualToString:@"周日"]) {
            [days replaceObjectAtIndex:i withObject:@"日"];
        }else if ([day isEqualToString:@"MON"]||[day isEqualToString:@"周一"]) {
            [days replaceObjectAtIndex:i withObject:@"一"];
        }else if ([day isEqualToString:@"TUE"]||[day isEqualToString:@"周二"]) {
            [days replaceObjectAtIndex:i withObject:@"二"];
        }else if ([day isEqualToString:@"WED"]||[day isEqualToString:@"周三"]) {
            [days replaceObjectAtIndex:i withObject:@"三"];
        }else if ([day isEqualToString:@"THU"]||[day isEqualToString:@"周四"]) {
            [days replaceObjectAtIndex:i withObject:@"四"];
        }else if ([day isEqualToString:@"FRI"]||[day isEqualToString:@"周五"]) {
            [days replaceObjectAtIndex:i withObject:@"五"];
        }else if ([day isEqualToString:@"SAT"]||[day isEqualToString:@"周六"]) {
            [days replaceObjectAtIndex:i withObject:@"六"];
        }
        
        
        
    }
   /* switch(self.calendarManager.calendarAppearance.weekDayFormat){
        case JTCalendarWeekDayFormatSingle:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[[day uppercaseString] substringToIndex:1]];
            }
            break;
        case JTCalendarWeekDayFormatShort:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                if (day.length > 2) {
                    day = [[day uppercaseString] substringToIndex:3];
                    [days replaceObjectAtIndex:i withObject:day];
                    
                    if ([day isEqualToString:@"SUN"]||[day isEqualToString:@"周日"]) {
                        [days replaceObjectAtIndex:i withObject:@"日"];
                    }else if ([day isEqualToString:@"MON"]||[day isEqualToString:@"周一"]) {
                        [days replaceObjectAtIndex:i withObject:@"一"];
                    }else if ([day isEqualToString:@"TUE"]||[day isEqualToString:@"周二"]) {
                        [days replaceObjectAtIndex:i withObject:@"二"];
                    }else if ([day isEqualToString:@"WED"]||[day isEqualToString:@"周三"]) {
                        [days replaceObjectAtIndex:i withObject:@"三"];
                    }else if ([day isEqualToString:@"THU"]||[day isEqualToString:@"周四"]) {
                        [days replaceObjectAtIndex:i withObject:@"四"];
                    }else if ([day isEqualToString:@"FRI"]||[day isEqualToString:@"周五"]) {
                        [days replaceObjectAtIndex:i withObject:@"五"];
                    }else if ([day isEqualToString:@"SAT"]||[day isEqualToString:@"周六"]) {
                        [days replaceObjectAtIndex:i withObject:@"六"];
                    }
                }
                
                
            
            }
            break;
        case JTCalendarWeekDayFormatFull:
            for(NSInteger i = 0; i < days.count; ++i){
                NSString *day = days[i];
                [days replaceObjectAtIndex:i withObject:[day uppercaseString]];
            }
            break;
    }
    */
    cacheDaysOfWeeks = days;
    return cacheDaysOfWeeks;
}

- (void)layoutSubviews
{
    CGFloat x = 0;
    CGFloat width = self.frame.size.width / 7.;
    CGFloat height = self.frame.size.height;
    
    for(UIView *view in self.subviews){
        view.frame = CGRectMake(x, 0, width, height);
        x = CGRectGetMaxX(view.frame);
    }
    
    // No need to call [super layoutSubviews]
}

+ (void)beforeReloadAppearance
{
    cacheDaysOfWeeks = nil;
}

- (void)reloadAppearance
{
    for(int i = 0; i < self.subviews.count; ++i){
        UILabel *view = [self.subviews objectAtIndex:i];
        
        view.font = self.calendarManager.calendarAppearance.weekDayTextFont;
        view.textColor = self.calendarManager.calendarAppearance.weekDayTextColor;
        
        view.text = [[self daysOfWeek] objectAtIndex:i];
    }
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
