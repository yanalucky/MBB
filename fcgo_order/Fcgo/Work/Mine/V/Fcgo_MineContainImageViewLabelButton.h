//
//  Fcgo_MineContainImageViewLabelButton.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_MineContainImageViewLabelButton : UIButton

@property (nonatomic,strong) UIImageView *btnImageView;
@property (nonatomic,strong) UILabel     *btnLabel;
@property (nonatomic,strong) UILabel     *iconCountLabel;

- (void)setupUI;
- (void)setCountValue:(NSInteger)value;
@end
