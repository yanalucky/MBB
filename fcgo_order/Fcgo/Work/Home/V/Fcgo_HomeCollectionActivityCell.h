//
//  Fcgo_HomeCollectionActivityCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_HomeCollectionActivityCell : UICollectionViewCell

@property (nonatomic,strong) NSMutableArray *promoteMutableArray;
//type1 是促销 2是团购
@property (nonatomic,copy)void(^didTouchBlock)(NSDictionary *dict);

@end
