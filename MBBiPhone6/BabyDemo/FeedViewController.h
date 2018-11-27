//
//  FeedViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/18.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedViewController : UIViewController


@property(nonatomic , assign) int name;
@property(nonatomic , assign) int month;

@property(nonatomic , assign) int data;
@property(nonatomic , assign) int data1;

-(instancetype)initWithMonth:(int)month andName:(int)numb;

-(void)changeDataBlock:(void(^)(NSString *number0 , NSString *number1)) block;

@end
