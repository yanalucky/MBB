//
//  Fcgo_MainScreeningVC.h
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_ScreeningVC.h"

@interface Fcgo_MainScreeningVC : UIViewController
@property (nonatomic, assign) id<Fcgo_ScreeningVCDelegate> delegate;
@property (nonatomic, assign) BOOL  isShow;
- (void)dismissWindow:(void(^)(void))block;
@end
