//
//  FeatureTableViewCell.h
//  BabyDemo
//
//  Created by 陈彦 on 16/5/24.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FeatureTableViewCell : UITableViewCell



@property(nonatomic , strong)UIButton *cellButton;

@property(nonatomic , assign)NSIndexPath *featurePath;

-(void)makeCellWithTitle:(NSString *)title andHaveImg:(BOOL)isHave andImg:(NSString *)image  withIsSel:(BOOL)isSel;

@end
