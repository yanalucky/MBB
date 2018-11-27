//
//  PictureDetailTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/5/20.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureDetailTableViewCell : UITableViewCell


@property (nonatomic , assign) BOOL isForth;

-(void)makeCellWithDate:(NSString *)date andBabyAge:(NSString *)age andData:(NSString *)data;

@end
