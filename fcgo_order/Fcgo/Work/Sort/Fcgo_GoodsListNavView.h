//
//  Fcgo_GoodsListNavView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_GoodsListNavView : UIView

@property (nonatomic,strong) UILabel     *textLabel;

@property (nonatomic,copy)void(^backBlock)(void);
@property (nonatomic,copy)void(^changeListBlock)(BOOL selected);

@property (nonatomic,copy)void(^searchBlock)(NSString *string);

- (instancetype)initWithFrame:(CGRect)frame
                         back:(void(^)())backBlock
                   changeList:(void(^)(BOOL selected))changeListBlock
                       search:(void(^)(NSString *string))searchBlock;
@end
