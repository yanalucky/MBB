//
//  Fcgo_AddNewAdressVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"

@protocol AddOrEditAdressDelegate <NSObject>

- (void)addOrEditAdressWithModel:(Fcgo_AddressModel *)model;

@end


@interface Fcgo_AddNewAdressVC : Fcgo_BasicVC

@property (strong, nonatomic) Fcgo_AddressModel *model;
@property (assign, nonatomic) id<AddOrEditAdressDelegate> delegate;
@property (copy,   nonatomic) void(^reloadBlock)(void);

@end
