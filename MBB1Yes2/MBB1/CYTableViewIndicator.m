//
//  CYTableViewIndicator.m
//  MBB1
//
//  Created by 陈彦 on 15/11/11.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import "CYTableViewIndicator.h"

@implementation CYTableViewIndicator{
    UIImageView *imageSView;
}


-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
//    UIImage *imageS = [[UIImage alloc] initWithContentsOfFile:pathS];
//    imageSView = [[UIImageView alloc] initWithImage:imageS];
//    imageSView.frame = CGRectMake(190,0,2,200*[arr count]);
//    [leftScroll addSubview:imageSView];
//    
//    // 添加 图标
//    pathS = [[NSBundle mainBundle] pathForResource:@"gg" ofType:@"png"];
//    imageS = [[UIImage alloc] initWithContentsOfFile:pathS];
//    imageGView = [[UIImageView alloc] initWithImage:imageS];
//    imageGView.frame = CGRectMake(186,10,10,27);
//    [self addSubview:imageGView];

    return self;
}


// 当移动调用此方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float p = 0;
    p = scrollView.contentOffset.y/(scrollView.contentSize.height - scrollView.frame.size.height);
//    imageGView.frame = CGRectMake(186,p*scrollView.contentSize.height,10, 27);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
