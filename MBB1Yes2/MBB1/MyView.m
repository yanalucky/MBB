//
//  MyView.m
//  5绘图
//
//  Created by Cecilia on 14-12-11.
//  Copyright (c) 2014年 Cecilia. All rights reserved.
//

#import "MyView.h"
#import "AppDelegate.h"
@implementation MyView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 

- (void)drawRect:(CGRect)rect
{
    //1.首先创建一个画笔
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 2;
   
    AppDelegate *delegete = [UIApplication sharedApplication].delegate;
    UIColor *lineColor;
    if (delegete.sex == 0) {
        lineColor = GIRL_WORDCOLOR;
    }else{
        lineColor = BOY_WORDCOLOR;
    }
    
    [lineColor set];
    //4.把画笔移动到要开始画图的位置
    if (_xDataArr.count!=0) {
        [path moveToPoint:CGPointMake([_xDataArr[0] floatValue], [_yDataArr[0] floatValue])];
        for (int i=1; i<[_xDataArr count]; i++) {
            if (([_xDataArr[i] floatValue] == 0)||([_yDataArr[i] floatValue] == 0)) {
                continue;
            }
            [path addLineToPoint:CGPointMake([_xDataArr[i] floatValue], [_yDataArr[i] floatValue])];
        }
        [path stroke];
    }
    
    ;
    //5.画线(50, 100) --> (100, 200)
   
    [path stroke];
    
    //通过贝塞尔曲线画上去的东西，会在再次调用drawRect:这个方法时消失，而通过addSubview:添加在当前视图上的控件不会消失
   
    
}

@end




