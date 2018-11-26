//
//  Fcgo_AfterSalesServiceMoreVC.h
//  Fcgo
//
//  Created by fcg on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "XHSegmentViewController.h"

@interface Fcgo_AfterSalesServiceMoreVC : XHSegmentViewController

@property(nonatomic,strong)  UIViewController *backVC;

@property(nonatomic,copy)  void(^typeBlock)(int type);

@end
