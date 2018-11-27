//
//  Time.m
//  MBB1
//
//  Created by 陈彦 on 15/9/23.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "Time.h"

@implementation Time
+(NSArray *)timewithBirth:(NSString *)birth andNow:(NSString *)nowTime{
    int year = 0;
    int month = 0;
    int day = 0;
    NSArray *time = [birth componentsSeparatedByString:@"-"];
    NSArray *timeNow = [nowTime componentsSeparatedByString:@"-"];
    //nslog(@"%@%@",time,timeNow);
//    int ti = [time[2] intValue];
//    int tiNow = [timeNow[2] intValue];
    if ([time[2] intValue]<=[timeNow[2] intValue]) {
        month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
            day = [timeNow[2] intValue]-[time[2] intValue];
    }else{
        if ([Time isEndOfMonth:birth] == YES) {
            if ([Time isEndOfMonth:nowTime] == YES) {
                month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
                
            }else{
                month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
                month = month - 1;
                day = [timeNow[2] intValue];
//                if ([time[2] intValue] == 30) {
//                    day = day + 1;
//                }
//                if ([time[2] intValue] == 29) {
//                    day = day + 2;
//                }
            }
        }else{
            
            if ([Time isEndOfMonth:nowTime] == YES) {
                 month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
            }else{
                month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
                month = month - 1;
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                [format setDateFormat:@"yyyy-MM-dd"];
                NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
                [dateComponents setMonth:month];
                NSDate *bithAddMonth = [calendar dateByAddingComponents:dateComponents toDate:[format dateFromString:birth] options:0];
                NSDate *nowDate = [format dateFromString:nowTime];
                NSTimeInterval time = [nowDate timeIntervalSinceDate:bithAddMonth];
                day = time/60/60/24;

            }
            /*2017.04.06之前
            month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
            month = month - 1;
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateFormat:@"yyyy-MM-dd"];
            NSDate *nowDate = [format dateFromString:nowTime];
            NSString *lastMonth;
            
            if ([timeNow[1] intValue] == 1) {
                lastMonth = [NSString stringWithFormat:@"%d-%d-%d",[timeNow[0] intValue]-1,12,[time[2] intValue]];
            }else{
                lastMonth = [NSString stringWithFormat:@"%@-%d-%d",timeNow[0],[timeNow[1] intValue]-1,[time[2] intValue]];
            }
            NSDate *lastDate = [format dateFromString:lastMonth];
            NSTimeInterval time = [nowDate timeIntervalSinceDate:lastDate];
            
            day = time/60/60/24;
            
            */
            /*
             
             2016.02.23之前
            
             if ([Time isEndOfMonth:nowTime] == YES) {
                month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
                
            }else{
                month = [Time monthBybirthbirthYear:[time[0] intValue] Month:[time[1] intValue] nowYear:[timeNow[0] intValue] nowMonth:[timeNow[1] intValue]];
                month = month - 1;
                NSString *lastMonth;
                if ([timeNow[1] intValue] == 1) {
                    lastMonth = [NSString stringWithFormat:@"%d-%d-%d",[timeNow[0] intValue]-1,12,1];
                }else{
                    lastMonth = [NSString stringWithFormat:@"%@-%d-%d",timeNow[0],[timeNow[1] intValue]-1,1];
                }
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                NSDate *date0 = [formatter dateFromString:lastMonth];
                NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
                NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date0];

                int maxDayOfLastMonth = range.length;
                int maxDayOfLastMonth = [[Time getMonthBeginAndEndWith:lastMonth] intValue];
                if (maxDayOfLastMonth>[time[2] intValue]) {
                    day = maxDayOfLastMonth - [time[2] intValue] + [timeNow[2] intValue];
                }else{
                    day = [timeNow[2] intValue];
                }
            }*/
        }
        
    }
    day ++;
    year = month/12;
    month = month%12;
    /*
    NSString *lastMonth;
    if ([timeNow[1] intValue] == 1) {
        lastMonth = [NSString stringWithFormat:@"%d-%d-%d",[timeNow[0] intValue]-1,12,1];
    }else{
        lastMonth = [NSString stringWithFormat:@"%@-%d-%d",timeNow[0],[timeNow[1] intValue]-1,1];
    }
    int maxDayOfLastMonth = [[Time getMonthBeginAndEndWith:lastMonth] intValue];

    if (day == maxDayOfLastMonth) {
        month = month + 1;
        day = 0;
    }
     */
    NSString *str = [NSString stringWithFormat:@"%d",year];
    NSString *str1 = [NSString stringWithFormat:@"%d",month];
    NSString *str2 = [NSString stringWithFormat:@"%d",day];
    
    
    NSArray *arr =@[str,str1,str2];
    
    return arr;
}
+(int)monthBybirthbirthYear:(int)birthYear Month:(int)birthMonth nowYear:(int)nowYear nowMonth:(int)nowMonth{
    
    int mont = (nowYear-birthYear)*12+nowMonth-birthMonth;
    return mont;
    
}
+(BOOL)isEndOfMonth:(NSString *)date{
    
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    NSDate *date0 = [formatter dateFromString:date];
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:date0];
    
    ;
    
    int day = [[Time getMonthBeginAndEndWith:date] intValue];
    int trueDay = [[date substringFromIndex:8] intValue];
    if (trueDay == day) {
        return YES;
    }else{
        return NO;
    }
    
    
}


+ (NSString *)getMonthBeginAndEndWith:(NSString *)dateStr{
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    int num = (int)[calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:newDate].length;
    NSString *str = [NSString stringWithFormat:@"%d",num];
    //nslog(@"这个月的天数是 = %@",str);
    return str;
    /*
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate=[format dateFromString:dateStr];
    double interval = 0;
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    BOOL ok = [calendar rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:newDate];
    //分别修改为 NSDayCalendarUnit NSWeekCalendarUnit NSYearCalendarUnit
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        return @"";
    }
    NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
    [myDateFormatter setDateFormat:@"YYYY.MM.dd"];
    NSString *beginString = [myDateFormatter stringFromDate:beginDate];
    NSString *endString = [myDateFormatter stringFromDate:endDate];
    NSString *s = [endString substringFromIndex:endString.length-2];
    return s;
     */
    
    
}
@end
