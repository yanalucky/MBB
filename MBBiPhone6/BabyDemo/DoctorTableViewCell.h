//
//  DoctorTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/5/6.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoctorTableViewCell : UITableViewCell

@property (nonatomic , strong) UIButton *rightBtn;
@property (nonatomic , strong) NSIndexPath *indexpath;

-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withColorTitle:(NSString *)clrStr withIsSel:(BOOL)isSel;

@end
