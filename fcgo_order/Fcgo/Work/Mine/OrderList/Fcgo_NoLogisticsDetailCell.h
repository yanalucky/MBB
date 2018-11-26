//
//  Fcgo_NoLogisticsDetailCell.h
//  Fcgo
//
//  Created by by_r on 2017/9/30.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString *const tipLogisticsStr = @"暂未查到物流信息，请长按运单编号复制号码，然后移步至官网查询";

@interface Fcgo_NoLogisticsDetailCell : UITableViewCell
@property (nonatomic, copy) NSString    *expressUrl;
- (void)setName:(NSString *)name url:(NSString *)url;
+ (CGFloat)getHeightWithText:(NSString *)string;
@end
