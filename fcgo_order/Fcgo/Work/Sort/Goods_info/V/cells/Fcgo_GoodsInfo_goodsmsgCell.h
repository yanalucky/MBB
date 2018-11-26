//
//  Fcgo_GoodsInfo_goodsmsgCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_GoodsInfoMsgModel.h"
#import "Fcgo_GoodsSkuModel.h"

@interface Fcgo_GoodsInfo_goodsmsgCell : UITableViewCell

@property (nonatomic,strong) Fcgo_GoodsInfoMsgModel *infoModel;
@property (nonatomic,strong) Fcgo_GoodsSkuModel *skuModel;

@end
