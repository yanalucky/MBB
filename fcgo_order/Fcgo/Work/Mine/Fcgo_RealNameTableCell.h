//
//  Fcgo_RealNameTableCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_RealNameModel.h"
@interface Fcgo_RealNameTableCell : UITableViewCell

@property (nonatomic,strong)Fcgo_RealNameModel *model;
@property (weak, nonatomic) IBOutlet Fcgo_IndexButton    *defultBtn;
@property (nonatomic,copy) void(^defaultBlock)(Fcgo_RealNameModel *model);
@property (nonatomic,copy) void(^editBlock)(Fcgo_RealNameModel *model);
@property (nonatomic,copy) void(^deleteBlock)(Fcgo_RealNameModel *model);


@end