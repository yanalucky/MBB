//
//  Fcgo_TimeCountDownView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_WholePointModel.h"

@interface Fcgo_TimeCountDownView : UIView

@property (nonatomic,strong) Fcgo_WholePointModel *model;
@property (nonatomic,assign) WholePointType type;
@property (nonatomic,copy) void(^timeFinishBlock)(void);

@end
