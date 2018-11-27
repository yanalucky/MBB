//
//  YLZYViewController.h
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RightView;
@interface YLZYViewController : FatherViewController{
    UITableView *_tableView;
    UIColor *wordColor;
    UIColor *bgColor;
}
@property (strong , nonatomic) UITableView *tableView;
@property (strong , nonatomic) NSMutableArray *doctorDataArr;
@property (strong , nonatomic) NSMutableArray *hospicalDataArr;




@property (strong , nonatomic) RightView *right0;
@end
