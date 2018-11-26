//
//  Fcgo_SiftMainCollectionCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ItemSelectedOnType,    //选中
    ItemSelectedNotType,   //不可选
    ItemSelectedNormalType,//未选中
} ItemSelectedType;

@interface Fcgo_SiftMainCollectionCell : UICollectionViewCell
@property (weak, nonatomic)  IBOutlet UILabel *titleLabel;
@property (nonatomic,assign) BOOL select;
@property (nonatomic) id object;

@property (nonatomic,assign) ItemSelectedType type;

@end
