//
//  UIView+Line.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/13.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UIView+Line.h"

@implementation UIView (Line)


#pragma mark - 添加辅助线  (实线)
-(void)addLineWithY:(CGFloat)height{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = MBColor(252, 236, 246, 1);
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(1));
        make.width.equalTo(self);
        make.left.equalTo(self);
        make.top.equalTo(self).offset(height*Ratio);
    }];
}

#pragma mark - 添加辅助线  (虚线)

-(void)addShadeLayerFrom:(CGFloat)begin andTo:(CGFloat)end{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:self.bounds];
    [shapeLayer setPosition:self.center];
    [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
    // 设置虚线颜色为blackColor
    //    [shapeLayer setStrokeColor:[[UIColor blackColor] CGColor]];
    [shapeLayer setStrokeColor:[MBColor(254, 214, 233, 1) CGColor]];
    // 3.0f设置虚线的宽度
    [shapeLayer setLineWidth:1.0f];
    [shapeLayer setLineJoin:kCALineJoinRound];
    // 3=线的宽度 1=每条线的间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:3],[NSNumber numberWithInt:1],nil]];
    
    [[self layer] addSublayer:shapeLayer];
    
    // Setup the path   CGMutablePathRef path = CGPathCreateMutable();
    
    CGMutablePathRef path = CGPathCreateMutable();
    // 0,10代表初始坐标的 x，y
    // 320,10代表初始坐标的x，y
    CGPathMoveToPoint(path, NULL, begin, -10);
    CGPathAddLineToPoint(path, NULL, end,-10);
    
    // Setup the path
    [shapeLayer setPath:path];
    CGPathRelease(path);
}


@end
