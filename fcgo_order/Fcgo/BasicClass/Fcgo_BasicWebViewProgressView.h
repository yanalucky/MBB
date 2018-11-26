//
//  Fcgo_BasicWebViewProgressView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_BasicWebViewProgressView : UIView
//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

-(void)startLoadingAnimation;

-(void)endLoadingAnimation;

@end
