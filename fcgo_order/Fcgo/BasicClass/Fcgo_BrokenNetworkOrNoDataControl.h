//
//  Fcgo_BrokenNetworkOrNoDataControl.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/5.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_BrokenNetworkOrNoDataControl : UIControl

@property (nonatomic,copy)void(^reloadBlock)();//点击重新加载的control
@property (nonatomic,copy) NSString *titleString,*imageString;

- (instancetype)initWithFrame:(CGRect)frame;

@end
