//
//  Fcgo_RegistMianImageCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_RegistMianImageCell : UITableViewCell

@property (nonatomic,copy) void(^imageBlock)(NSArray *imageArray);

@end
