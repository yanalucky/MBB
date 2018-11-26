//
//  Fcgo_RegistBackImageCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_RegistBackImageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (nonatomic,copy) void(^imageBlock)(NSArray *imageArray);

@end
