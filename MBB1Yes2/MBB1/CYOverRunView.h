//
//  CYOverRunView.h
//  MBB1
//
//  Created by 陈彦 on 15/11/26.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CYOverRunView : UIView

@property (strong , nonatomic) void(^clickBlocks)(void);


@property (assign , nonatomic) BOOL sex;

@end
