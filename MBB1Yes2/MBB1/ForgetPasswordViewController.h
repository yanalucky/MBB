//
//  ForgetPasswordViewController.h
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgetPasswordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *mailBox;
- (IBAction)sendMessage:(id)sender;

@end