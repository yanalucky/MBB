//
//  Fcgo_MineHeadViewNew.h
//  Fcgo
//
//  Created by by_r on 2017/10/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_MineImageTextButton.h"

@interface Fcgo_MineHeadViewNew : UIView
@property (nonatomic, copy) TouchType touchType;
@property (nonatomic, strong) UIButton      *headImageBtn;
@property (nonatomic, strong) Fcgo_MineImageTextButton  *waitPayButton;
@property (nonatomic, strong) Fcgo_MineImageTextButton  *dealButton;
@property (nonatomic, strong) Fcgo_MineImageTextButton  *recivedButton;
@property (nonatomic, strong) Fcgo_MineImageTextButton  *afterSaleButton;
@property (nonatomic, strong) Fcgo_MineImageTextButton  *myOrderButton;

@property (nonatomic, retain) NSDictionary *userDict;
@end
