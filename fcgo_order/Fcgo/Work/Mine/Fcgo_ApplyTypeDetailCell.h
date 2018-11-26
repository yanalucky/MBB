//
//  Fcgo_ApplyTypeDetailCell.h
//  Fcgo
//
//  Created by fcg on 2017/11/30.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_ApplyTypeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *titleDetail;
@property (weak, nonatomic) IBOutlet UIImageView *leftImg;
@property (weak, nonatomic) IBOutlet UILabel *line;
-(void)makeCell:(NSDictionary *)dic isLast:(BOOL)islast isRed:(BOOL)isRed;

@end
