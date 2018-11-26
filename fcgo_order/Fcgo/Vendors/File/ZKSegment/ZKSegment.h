//
//  ZKSegment.h
//  ZKSegment
//
//  Created by WangWenzhuang on 15/10/20.
//  Copyright © 2015年 WangWenzhuang. All rights reserved.
//

/*
 *******************************************************
 *                                                      *
 * 感谢您的支持，如果下载的代码在使用过程中出现 Bug 或者其他问题  *
 * 您可以发邮件到1020304029@qq.com 或者到                     *
 * https://github.com/WangWenzhuang/ZKSegment 提交问题     *
 *                                                      *
 *******************************************************
 */

#import <UIKit/UIKit.h>

/**
 *  样式
 */
typedef enum {
    /**
     *  线条样式
     */
    ZKSegmentLineStyle = 0,
    /**
     *  矩形样式
     */
    ZKSegmentRectangleStyle = 1,
    /**
     *  文字样式
     */
    ZKSegmentTextStyle = 2,
    /**
     *  图文样式
     */
//    ZKSegmentImageAndTextStyle = 3
} ZKSegmentStyle;

@interface ZKSegment : UIScrollView
/**
 *  每一项颜色
 *
 *  默认 [r:102.0f,g:102.0f,b:102.0f]
 */
@property(nonatomic, strong) UIColor *zk_itemDefaultColor;
/**
 *  选中项颜色
 *
 *  ZKSegmentLineStyle 默认 [r:202.0, g:51.0, b:54.0]
 *  ZKSegmentRectangleStyle 默认[r:250.0, g:250.0, b:250.0]
 *  ZKSegmentTextStyle 默认 [r:202.0, g:51.0, b:54.0]
 */
@property(nonatomic, strong) UIColor *zk_itemSelectedColor;
/**
 *  选中项样式颜色
 *
 *  默认 [r:202.0, g:51.0, b:54.0]
 */
@property(nonatomic, strong) UIColor *zk_itemStyleSelectedColor;
/**
 *  背景色
 *
 *  默认 [r:238.0, g:238.0, b:238.0]
 */
@property(nonatomic, strong) UIColor *zk_backgroundColor;
/**
 *  每一项字体大小
 *
 *  默认 14
 */
@property(nonatomic, assign) CGFloat zk_itemFontSize;
/**
 *  每一项间距
 *
 *  默认 20
 */
@property(nonatomic, assign) CGFloat zk_itemMargin;
/**
 *  项切换 Block
 */
@property(nonatomic, copy) void (^zk_itemClickBlock) (NSString *itemName, NSInteger itemIndex);
/**
 *  获取当前选中项索引
 */
@property(nonatomic, readonly, getter=zk_selectedItemIndex) int zk_selectedItemIndex;
/**
 *  获取当前选中项
 */
@property(nonatomic, strong, readonly, getter=zk_selectedItem) NSString *zk_selectedItem;
/**
 *  版本号
 */
@property(nonatomic, strong, readonly) NSString *zk_version;
/**
 *  工厂方法，创建不同样式的选择器
 */
+ (ZKSegment *)zk_segmentWithFrame:(CGRect)frame style:(ZKSegmentStyle)style;
/**
 *  初始化
 */
- (id)zk_initWithFrame:(CGRect)frame style:(ZKSegmentStyle)style;
/**
 *  设置项目集合
 */
- (void)zk_setItems:(NSArray *)items;
/**
 *  获取项目集合
 */
- (NSArray *)zk_items;
/**
 *  根据索引触发单击事件
 */
//- (void)zk_itemClickByIndex:(NSInteger)index;

- (void)zk_itemClickByIndex:(NSInteger)index scroll:(BOOL)scroll;

@end
