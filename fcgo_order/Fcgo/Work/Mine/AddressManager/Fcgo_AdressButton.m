//
//  Fcgo_AdressButton.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/26.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AdressButton.h"

@implementation Fcgo_AdressButton

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat titleY = self.titleLabel.frame.origin.y;
    CGFloat titleH = self.titleLabel.frame.size.height;
    CGFloat titleW = self.titleLabel.frame.size.width;
    
    CGFloat imageY = self.imageView.frame.origin.y;
    CGFloat imageW = self.imageView.frame.size.width;
    CGFloat imageH = self.imageView.frame.size.height;
    
    CGFloat width = self.frame.size.width;
    
    self.imageView.frame = CGRectMake((width - (titleW + imageW + 5)) / 2  , imageY, imageW, imageH);
    
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + 5, titleY, titleW, titleH);
}


@end
