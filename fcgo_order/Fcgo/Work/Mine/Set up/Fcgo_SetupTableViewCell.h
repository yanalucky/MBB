//
//  Fcgo_SetupTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SetupTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *titleString;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicatorView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;

- (void)startActivityIndicatorView;

- (void)stopActivityIndicatorView;

@end
