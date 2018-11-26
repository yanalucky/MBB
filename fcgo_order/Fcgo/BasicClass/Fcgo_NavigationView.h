//
//  Fcgo_NavigationView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BackBlock)(void);

@interface Fcgo_NavigationView : UIView

@property (nonatomic,strong) UIImageView   *alphaImageView;
@property (nonatomic,assign) BOOL      isShowWhiteTitle;//导航条上的空间为白色
@property (nonatomic,assign) BOOL      isShowLine;//是否展示导航条下面的分界线
@property (nonatomic,strong) UIColor   *lineColor;
@property (nonatomic,strong) UIButton  *navRightTitleBtn;


@property (nonatomic,assign) CGFloat   bgAlpha;//导航条的透明度变化
@property (nonatomic,copy)   NSString  *title;
@property (nonatomic,copy)   BackBlock backBlock;
@property (nonatomic,copy)   void(^moreBlock)(void);
@property (nonatomic,copy)   void(^rightBlock)(void);

- (void)setupTitleLabelWithTitle:(NSString *)title;
- (void)setupTitleBoldFontLabelWithTitle:(NSString *)title;

- (void)setupBackBtnBlock:(BackBlock)backBlock;
- (void)setupMoreBtnBlock:(void(^)(void))moreBlock;

- (void)setupRightBtnBlock:(void(^)(void))rightBlock;

- (void)setupBackTitle:(NSString *)string;

- (void)setupRightBtnTitle:(NSString *)rightTitle Block:(void(^)(void))rightBlock;

@end
