//
//  Fcgo_BackDetailCell.h
//  Fcgo
//
//  Created by fcg on 2017/10/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPNumberButton.h"

@interface Fcgo_BackDetailCell : UITableViewCell<PPNumberButtonDelegate>
@property (nonatomic,strong) PPNumberButton *numberButton;
@property (nonatomic,strong)UILabel *titleLab;


@property (nonatomic,copy) void(^countBlock)(Fcgo_BackDetailCell *cell,NSString *number);


-(void)makeCellWithTitle:(NSString *)title andNum:(NSInteger)num isBackNum:(BOOL)isBack;

@end
