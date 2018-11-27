//
//  CYRecordAlertView.h
//  BabyDemo
//
//  Created by 陈彦 on 16/7/11.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYRecordAlertView : UIView


@property (strong , nonatomic) void(^clickBlocks)(void);

@property (strong , nonatomic) void(^payBlocks)(void);

-(void)alertViewWith:(NSString *)title andDetailTitle:(NSString *)detailTitle andButtonTitle:(NSString *)buttonTitle;

@end
