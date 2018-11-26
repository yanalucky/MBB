//
//  Fcgo_ServiceDetailSection0Row1Cell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AfterSalesService_DetailModel.h"
@interface Fcgo_ServiceDetailSection0Row1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic,strong) Fcgo_AfterSalesService_DetailModel *detailModel;
@end
