//
//  Fcgo_ServiceDetailSection2Row0Cell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_AfterSalesService_DetailModel.h"
@interface Fcgo_ServiceDetailSection2Row0Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *whiteView;
@property (weak, nonatomic) IBOutlet UIScrollView *goodsImageScrollView;//存放不定量的图片
@property (nonatomic,strong) Fcgo_AfterSalesService_DetailModel *detailModel;
@end
