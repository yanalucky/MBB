//
//  ZKSegment.m
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

#import "ZKSegment.h"
#import "Masonry.h"
#import "Fcgo_SegmentBtn.h"

#define ZK_UIColorFromRGBAlpha(r, g, b, a) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:(a)]
#define ZK_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ZK_ItemPadding 8.0f
#define ZK_Version @"1.0.3"

@interface ZKSegment ()
@property(nonatomic, strong) UIView *buttonStyle;
@property(nonatomic, assign) CGFloat maxWidth;
@property(nonatomic, strong) NSMutableArray *buttonList;
@property(nonatomic, strong) NSMutableArray *allItems;
@property(nonatomic, weak)   Fcgo_SegmentBtn *buttonSelected;
@property(nonatomic, assign) ZKSegmentStyle segmentStyle;
@property(nonatomic, assign) CGFloat buttonStyleY;
@property(nonatomic, assign) CGFloat buttonStyleHeight;
@property(nonatomic, assign) BOOL buttonStyleMasksToBounds;
@property(nonatomic, assign) CGFloat buttonStyleCornerRadius;
@end

@implementation ZKSegment

+ (ZKSegment *)zk_segmentWithFrame:(CGRect)frame style:(ZKSegmentStyle)style {
    return [[ZKSegment alloc] zk_initWithFrame:frame style:style];
}

#pragma 初始化
- (id)init {
    if (self = [super init]) {
        self.segmentStyle = ZKSegmentLineStyle;
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)coder {
    if ([super initWithCoder:coder]) {
        self.segmentStyle = ZKSegmentLineStyle;
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ([super initWithFrame:frame]) {
        self.segmentStyle = ZKSegmentLineStyle;
        [self commonInit];
    }
    return self;
}

- (id)zk_initWithFrame:(CGRect)frame style:(ZKSegmentStyle)style {
    if ([super initWithFrame:frame]) {
        self.segmentStyle = *(&(style));
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    [self buttonStyleFromSegmentStyle];
    self.zk_itemFontSize = 14;
    self.zk_itemMargin = 0;
    self.zk_itemDefaultColor = ZK_UIColorFromRGBAlpha(250.0f, 250.0f, 250.0f, 1.0f);
    self.itemStyleSelectedColor = UIFontRedColor;
    switch (self.segmentStyle) {
        case ZKSegmentLineStyle:
            self.zk_itemSelectedColor = ZK_UIColorFromRGBAlpha(202.0f, 51.0f, 54.0f, 1.0f);
            break;
        case ZKSegmentRectangleStyle:
            self.zk_itemSelectedColor = ZK_UIColorFromRGBAlpha(250.0f, 250.0f, 250.0f, 1.0f);
            self.zk_itemMargin = 0;
        break;
        case ZKSegmentTextStyle:
            self.zk_itemSelectedColor = ZK_UIColorFromRGBAlpha(202.0f, 51.0f, 54.0f, 1.0f);
            break;
    }
    self.segmentBackgroundColor = UIRGBColor(34, 34, 34, 1);//ZK_UIColorFromRGBAlpha(.0f, .0f, .0f, 1.0f);
    self.maxWidth = self.zk_itemMargin;
    self.buttonList = [NSMutableArray array];
    self.allItems = [NSMutableArray array];
    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.buttonStyle = [[UIView alloc] initWithFrame:CGRectMake(self.zk_itemMargin, self.buttonStyleY, 0, self.buttonStyleHeight)];
    self.buttonStyle.backgroundColor = self.zk_itemStyleSelectedColor;
    self.buttonStyle.layer.masksToBounds = self.buttonStyleMasksToBounds;
    self.buttonStyle.layer.cornerRadius = self.buttonStyleCornerRadius;
    [self addSubview:self.buttonStyle];
}

- (void)setItemStyleSelectedColor:(UIColor *)itemStyleSelectedColor {
    _zk_itemStyleSelectedColor = itemStyleSelectedColor;
}

- (void)setSegmentBackgroundColor:(UIColor *)segmentBackgroundColor {
    _zk_backgroundColor = segmentBackgroundColor;
    self.backgroundColor = segmentBackgroundColor;
}

- (int)zk_selectedItemIndex {
    if (self.buttonSelected) {
        return [self indexOfItemsWithItem:self.buttonSelected.titleLabel.text];
    }
    return -1;
}

- (NSString *)zk_selectedItem {
    if (self.buttonSelected) {
        return self.buttonSelected.titleLabel.text;
    }
    return nil;
}

- (NSString *)zk_version {
    return ZK_Version;
}

#pragma 暴露给外部的
- (void)zk_setItems:(NSArray *)items {
    if (!items || items.count == 0) {
        return;
    }
    for (int i = 0; i < self.subviews.count; i++) {
        if (self.subviews[i] != self.buttonStyle) {
            [self.subviews[i--] removeFromSuperview];
        }
    }
    self.buttonStyle.hidden = NO;
    self.maxWidth = self.zk_itemMargin;
    [self.allItems removeAllObjects];
    [self.allItems addObjectsFromArray:items];
    self.buttonList = nil;
    self.buttonList = [[NSMutableArray alloc] init];
    self.buttonSelected = nil;
    if (self.allItems && self.allItems.count > 0) {
        self.backgroundColor = self.backgroundColor;
        for (int i = 0; i < self.allItems.count; i++) {
            [self createItem:self.allItems[i]];
        }
        self.contentSize = CGSizeMake(self.maxWidth, -4);
        [self fiexButtonWidth];
    }
}

- (NSArray *)zk_items {
    return self.allItems;
}

- (void)zk_itemClickByIndex:(NSInteger)index scroll:(BOOL)scroll
{
    if (index < 0) {
        return;
    }
    Fcgo_SegmentBtn *item = (Fcgo_SegmentBtn *)self.buttonList[index];
    [self itemClick:item isScroll:scroll];
}

//- (void)zk_itemClickByIndex:(NSInteger)index {
//   
//}

#pragma 私有的
- (void)buttonStyleFromSegmentStyle {
    switch (self.segmentStyle) {
        case ZKSegmentLineStyle:
            self.buttonStyleY = self.frame.size.height - 2;
            self.buttonStyleHeight = 2.0f;
            break;
        case ZKSegmentRectangleStyle:
            self.buttonStyleY = 0;
            self.buttonStyleHeight = self.frame.size.height ;
            self.buttonStyleCornerRadius = .0f;
            self.buttonStyleMasksToBounds = NO;
            break;
        case ZKSegmentTextStyle:
            self.buttonStyleY = 0;
            self.buttonStyleHeight = 0.0f;
            break;
    }
}

- (void)fiexButtonWidth {
    if (ZK_ScreenWidth - self.maxWidth > self.zk_itemMargin) {
        CGFloat bigButtonSumWidth = 0;
        int bigButtonCount = 0;
        self.maxWidth = self.zk_itemMargin;
        CGFloat width =
        (ZK_ScreenWidth - (self.buttonList.count + 1) * self.zk_itemMargin) / self.buttonList.count;
        for (int i = 0; i < self.buttonList.count; i++) {
            Fcgo_SegmentBtn *button = self.buttonList[i];
            if (button.frame.size.width > width) {
                bigButtonCount++;
                bigButtonSumWidth += button.frame.size.width;
            }
        }
        width = (ZK_ScreenWidth - (self.buttonList.count + 1) * self.zk_itemMargin - bigButtonSumWidth) / (self.buttonList.count - bigButtonCount);
        for (int i = 0; i < self.buttonList.count; i++) {
            Fcgo_SegmentBtn *button = self.buttonList[i];
            if (button.frame.size.width < width) {
                button.frame =
                CGRectMake(self.maxWidth, 0, width, self.frame.size.height);
                self.maxWidth += width + self.zk_itemMargin;
            } else {
                button.frame = CGRectMake(self.maxWidth, 0, button.frame.size.width, self.frame.size.height);
                self.maxWidth += button.frame.size.width + self.zk_itemMargin;
            }
            if (button == self.buttonSelected) {
                self.buttonStyle.frame = CGRectMake(button.frame.origin.x, self.buttonStyleY, button.frame.size.width, self.buttonStyleHeight);
            }
        }
        self.contentSize = CGSizeMake(self.maxWidth, -4);
    }
}

- (void)resetButtonsFrame {
    self.maxWidth = self.zk_itemMargin;
    
    for (int i = 0; i < self.allItems.count; i++) {
        CGFloat width = [self itemWidthFromSegmentStyle:self.allItems[i][1]];
        Fcgo_SegmentBtn *button = self.buttonList[i];
        button.frame = CGRectMake(self.maxWidth, 0, width, self.frame.size.height);
        if (button == self.buttonSelected) {
            self.buttonStyle.frame = CGRectMake(self.maxWidth, self.buttonStyleY, width, self.buttonStyleHeight);
        }
        if (!self.buttonSelected) {
            [button setTitleColor:self.zk_itemSelectedColor forState:0];
            [self itemClick:button];
        }
        self.maxWidth += width + self.zk_itemMargin;
    }
    
    self.contentSize = CGSizeMake(self.maxWidth, -4);
}

- (void)createItem:(NSArray *)item {
    CGFloat itemWidth = [self itemWidthFromSegmentStyle:item[1]];
    Fcgo_SegmentBtn *buttonItem = [[Fcgo_SegmentBtn alloc] initWithFrame:CGRectMake(self.maxWidth, 0, itemWidth, self.frame.size.height)];
    
    buttonItem.titleLabel.font = [UIFont systemFontOfSize:self.zk_itemFontSize];
    //[buttonItem setTitle:item forState:UIControlStateNormal];
    [buttonItem setTitleColor:self.zk_itemDefaultColor forState:UIControlStateNormal];
    [buttonItem addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *timeLabel = [[UILabel alloc]init];
  
    timeLabel.text = item[0];
    timeLabel.font = [UIFont systemFontOfSize:14];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.textColor = [UIColor whiteColor];
    [buttonItem addSubview:timeLabel];
    
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(buttonItem.mas_centerX);
        make.bottom.mas_equalTo(buttonItem.mas_centerY).mas_offset(-3);
        
    }];
    UILabel *statusLabel = [[UILabel alloc]init];
    statusLabel.text = item[1];
    statusLabel.font = [UIFont systemFontOfSize:13];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    statusLabel.textColor = [UIColor whiteColor];
    [buttonItem addSubview:statusLabel];
    [statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(buttonItem.mas_centerX);
        make.top.mas_equalTo(buttonItem.mas_centerY).mas_offset(2);
    }];
    
    
    buttonItem.timeLabel = timeLabel;
    buttonItem.statusLabel = statusLabel;
    
    self.maxWidth += itemWidth + self.zk_itemMargin;
    [self.buttonList addObject:buttonItem];
    [self addSubview:buttonItem];
    if (!self.buttonSelected) {
        [buttonItem setTitleColor:self.zk_itemSelectedColor forState:0];
        self.buttonStyle.frame = CGRectMake(buttonItem.frame.origin.x, self.buttonStyleY, buttonItem.frame.size.width, self.buttonStyleHeight);
        [self itemClick:buttonItem];
    }
}

- (CGFloat)itemWidthFromSegmentStyle:(NSString *)item {
    CGFloat itemWidth = [self textWidthWithFontSize:self.zk_itemFontSize Text:item];
    itemWidth = itemWidth + 20;
    CGFloat resultItemWidht;
    switch (self.segmentStyle) {
        case ZKSegmentLineStyle:
            resultItemWidht = itemWidth;
            break;
        case ZKSegmentRectangleStyle:
            resultItemWidht = itemWidth + ZK_ItemPadding * 2;
            break;
        case ZKSegmentTextStyle:
            resultItemWidht = itemWidth;
            break;
    }
    return resultItemWidht;
}


- (void)itemClick:(id)sender isScroll:(BOOL)scroll
{
    Fcgo_SegmentBtn *button = sender;
    if (self.buttonSelected != button) {
        [self.buttonSelected setTitleColor:self.zk_itemDefaultColor forState:0];
        [button setTitleColor:self.zk_itemSelectedColor forState:0];
        self.buttonSelected = button;
        
        if (!scroll) {
            if (self.zk_itemClickBlock) {
                int selectedIndex = [self indexOfItemsWithItem:button.timeLabel.text];
                NSString *selectedItem = button.timeLabel.text;
                self.zk_itemClickBlock(selectedItem, selectedIndex);
            }
        }
        
        [UIView animateWithDuration:0.3
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             self.buttonStyle.frame = CGRectMake(button.frame.origin.x, self.buttonStyleY, button.frame.size.width, self.buttonStyleHeight);
                         }
                         completion:^(BOOL finished) {
                             [UIView animateWithDuration:
                              0.3 animations:^{
                                  CGFloat buttonX = button.frame.origin.x;
                                  CGFloat buttonWidth = button.frame.size.width;
                                  CGFloat scrollerWidth = self.contentSize.width;
                                  // 移动到中间
                                  if (scrollerWidth > ZK_ScreenWidth && // Scroller的宽度大于屏幕宽度
                                      buttonX > ZK_ScreenWidth / 2.0f - buttonWidth / 2.0f && //按钮的坐标大于屏幕中间位置
                                      scrollerWidth > buttonX + ZK_ScreenWidth / 2.0f + buttonWidth / 2.0f // Scroller的宽度大于按钮移动到中间坐标加上屏幕一半宽度加上按钮一半宽度
                                      ) {
                                      self.contentOffset = CGPointMake(button.frame.origin.x - ZK_ScreenWidth / 2.0f + button.frame.size.width / 2.0f, 0);
                                  } else if (buttonX < ZK_ScreenWidth / 2.0f - buttonWidth / 2.0f) { // 移动到开始
                                      self.contentOffset = CGPointMake(0, 0);
                                  } else if (scrollerWidth - buttonX < ZK_ScreenWidth / 2.0f + buttonWidth / 2.0f || // Scroller的宽度减去按钮的坐标小于屏幕的一半，移动到最后
                                             buttonX + buttonWidth + self.zk_itemMargin == scrollerWidth) {
                                      if (scrollerWidth > ZK_ScreenWidth) {
                                          self.contentOffset = CGPointMake(scrollerWidth - ZK_ScreenWidth, 0); // 移动到末尾
                                      }
                                  }
                              }];
                         }];
    }

}

- (void)itemClick:(id)sender
{
    [self itemClick:sender isScroll:NO];
}

- (int)indexOfItemsWithItem:(NSString *)item {
    for (int i = 0; i < self.allItems.count; i++) {
        if ([item isEqualToString:self.allItems[i][0]]) {
            return i;
        }
    }
    return -1;
}

- (CGFloat)textWidthWithFontSize:(CGFloat)fontSize Text:(NSString *)text {
    NSDictionary *attr = @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize]};
    CGRect size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, self.frame.size.height)
                       options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                    attributes:attr
                       context:nil];
    return size.size.width;
}

@end
