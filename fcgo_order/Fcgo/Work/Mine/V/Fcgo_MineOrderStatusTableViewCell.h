//
//  Fcgo_MineOrderStatusTableViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_MineContainImageViewLabelButton.h"

typedef void(^WaitPayBlock)(void);
typedef void(^DealBlock)(void);
typedef void(^ReceivedBlock)(void);
typedef void(^AfterSaleBlock)(void);

@interface Fcgo_MineOrderStatusTableViewCell : UITableViewCell


@property (weak, nonatomic) IBOutlet Fcgo_MineContainImageViewLabelButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet Fcgo_MineContainImageViewLabelButton *dealBtn;
@property (weak, nonatomic) IBOutlet Fcgo_MineContainImageViewLabelButton *receivedBtn;
@property (weak, nonatomic) IBOutlet Fcgo_MineContainImageViewLabelButton *afterSaleBtn;

@property (nonatomic,copy) WaitPayBlock   waitPayBlock;
@property (nonatomic,copy) DealBlock      dealBlock;
@property (nonatomic,copy) ReceivedBlock  receivedBlock;
@property (nonatomic,copy) AfterSaleBlock afterSaleBlock;

- (void)cellMethodsBlockWithWaitPayBlock:(WaitPayBlock)waitPayBlock
                             ofDealBlock:(DealBlock)dealBlock
                         ofReceivedBlock:(ReceivedBlock)receivedBlock
                        ofAfterSaleBlock:(AfterSaleBlock)afterSaleBlock;


@end
