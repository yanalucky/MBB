//
//  Fcgo_AddRealNameImageTableCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_RealNameModel.h"
@interface Fcgo_AddRealNameImageTableCell : UITableViewCell

@property (nonatomic,copy) void(^imageBlock)(UIImage *mainImage,UIImage *backImage);

@property (nonatomic,copy) VoidBlock resignBlock;

@property (nonatomic,strong)Fcgo_RealNameModel *model;
@end
