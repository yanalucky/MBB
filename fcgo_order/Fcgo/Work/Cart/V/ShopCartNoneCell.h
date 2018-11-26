//
//  ShopCartNoneCell.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCartNoneCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *noneImg;
@property (weak, nonatomic) IBOutlet UILabel *noneLabel;
@property (weak, nonatomic) IBOutlet UIButton *none_goBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (nonatomic,copy)void(^goToVisit)();

@end
