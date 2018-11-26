//
//  Fcgo_BasicWebView.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^LoadStartBlock)(void);
typedef void(^LoadSuccessBlock)(void);
typedef void(^LoadFailBlock)(void);
typedef void(^HomeDetailBlock)(NSString *urlString);

@interface Fcgo_BasicWebView : UIWebView<UIWebViewDelegate>

@property (nonatomic,strong) NSString          *urlString; //url地址

@property (nonatomic,copy) LoadStartBlock   startBlock;
@property (nonatomic,copy) LoadSuccessBlock successBlock;
@property (nonatomic,copy) LoadFailBlock    failBlock;
@property (nonatomic,copy) HomeDetailBlock    homeDetailBlock;
@property (nonatomic,copy) void(^returnHeightBlock)(CGFloat height);

- (instancetype)initWithFrame:(CGRect)frame
                      ofStart:(LoadStartBlock )startBlock
                    ofSuccess:(LoadSuccessBlock )successBlock
                       ofFail:(LoadFailBlock )failBlock;



- (instancetype)initWithFrame:(CGRect)frame
                      ofStart:(LoadStartBlock )startBlock
                    ofSuccess:(LoadSuccessBlock )successBlock
                       ofFail:(LoadFailBlock )failBlock
              ofWebViewHeight:(void(^)(CGFloat height))returnHeightBlock;

@end
