//
//  Fcgo_backDetailView.h
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_ApplyHistoryDetailModel.h"

@interface Fcgo_backDetailView : UIView
@property (weak, nonatomic) IBOutlet UIView *view0;
@property (weak, nonatomic) IBOutlet UIScrollView *mainSC;

@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIImageView *view0LeftView;
@property (weak, nonatomic) IBOutlet UILabel *view0Title;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *view3Title;
@property (weak, nonatomic) IBOutlet UIImageView *view3GoodImg;
@property (weak, nonatomic) IBOutlet UILabel *view3Line;
@property (weak, nonatomic) IBOutlet UILabel *view3GoodTitle;
@property (weak, nonatomic) IBOutlet UILabel *view3GoodAttr;

@property (weak, nonatomic) IBOutlet UIButton *View3AgainBtn;
@property (weak, nonatomic) IBOutlet UILabel *view4OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *view4OrderNumDetail;
@property (weak, nonatomic) IBOutlet UILabel *view4PayTime;
@property (weak, nonatomic) IBOutlet UILabel *view4PayTimeDetail;
@property (weak, nonatomic) IBOutlet UILabel *view4BackMoney;
@property (weak, nonatomic) IBOutlet UILabel *view4BackMoneyDetail;
@property (weak, nonatomic) IBOutlet UILabel *view4Address;
@property (weak, nonatomic) IBOutlet UILabel *view4AddressDetail;
@property (weak, nonatomic) IBOutlet UILabel *view4backReason;
@property (weak, nonatomic) IBOutlet UILabel *view4backReasonDetail;
@property (strong,nonatomic)Fcgo_ApplyHistoryDetailModel *model;
@property (strong,nonatomic)NSNumber *status;
@property(nonatomic,strong) NSString *orderAftersaleNo;
@property(nonatomic,strong) NSString *afterType;
@property(nonatomic,strong) NSString *goodImg;
@end













