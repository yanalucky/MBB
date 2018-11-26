//
//  Fcgo_MarketButton.h
//  Fcgo
//
//  Created by huafanxiao on 2017/8/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_MarketButton : UIButton

@property (nonatomic,strong) UILabel *topLabel,*bottomLabel;

- (void)setupUI;

@end
