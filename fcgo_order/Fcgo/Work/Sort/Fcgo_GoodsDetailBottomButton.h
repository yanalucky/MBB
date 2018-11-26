//
//  Fcgo_GoodsDetailBottomButton.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEECoolButton.h"

@interface Fcgo_GoodsDetailBottomButton : UIButton


@property (nonatomic,assign) BOOL select;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel     *iconTitleLabel,*iconCountLabel;
@property (nonatomic,strong) LEECoolButton *heartButton;

- (void)setupUI;

@end
