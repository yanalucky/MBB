//
//  Fcgo_SafeCodeTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SafeCodeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView      *lineView;
@property (weak, nonatomic) IBOutlet UIButton    *codeBtn;

@property (nonatomic,copy) void(^sendBlock)(UIButton *btn);

@end
