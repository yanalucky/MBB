//
//  Fcgo_GoodsInfoBottomButton.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/25.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEECoolButton.h"

@interface Fcgo_GoodsInfoBottomButton : UIButton

@property (nonatomic,assign) BOOL select;
@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel     *iconTitleLabel,*iconCountLabel;
@property (nonatomic,strong) LEECoolButton *heartButton;

@end
