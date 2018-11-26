//
//  XLImageViewerTooBar.m
//  XLImageViewerDemo
//
//  Created by MengXianLiang on 2017/4/20.
//  Copyright © 2017年 Apple. All rights reserved.
//

#import "XLImageViewerTooBar.h"

@implementation XLImageViewerTooBar{
    
    UILabel *_pageLabel;
    
    UIButton *_saveButton;
    
    VoidBlock _saveBlock;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

-(void)buildUI{
    //显示分页的label
    CGFloat viewWidth = 60.0f;
    CGFloat viewHeignt = 25.0f;
    CGFloat viewMargin = 5.0f;
    _pageLabel = [[UILabel alloc] initWithFrame:CGRectMake(viewMargin, 0, viewWidth, viewHeignt)];
    _pageLabel.center = CGPointMake(_pageLabel.center.x, viewHeignt/2.0f);
    _pageLabel.backgroundColor = [UIColor colorWithRed:253/255.0 green:142/255.0 blue:36/255.0 alpha:1];
    _pageLabel.layer.cornerRadius = 2.0f;
    _pageLabel.layer.masksToBounds = true;
    _pageLabel.textColor = [UIColor whiteColor];
    _pageLabel.font = [UIFont systemFontOfSize:14];
    _pageLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_pageLabel];
    
    //保存按钮
    _saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    _saveButton.frame = CGRectMake(self.bounds.size.width - viewWidth - viewMargin, 0, viewWidth, viewHeignt);
    _saveButton.center = CGPointMake(_saveButton.center.x, viewHeignt/2.0f);
    _saveButton.layer.cornerRadius = 2.0f;
    _saveButton.layer.masksToBounds = true;
    _saveButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_saveButton setBackgroundColor:[UIColor colorWithRed:253/255.0 green:142/255.0 blue:36/255.0 alpha:1]];
    [_saveButton addTarget:self action:@selector(saveImageMethod) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveButton];

    self.alpha = 0;
}

-(void)saveImageMethod{
    _saveBlock();
}

-(void)addSaveBlock:(VoidBlock)saveBlock{
    _saveBlock = saveBlock;
}

-(void)setText:(NSString *)text{
    _pageLabel.text = text;
}

-(void)show{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 1;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.35 animations:^{
        self.alpha = 0;
    }];
}

@end
