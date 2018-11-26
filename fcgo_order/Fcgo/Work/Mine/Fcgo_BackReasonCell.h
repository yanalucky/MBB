//
//  Fcgo_BackReasonCell.h
//  Fcgo
//
//  Created by fcg on 2017/10/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_BackReasonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UIButton *selBtn;

-(void)makeCellWithTitle:(NSString *)title isSel:(BOOL)isSel;

@end
