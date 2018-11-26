//
//  Fcgo_ContainImageViewLabelButton.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_ContainImageViewLabelButton : UIButton

@property (nonatomic,strong) UIImageView *btnImageView;
@property (nonatomic,strong) UILabel     *btnLabel;

- (void)setupUI;

@end
