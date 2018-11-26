//
//  Fcgo_SortLeftTableView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fcgo_SortModel.h"

@interface Fcgo_SortLeftTableView : UIView

@property (nonatomic,strong) NSMutableArray *sortArray;
@property (nonatomic,copy)   void(^didSelectedBlock)(Fcgo_SortModel *model);

@end
