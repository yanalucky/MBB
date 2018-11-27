//
//  AddOtherTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/4/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddOtherTableViewCell : UITableViewCell

@property (nonatomic , strong) UITextField *field0;

@property (nonatomic , strong) UITextField *field1;

@property (nonatomic , assign) NSIndexPath *indexPath;

-(void)makeCellByMonth:(NSString *)monthStr;

@end
