//
//  Fcgo_SheetAnimationView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DidSelectedBlock)(NSInteger index);

@interface Fcgo_SheetAnimationView : UIControl

@property (nonatomic,copy)   DidSelectedBlock didSelectedBlock;

+ (void)showWithArray:(NSArray *)titleArray DidSelectedBlock:(DidSelectedBlock)didSelectedBlock;

@end
