//
//  Fcgo_MineDynamicHeadView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeadImageBlock)(UIButton *headImageBtn);

@interface Fcgo_MineDynamicHeadView : UIView


@property (nonatomic,copy)   HeadImageBlock headImageBlock;
@property (nonatomic,strong) UIButton    *headImageBtn;
@property (nonatomic,strong) NSDictionary   *userDict;

- (instancetype)initWithFrame:(CGRect)frame
                  ofHeadImage:(void(^)(UIButton *headImageBtn))headImageBlock;
@end
