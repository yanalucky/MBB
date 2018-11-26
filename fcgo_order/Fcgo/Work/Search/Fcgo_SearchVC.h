//
//  Fcgo_SearchVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SearchVC : Fcgo_BasicVC

@property (nonatomic,assign) BOOL isnopush;
@property (nonatomic,copy) void(^searchBlock)(NSString *string);

@end
