//
//  DrawImageView.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/28.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "DrawImageView.h"

@implementation DrawImageView
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
    CGContextRef context = UIGraphicsGetCurrentContext();

    //1.首先创建一个画笔
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 1;
    
    UIColor *lineColor;
    lineColor = [UIColor purpleColor];
    [lineColor set];
//    NSLog(@"_xDataArr = %@",_xDataArr);
    //4.把画笔移动到要开始画图的位置
    if (_xDataArr.count!=0) {
        [path moveToPoint:CGPointMake([_xDataArr[0] floatValue], [_yDataArr[0] floatValue])];
        if (_xDataArr.count == 1) {
//            [path addLineToPoint:CGPointMake([_xDataArr[0] floatValue]+1, [_yDataArr[0] floatValue]+1)];
            CGContextAddArc(context, [_xDataArr[0] floatValue], [_yDataArr[0] floatValue], 0.6, 0, 2*M_PI, 0);//添加一个圆
            CGContextDrawPath(context, kCGPathFill);//绘制填充


            
        }else{
            for (int i=1; i<[_xDataArr count]; i++) {
                
                [path addLineToPoint:CGPointMake([_xDataArr[i] floatValue], [_yDataArr[i] floatValue])];
//                CGContextAddArc(context, 150, 30, 30, 0, 2*M_PI, 0);
                CGContextAddArc(context, [_xDataArr[i] floatValue], [_yDataArr[i] floatValue], 0.6, 0, 2*M_PI, 0);//添加一个圆
                CGContextDrawPath(context, kCGPathFill);//绘制填充


            }
        }
        
        [path stroke];
    }
    
    ;
    //5.画线(50, 100) --> (100, 200)
    
    [path stroke];
    
    //通过贝塞尔曲线画上去的东西，会在再次调用drawRect:这个方法时消失，而通过addSubview:添加在当前视图上的控件不会消失
    
    
}



@end
