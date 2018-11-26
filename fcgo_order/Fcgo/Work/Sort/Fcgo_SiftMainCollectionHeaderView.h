//
//  Fcgo_SiftMainCollectionHeaderView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_SiftMainCollectionHeaderView : UICollectionReusableView

@property (strong, nonatomic) UILabel     *titleLabel;
@property (strong, nonatomic) UIImageView *arrowImageView;
@property (strong, nonatomic) UILabel     *descriptionLabel;
@property (strong, nonatomic) Fcgo_IndexButton   *showBtn;

@end
