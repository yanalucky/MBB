//
//  Fcgo_GoodsListVC.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_GoodsListVC : Fcgo_BasicVC

//对外接受参数，作为第一次加载的参数
@property (nonatomic,copy) NSString *goodsIds;
@property (nonatomic,copy) NSString *cateIds;
@property (nonatomic,copy) NSString *catemIds;
@property (nonatomic,copy) NSString *brandIds;
@property (nonatomic,copy) NSString *texe;
@property (nonatomic,assign)int      page;
@property (nonatomic,copy) NSString *row;
@property (nonatomic,copy) NSString *orderby;
@property (nonatomic,copy) NSString *asc;
@property (nonatomic,copy) NSString *words;
@property (nonatomic,copy) NSString *key;
@property (nonatomic,copy) NSString *attrs;

@end
