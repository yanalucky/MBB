//
//  Fcgo_CalendarTools.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CalendarTools.h"

@implementation Fcgo_CalendarTools

+ (Fcgo_CalendarTools *)shared
{
    static  Fcgo_CalendarTools  *_shareInstance = nil;
    static  dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance=[[Fcgo_CalendarTools  alloc] init];
        _shareInstance.eventStore = [[EKEventStore alloc] init];
    });
    return _shareInstance;
}

- (void)saveEventwithWholePointModel:(Fcgo_WholePointModel *)model goodsModel:(Fcgo_WholePointGoodsModel *)goodsModel  block:(void(^)(void))block
{
    long long time = model.start.longLongValue/1000;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *endDate   = [NSDate dateWithTimeIntervalSince1970:model.end.longLongValue/1000];
    NSString *urlString = [NSString stringWithFormat:@"openfcgo://detail?params=%@&type=integral",goodsModel.f_integral_id];
    //写⼊入事件
    if ([self.eventStore respondsToSelector:@selector(requestAccessToEntityType:completion:)])
    {
        //等待用户授权访问日历
        //EKEntityMaskEvent/Reminder:事件/提醒（该参数只能真机使用）  EKEntityTypeEvent/Reminder:事件/提醒
        [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^
                            {
                                if (error)
                                {
                                    //NSLog(@"%@",error.localizedDescription);
                                }
                                else
                                    if (!granted)
                                    {
                                        //被⽤户拒绝,不允许访问日历
                                        //NSLog(@"用户不允许访问日历");
                                        [Fcgo_AlertAnimationView showWithTitle:@"提示" text:@"请在设置中打开备货通对手机日历的访问" cancelTitle:@"取消" confirmTitle:@"确定" block:^{
                                        }];
                                    }
                                    else
                                    {
                                        if(startDate && endDate)
                                        {
                                            //[WeakSelf deleteInsertedEventStartDate:startDate endDate:endDate eventTitle:eventTitle block:nil];
                                            //根据开始时间和结束时间创建谓词
                                            NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
                                            if(predicate)
                                            {
                                                //根据谓词条件筛选已插入日历的事件
                                                NSArray *eventsArray = [self.eventStore eventsMatchingPredicate:predicate];
                                                if (eventsArray.count)
                                                {
                                                    for (EKEvent *item in eventsArray)
                                                    {
                                                        //根据事件的某个唯一性，如果已插入日历就不再插入
                                                        if([item.URL.absoluteString isEqualToString:urlString])
                                                        {
                                                            return ;
                                                        }
                                                    }
                                                }
                                            }
                                            //创建事件
                                            EKEvent *event = [EKEvent eventWithEventStore:self.eventStore];
                                            //主标题
                                            event.title = @"抢购开始";
                                            //副标题
                                            event.location = [NSString stringWithFormat:@"%@%@开始抢购",goodsModel.goodsName,model.name];
                                            //事件设定为全天事件
                                            event.allDay = NO;
                                            //设定事件开始时间
                                            event.startDate=startDate;
                                            //设定事件结束时间
                                            event.endDate=endDate;
                                            //设定URL,点击可打开对应的app:AAA为某应用对外访问的入口
                                            event.URL = [NSURL URLWithString:urlString];
                                            //添加提醒,可以添加多个
                                            //设定事件在开始时间多久前开始提醒
                                            [event addAlarm:[EKAlarm alarmWithRelativeOffset:-120]];
                                            event.calendar = [self.eventStore defaultCalendarForNewEvents];
                                            NSError *error;
                                            [self.eventStore saveEvent:event span:EKSpanThisEvent error:&error];
                                            
                                            //是否写入提醒事项，提醒事项为iOS原生自带的，但是模拟器没有
                                            
                                            EKCalendar * iDefaultCalendar = [self.eventStore defaultCalendarForNewReminders];
                                            EKReminder *reminder=[EKReminder reminderWithEventStore:self.eventStore];
                                            reminder.calendar=[self.eventStore defaultCalendarForNewReminders];
                                            reminder.title = [NSString stringWithFormat:@"%@%@开始抢购",goodsModel.goodsName,model.name];
                                            reminder.calendar = iDefaultCalendar;
                                            EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:[NSDate dateWithTimeIntervalSinceNow:-10]];
                                            [reminder addAlarm:alarm];
                                            
                                            NSError *error1 = nil;
                                            [self.eventStore saveReminder:reminder commit:YES error:&error1];
                                            if (error1)
                                            {
                                                //NSLog(@"error=%@",error.localizedDescription);
                                            }
                                            
                                            block();
                                            
                                        }
                                    }
                            });
         }];
    }
}

//! 删除之前插入的事件
- (void)deleteEventwithWholePointModel:(Fcgo_WholePointModel *)model goodsModel:(Fcgo_WholePointGoodsModel *)goodsModel  block:(void(^)(void))block
{
    long long time = model.start.longLongValue/1000;
    NSDate *startDate = [NSDate dateWithTimeIntervalSince1970:time];
    NSDate *endDate   = [NSDate dateWithTimeIntervalSince1970:model.end.longLongValue/1000];
    NSString *urlString = [NSString stringWithFormat:@"openfcgo://detail?params=%@&type=integral",goodsModel.f_integral_id];
    NSPredicate *predicate = [self.eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    NSArray *eventsArray = [self.eventStore eventsMatchingPredicate:predicate];
    if (eventsArray.count)
    {
        for (EKEvent *item in eventsArray)
        {
            if([item.URL.absoluteString isEqualToString:urlString])
            {
                //删除老版本插入的提醒
                [self.eventStore removeEvent:item span:EKSpanThisEvent commit:YES error:nil];
                
            }
        }
    }
    if (block) {
        block();
    }
}




@end
