//
//  Fcgo_OrderConfirmSection2Row1Cell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_OrderConfirmSection2Row1Cell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel     *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

@property (assign, nonatomic) BOOL isShowArrowImage;


@end
