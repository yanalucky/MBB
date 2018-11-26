//
//  PhotoView.m
//  IDCardAndPhotoDemo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "PhotoView.h"
@interface PhotoView()



@end

@implementation PhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self addSubview:self.photoImg];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.confirmBtn];
    }
    return self;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.photoImg.image = image;
}

- (void)cancel
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)confirm
{
    if (self.confirmBlock) {
        self.confirmBlock(self.image);
    }
}

- (UIImageView *)photoImg
{
    if (!_photoImg) {
        UIImageView *bottomImg = [[UIImageView alloc]init];
        bottomImg.image = [UIImage imageNamed:@"bottom_update"];
        _photoImg = bottomImg;
    }
    return _photoImg;
}

- (UIButton  *)cancelBtn
{
    if (!_cancelBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"重拍" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn = btn;
        
    }
    return _cancelBtn;
}

- (UIButton  *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.titleLabel.font = [UIFont systemFontOfSize:16];
        [btn setTitle:@"使用" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}

@end
