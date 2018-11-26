//
//  Fcgo_ContactServiceCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_ContactServiceCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;
@property (nonatomic,copy) NSString *titleString;
@end
