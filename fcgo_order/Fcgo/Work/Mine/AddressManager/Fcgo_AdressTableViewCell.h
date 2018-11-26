//
//  Fcgo_AdressTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AddressModel.h"


@interface Fcgo_AdressTableViewCell : UITableViewCell


@property (strong, nonatomic) Fcgo_AddressModel *model;
@property (weak, nonatomic) IBOutlet Fcgo_IndexButton    *defultBtn;
@property (nonatomic,copy) void(^defaultBlock)(Fcgo_AddressModel *model);
@property (nonatomic,copy) void(^editBlock)(Fcgo_AddressModel *model);
@property (nonatomic,copy) void(^deleteBlock)(Fcgo_AddressModel *model);

@end
