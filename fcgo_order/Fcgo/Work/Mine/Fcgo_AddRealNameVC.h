//
//  Fcgo_AddRealNameVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_RealNameModel.h"

@protocol AddOrEditRealNameDelegate <NSObject>

- (void)finishAddOrEditRealName;

@end

@interface Fcgo_AddRealNameVC : Fcgo_BasicVC

@property (nonatomic,strong)Fcgo_RealNameModel *model;
@property (assign, nonatomic) id<AddOrEditRealNameDelegate> delegate;

@end
