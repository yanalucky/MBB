//
//  PhotoView.h
//  IDCardAndPhotoDemo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoView : UIView

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,copy) void(^confirmBlock)(UIImage *image);
@property (nonatomic,copy) void(^cancelBlock)(void);

@property (nonatomic,strong) UIImageView  *photoImg;
@property (nonatomic,strong) UIButton     *confirmBtn;
@property (nonatomic,strong) UIButton     *cancelBtn;

-(instancetype)initWithFrame:(CGRect)frame;

@end


