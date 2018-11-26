//
//  Fcgo_TopAnimationView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedBlock)(NSInteger index);

@interface Fcgo_TopAnimationView : UIControl

@property (nonatomic,copy)   DidSelectedBlock didSelectedBlock;

+ (void)showWithVC:(UIViewController *)vc  titleArray:(NSArray *)titleArray currentSelected:(NSInteger)index DidSelectedBlock:(DidSelectedBlock)didSelectedBlock;

+ (instancetype)sharedClient;
- (void)dismissBlock:(void(^)(void))block;

@end
