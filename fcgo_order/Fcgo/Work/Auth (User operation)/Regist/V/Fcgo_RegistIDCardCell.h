//
//  Fcgo_RegistIDCardCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_RealNameModel.h"
@interface Fcgo_RegistIDCardCell : UITableViewCell

@property (nonatomic,copy) void(^imageBlock)(UIImage *mainImage,UIImage *backImage);
@property (nonatomic,strong)Fcgo_RealNameModel *model;

@end
