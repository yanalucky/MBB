//
//  Fcgo_OrderListNavView.h
//  Fcgo
//
//  Created by by_r on 2017/10/24.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderListNavView : UIView
@property (nonatomic, copy) VoidBlock   searchBlock;
@property (nonatomic, copy) VoidBlock   siftBlock;
- (void)setTitleString:(NSString *)title;
@end
