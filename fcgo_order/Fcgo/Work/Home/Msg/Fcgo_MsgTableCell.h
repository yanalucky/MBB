//
//  Fcgo_MsgTableCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Fcgo_MsgTableCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *msgImageView;
@property (weak, nonatomic) IBOutlet UILabel     *msgTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel     *msgDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel     *msgDateLabel;
@end
