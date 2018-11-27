//
//  HeadViewController.h
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
@interface HeadViewController : FatherViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,ASIHTTPRequestDelegate>
@property (strong , nonatomic) UIView *right0;
@property (strong , nonatomic) UIView *right1;
@property (strong , nonatomic) UIView *right2;
@property (strong , nonatomic) UIView *right3;
@property (strong , nonatomic) UIView *right4;
@property (strong , nonatomic) UIImageView *headerV;
@property (strong ,nonatomic) UIView *bgView;

@property (strong , nonatomic) NSMutableArray *baobaoDataArr;
@property (strong , nonatomic) NSMutableArray *parentsDataArr;
@property (strong , nonatomic) NSMutableArray *babysitterDataArr;
@property (strong , nonatomic) NSMutableArray *buyServeDataArr;

@property (strong , nonatomic) UIButton *right1ChangeBtn;
@end
