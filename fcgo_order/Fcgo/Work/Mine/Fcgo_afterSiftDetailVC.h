//
//  Fcgo_afterSiftDetailVC.h
//  Fcgo
//
//  Created by fcg on 2017/12/7.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol Fcgo_afterSiftDetailVCDelegate <NSObject>
//确定代理
- (void)determineButtonTouchEvent:(NSDictionary *)dictionary;

@end
@interface Fcgo_afterSiftDetailVC : UIViewController
@property (assign, nonatomic) CGFloat width;
@property (assign, nonatomic) id<Fcgo_afterSiftDetailVCDelegate> delegate;
@property (nonatomic, strong) NSMutableArray    *listArray;
@property (nonatomic, assign) int type;

- (void)resetButtonAction;
@end
