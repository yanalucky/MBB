//
//  Fcgo_HomeNavSearchControl.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SearchBlock)(void);

@interface Fcgo_HomeNavSearchControl : UIControl

@property (nonatomic,copy) SearchBlock searchBlock;
@property (nonatomic,assign) float bgAlpha;

- (void)setupUI;

@end
