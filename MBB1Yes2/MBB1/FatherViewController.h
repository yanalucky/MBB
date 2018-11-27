//
//  FatherViewController.h
//  MBB1
//
//  Created by 陈彦 on 15/9/21.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITextField+CYAccessoryViewTextField.h"
@class ServerConfigBaseClass;
@interface FatherViewController : UIViewController<UITextFieldDelegate>

@property (strong , nonatomic) UIColor *wordColor;
@property (strong ,nonatomic) UIColor *bgColor;
@property (assign , nonatomic) BOOL sex;

@end
