//
//  Fcgo_GoodsListTypeView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_GoodsListTypeView : UIView

@property (nonatomic,copy) void (^rateBlock)(void);
@property (nonatomic,copy) void (^saleBlock)(NSInteger type);//0是从低到高 1是从高到低
@property (nonatomic,copy) void (^priceBlock)(NSInteger type);//0是从低到高 1是从高到低
@property (nonatomic,copy) void (^siftBlock)(void);


- (instancetype)initWithFrame:(CGRect)frame
                         rate:(void (^)(void))rateBlock
                         sale:(void (^)(NSInteger type))saleBlock
                        price:(void (^)(NSInteger type))priceBlock
                         sift:(void (^)(void))siftBlock;
@end
