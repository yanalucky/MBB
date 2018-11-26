//
//  Fcgo_OrderConfirmRealNameTableCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_RealNameModel.h"

@interface Fcgo_OrderConfirmRealNameTableCell : UITableViewCell

@property (nonatomic,strong)Fcgo_RealNameModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@end
