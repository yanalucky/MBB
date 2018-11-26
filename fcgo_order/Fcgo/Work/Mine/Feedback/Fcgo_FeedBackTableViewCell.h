//
//  Fcgo_FeedBackTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_FeedBackTableViewCell : UITableViewCell

@property (nonatomic,copy)   void(^feedBackBlock)(Fcgo_IndexButton *btn);
@property (nonatomic,copy)   NSString *titleString;
@property (nonatomic,assign) BOOL checked;

@end
