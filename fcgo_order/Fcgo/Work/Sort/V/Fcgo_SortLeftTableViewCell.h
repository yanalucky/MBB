
//
//  Fcgo_SortLeftTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SortLeftTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *leftLineView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic,copy ) NSString *titleString;
@property (nonatomic,assign) BOOL isSelected;

@end
