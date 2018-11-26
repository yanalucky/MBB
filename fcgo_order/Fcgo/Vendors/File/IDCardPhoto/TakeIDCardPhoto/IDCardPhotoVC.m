//
//  IDCardPhotoVC.m
//  IDCardAndPhotoDemo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "IDCardPhotoVC.h"
#import "IQEngUIBackGroundView.h"
#import "IQEngUIPhotoSessionView.h"
#import "PhotoView.h"

@interface IDCardPhotoVC ()

@property (nonatomic, strong) IQEngUIPhotoSessionView *sessionView;
@property (nonatomic, strong) UIButton    *takePhotoButton;
@property (nonatomic, strong) UIButton    *flashButton;
@property (nonatomic, strong) UIButton    *backButton;
@property (nonatomic, strong) UILabel     *descLabel;
@property (nonatomic, strong) UIImageView *scanBackGroundImageView;
@property (nonatomic, strong) IQEngUIBackGroundView *backGroundView;
@property (nonatomic, strong) PhotoView   *photoView;
@property (nonatomic, assign) CGRect       effectiveRect;//截取的尺寸

@end

@implementation IDCardPhotoVC

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.sessionView.devicePosition = AVCaptureDevicePositionBack;
    [self.sessionView startRunning];
    [self.view addSubview:self.sessionView];
    
    self.backGroundView = [[IQEngUIBackGroundView alloc] init];
    [self.view addSubview:self.backGroundView];
    
    self.takePhotoButton = [[UIButton alloc] init];
    self.takePhotoButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    self.takePhotoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.takePhotoButton setImage:[UIImage imageNamed_IQEngUICamera:@"shooting@2x.png"] forState:UIControlStateNormal];
    
    [self.takePhotoButton addTarget:self action:@selector(__takePhotoAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.takePhotoButton];
    
    self.backButton = [[UIButton alloc] init];
    self.backButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    self.backButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.backButton setImage:[UIImage imageNamed_IQEngUICamera:@"back@2x"] forState:UIControlStateNormal];
    [self.backButton addTarget:self action:@selector(__backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    
    self.flashButton = [[UIButton alloc] init];
    self.flashButton.imageEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
    self.flashButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.flashButton setImage:[UIImage imageNamed_IQEngUICamera:@"ico_flash_on@2x"] forState:UIControlStateNormal];
    [self.flashButton addTarget:self action:@selector(__flashButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.flashButton];
    
    self.scanBackGroundImageView = [[UIImageView alloc] init];
    
    if (self.isHeaderFace) {
        [self.scanBackGroundImageView setImage:[UIImage imageNamed_IQEngUICamera:@"shooting-area_pic@2x.png"]];
    }
    else
    {
        self.scanBackGroundImageView.image = [UIImage imageNamed_IQEngUICamera:@"shooting-area_national-emblem@2x"];
    }
    [self.view addSubview:self.scanBackGroundImageView];
    
    UILabel *descLabel = [[UILabel alloc]init];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.font = [UIFont systemFontOfSize:16];
    descLabel.textAlignment = NSTextAlignmentCenter;
    if (self.isHeaderFace)
    {
        descLabel.text = @"请将身份证头像位置对准头像线框";
    }
    else
    {
        descLabel.text = @"请将身份证国徽位置对准国徽线框";
    }
    [self.view addSubview:self.descLabel =  descLabel];
    [self.view addSubview:self.photoView];
    __weak __typeof(self)weakSelf = self;
    self.photoView.cancelBlock = ^{
        weakSelf.photoView.hidden = 1;
    };
    self.photoView.confirmBlock = ^(UIImage *image){
        weakSelf.photoView.hidden = 1;
        
        if (weakSelf.whenFinsh) {
            weakSelf.whenFinsh(image);
        }
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    };
}

- (void)__backButtonAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)__takePhotoAction
{
    //拍照
    [self.sessionView takePhoto];
}

- (void)__flashButtonAction:(UIButton *)btn
{
    if (btn.selected) {
        [self.sessionView openFlash];
        [self.flashButton setImage:[UIImage imageNamed_IQEngUICamera:@"ico_flash_on@2x"] forState:UIControlStateNormal];
    }
    else{
        [self.sessionView closeFlash];
        [self.flashButton setImage:[UIImage imageNamed_IQEngUICamera:@"ico_flash_off@2x"] forState:UIControlStateNormal];
    }
    btn.selected = !btn.selected;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    CGRect bounds = self.view.bounds;
    self.sessionView.frame = bounds;
    
    CGRect f1 = bounds;
    f1.size = CGSizeMake(65, 65);
    f1.origin.y = (bounds.size.height - f1.size.height)/2;
    f1.origin.x = bounds.size.width - f1.size.width - 10;
    self.takePhotoButton.layer.cornerRadius = f1.size.width/2.f;
    self.takePhotoButton.frame = f1;
    
    CGRect f2 = bounds;
    f2.size = CGSizeMake(45, 45);
    f2.origin = CGPointMake(5, 5);
    self.backButton.layer.cornerRadius = f2.size.width/2.f;
    self.backButton.frame = f2;
    
    CGRect f3_ = bounds;
    f3_.size = CGSizeMake(45, 45);
    f3_.origin = CGPointMake(10, bounds.size.height - 55);
    self.flashButton.layer.cornerRadius = f3_.size.width/2.f;
    self.flashButton.frame = f3_;
    
    CGRect f3 = bounds;
    f3.size.height = bounds.size.height - 70*2;
    CGSize f3_size = self.scanBackGroundImageView.image.size;
    f3.size.width = f3.size.height/f3_size.height*f3_size.width;
    f3.origin.x = (bounds.size.width - f3.size.width)/2;
    f3.origin.y = (bounds.size.height - f3.size.height)/2;
    self.scanBackGroundImageView.frame = f3;
    self.descLabel.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 70, [UIScreen mainScreen].bounds.size.width, 70);
    
    [self.sessionView setTransformThatFitDeviceOrientation:UIDeviceOrientationLandscapeRight animated:YES];
    self.backGroundView.frame = bounds;
    self.backGroundView.transparentFrame = f3;
    
    self.photoView.frame = CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    self.photoView.photoImg.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    float height = [UIScreen mainScreen].bounds.size.height - 70*2;
    self.photoView.photoImg.bounds = CGRectMake(0, 0, f3.size.width*height/f3.size.height, height);
    
    self.photoView.cancelBtn.frame = CGRectMake(15, [UIScreen mainScreen].bounds.size.height - 50, 50, 25);
    self.photoView.confirmBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 50 - 15, self.photoView.cancelBtn.frame.origin.y, self.photoView.cancelBtn.frame.size.width, self.photoView.cancelBtn.frame.size.height);
}

- (CGRect)effectiveRect
{
    return  self.scanBackGroundImageView.frame;
}

#pragma mark - lazy load
- (IQEngUIPhotoSessionView *)sessionView
{
    if (!_sessionView) {
        _sessionView = [[IQEngUIPhotoSessionView alloc] init];
        __weak typeof(self) wself = self;
        _sessionView.whenTakePhoto = ^(UIImage *photo){
            __weak typeof(self) self = wself;
            
            CGSize size = [UIScreen mainScreen].bounds.size;
            if (photo.size.width/size.width <= photo.size.height/size.height) {
                float scale = photo.size.width/size.width;
                //算出图片原始长度下的，等比例的高度
                float height =  scale* size.height;
                float height_left = (photo.size.height - height)/2;
                photo = [UIImage imageFromImage:photo inRect:CGRectMake(0, height_left, photo.size.width, photo.size.height - height_left)];
                photo = [UIImage imageFromImage:photo inRect:CGRectMake(0, 0, photo.size.width, photo.size.height - height_left)];
                
                CGRect rect = CGRectMake(self.effectiveRect.origin.x *scale , self.effectiveRect.origin.y * scale, self.effectiveRect.size.width *scale, self.effectiveRect.size.height * scale);
                photo = [UIImage imageFromImage:photo inRect:rect];
            }
            else
            {
                float scale = photo.size.height/size.height;
                //算出图片原始长度下的，等比例的高度
                float width =  scale* size.width;
                float width_left = (photo.size.width - width)/2;
                photo = [UIImage imageFromImage:photo inRect:CGRectMake(0, width_left, photo.size.height, photo.size.width - width_left)];
                photo = [UIImage imageFromImage:photo inRect:CGRectMake(0, 0, photo.size.height, photo.size.width - width_left)];
                CGRect rect = CGRectMake(self.effectiveRect.origin.x *scale , self.effectiveRect.origin.y * scale, self.effectiveRect.size.width *scale, self.effectiveRect.size.height * scale);
                photo = [UIImage imageFromImage:photo inRect:rect];
            }
            self.photoView.hidden = 0;
            self.photoView.backgroundColor = [UIColor blackColor];
            self.photoView.image = photo;
        };
    }
    return _sessionView;
}

- (PhotoView *)photoView
{
    if (!_photoView) {
        _photoView = [[PhotoView alloc]initWithFrame:CGRectZero];
        _photoView.hidden = 1;
    }
    return _photoView;
}

@end


