//
//  Fcgo_RefreshNormalHeader.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/31.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RefreshNormalHeader.h"



@implementation Fcgo_RefreshNormalHeader

+ (Fcgo_RefreshNormalHeader *)headerRefreshBlock:(void(^)(void))block
{
    Fcgo_RefreshNormalHeader *header = [Fcgo_RefreshNormalHeader  headerWithRefreshingBlock:^{
        block();
    }];
    header.arrowView.alpha = 0;
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = 0;
    //header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    //[header setTitle:@"" forState:1];
    //[header setTitle:@"" forState:2];
    [header setTitle:@"" forState:3];
    return header;
}

@end
