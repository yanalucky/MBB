//
//  Fcgo_AuthCodeView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_AuthCodeView : UIView

@property (strong, nonatomic) NSArray         *dataArray;//字符素材数组
@property (strong, nonatomic) NSMutableString *authCodeStr;//验证码字符串

- (void)getAuthCode;

@end
