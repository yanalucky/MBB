//
//  Fcgo_QYIM_JumpTools.h
//  Fcgo
//
//  Created by shihaifeng on 2017/9/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *commodityInfoTitle = @"commodityInfoTitle";
static NSString *commodityInfoPic   = @"commodityInfoPic";
static NSString *commodityInfoDes   = @"commodityInfoDes";
static NSString *commodityInfoNote  = @"commodityInfoNote";

@interface Fcgo_QYIM_JumpTools : NSObject

+ (instancetype)sharedInstance;

/**
 跳转客户聊天界面

 @param title 来源标题
 @param urlString 来源url
 @param customInfo 来源信息
 @param sessionTitle 会话窗口标题
 */
- (void)qy_jumpWithTitle:(NSString *)title
               urlString:(NSString *)urlString
              customInfo:(NSString *)customInfo
            sessionTitle:(NSString *)sessionTitle
 commodityInfoDictionary:(NSDictionary *)dictionary;
@end
