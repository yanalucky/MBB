//
//  Fcgo_OrderPaySuccessCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderPaySuccessCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *successImg;
@property (weak, nonatomic) IBOutlet UILabel *successLabel;
@property (weak, nonatomic) IBOutlet UIButton *success_goBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomview;

@property (nonatomic,copy)void(^goToVisit)(void);
@end
