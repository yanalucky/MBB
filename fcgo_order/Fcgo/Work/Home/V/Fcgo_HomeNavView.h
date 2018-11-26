//
//  Fcgo_HomeNavView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/11.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanBlock)(void);
typedef void(^SearchBlock)(void);
typedef void(^MsgBlock)(void);

@interface Fcgo_HomeNavView : UIView

@property (nonatomic,assign) float       bgAlpha;

@property (nonatomic,copy)   ScanBlock   scanBlock;
@property (nonatomic,copy)   SearchBlock searchBlock;
@property (nonatomic,copy)   MsgBlock    msgBlock;

- (instancetype)initWithFrame:(CGRect)frame
                       ofScan:(void(^)(void))scanBlock
                     ofSearch:(void(^)(void))searchBlock
                        ofMsg:(void(^)(void))msgBlock;
@end
