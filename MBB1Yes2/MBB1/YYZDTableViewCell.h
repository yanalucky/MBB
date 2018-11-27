//
//  YYZDTableViewCell.h
//  MBB1
//
//  Created by 陈彦 on 15/11/17.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYZDTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *detail;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;


-(void)makeCellWithModel:(LoginUserDetaillist *)model andSex:(BOOL)isGirl;

@end
