//
//  Fcgo_afterSiftVC.h
//  Fcgo
//
//  Created by fcg on 2017/12/7.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_ScreeningVC.h"
#import "Fcgo_afterSiftDetailVC.h"
@interface Fcgo_afterSiftVC : UIViewController
@property (nonatomic, assign) id<Fcgo_afterSiftDetailVCDelegate> delegate;
@property (nonatomic, assign) BOOL  isShow;
@property (nonatomic, assign) int   type;
- (void)dismissWindow:(void(^)(void))block;
@end
