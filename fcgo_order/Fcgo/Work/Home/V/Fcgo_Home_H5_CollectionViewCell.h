//
//  Fcgo_Home_H5_CollectionViewCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/8/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_Home_H5_CollectionViewCell : UICollectionViewCell

@property (nonatomic,copy)   NSString *urlString;

@property (nonatomic,copy) void(^returnHeightBlock)(CGFloat height);
@property (nonatomic,assign) CGFloat height;
@end
