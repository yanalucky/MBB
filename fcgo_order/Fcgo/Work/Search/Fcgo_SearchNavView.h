//
//  Fcgo_SearchNavView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SearchNavView : UIView

@property (nonatomic,strong) UITextField *searchTextField;
@property (nonatomic,copy)void(^cancelBlock)(void);
@property (nonatomic,copy)void(^startBlock)(BOOL containText,NSString *string);
@property (nonatomic,copy)void(^searchBlock)(NSString *string);

- (instancetype)initWithFrame:(CGRect)frame
                       cancel:(void(^)())cancelBlock
                        start:(void(^)(BOOL containText,NSString *string))startBlock
                       search:(void(^)(NSString *string))searchBlock;
@end
