//
//  Fcgo_SheetAnimationViewTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SheetAnimationViewTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *titleString;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end
