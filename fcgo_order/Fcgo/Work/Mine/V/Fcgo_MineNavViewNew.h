//
//  Fcgo_MineNavViewNew.h
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_MineNavViewNew : UIView
@property (nonatomic,assign) float          bgAlpha;
@property (nonatomic, copy) TouchType touchType;
- (void)setTitleString:(NSString *)title;
@end
