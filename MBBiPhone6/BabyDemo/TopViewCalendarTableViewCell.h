//
//  TopViewCalendarTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/3/22.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewCalendarTableViewCell : UITableViewCell

-(void)makeCellByLeftImageName:(NSString *)leftImageName withTitle:(NSString *)title withDetailTitle:(NSString *)detailTitle withIsRight:(BOOL)isRight;

@end
