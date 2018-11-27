//
//  YLZYTableViewCell.h
//  MBB1
//
//  Created by 陈彦 on 15/9/14.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YLZYTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIV;
@property (weak, nonatomic) IBOutlet UIImageView *bgHeadIV;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *hospital;
@property (weak, nonatomic) IBOutlet UILabel *doctor;

@end
