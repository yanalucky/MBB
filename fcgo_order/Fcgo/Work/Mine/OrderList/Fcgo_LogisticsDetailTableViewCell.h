//
//  Fcgo_LogisticsDetailTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_LogisticsDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *logisticsDeatilLabel;
@property (weak, nonatomic) IBOutlet UILabel *logisticsTimeLabel;
@property (weak, nonatomic) IBOutlet UIView  *lineView;
@property (weak, nonatomic) IBOutlet UIImageView *logisticsImagView;


- (void)updateFrameWithIndex:(NSInteger)index;


@end
