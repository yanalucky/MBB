//
//  BuyDoctorTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/7/12.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyDoctorTableViewCell : UITableViewCell


@property (nonatomic , strong) UIButton *rightBtn;
@property (nonatomic , strong) NSIndexPath *indexpath;

-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withColorTitle:(NSString *)clrStr withGoodAtTitle:(NSString *)goodAtTitle withIsSel:(BOOL)isSel;

@end
