//
//  Fcgo_MineCellNew.h
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_MineCellModel.h"

@interface Fcgo_MineCellNew : UITableViewCell
@property (nonatomic, strong) Fcgo_MineCellModel *model;
@property (nonatomic, copy) TouchType touchType;
@end
