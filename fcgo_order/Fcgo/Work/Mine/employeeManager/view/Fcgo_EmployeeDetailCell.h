//
//  Fcgo_EmployeeDetailCell.h
//  Fcgo
//
//  Created by by_r on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_EmployeeDetailCell : UITableViewCell
@property (nonatomic, copy) VoidBlock touchHeader;
@end

@interface Fcgo_EmployeeTxtInfoCell : UITableViewCell
- (void)setDetailColor:(UIColor *)color tip:(NSString *)tip detail:(NSString *)detail edited:(BOOL)edited placeholder:(NSString *)placeholder arrow:(BOOL)hidden;
@end
