//
//  Fcgo_CollectVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_CollectVC : Fcgo_BasicVC

@property (nonatomic,copy) void(^cancelBlock)(NSString *goodsId,BOOL isAllCancel);

@end
