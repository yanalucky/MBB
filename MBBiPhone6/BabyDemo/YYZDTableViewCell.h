//
//  YYZDTableViewCell.h
//  MBB1
//
//  Created by 陈彦 on 15/11/17.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYZDTableViewCell : UITableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UILabel *detail;
@property (strong, nonatomic) UIImageView *imageV;


-(void)makeCellWithTitle:(NSString *)title andDetailTitle:(NSString *)detailTitle andImageURL:(NSURL *)imageURL;

@end
