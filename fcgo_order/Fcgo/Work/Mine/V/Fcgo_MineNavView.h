//
//  Fcgo_MineNavView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HeadImageBlock)(UIButton *headImageBtn);
typedef void(^SetBlock)(void);
typedef void(^MsgBlock)(void);

@interface Fcgo_MineNavView : UIView

@property (nonatomic,assign) float          bgAlpha;

@property (nonatomic,copy)   HeadImageBlock headImageBlock;
@property (nonatomic,copy)   SetBlock       setBlock;
@property (nonatomic,copy)   MsgBlock       msgBlock;

@property (nonatomic,strong) UIButton       *headImageBtn;

- (instancetype)initWithFrame:(CGRect)frame
                  ofHeadImage:(void(^)(UIButton *headImageBtn))headImageBlock
                        ofSet:(void(^)(void))setBlock
                        ofMsg:(void(^)(void))msgBlock;
@end
