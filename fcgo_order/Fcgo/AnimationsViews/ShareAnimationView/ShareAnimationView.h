//
//  ShareAnimationView.h
//  Fcg
//
//  Created by huafanxiao on 2017/4/24.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ShareWeiXinType,//微信好友
    ShareWeiXinTimeLineType,//微信朋友圈
    ShareScanType,//扫描二维码
    ShareCopyLinkType,//辅助链接
    
} ShareType;

@interface ShareAnimationView : UIView

@property (nonatomic,copy) void(^shareBlock)(ShareType shareType);

- (void)show;//显示

- (void)dismiss;//消失

- (void)dismissWithComplation:(void(^)(void))block;


@end
