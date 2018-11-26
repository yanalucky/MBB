//
//  IQEngUIPhotoSessionView.m
//  自定义相机
//
//  Created by 力王 on 16/11/28.
//  Copyright © 2016年 Herson. All rights reserved.
//

#import "IQEngUIPhotoSessionView.h"
#import "UIImage+IQEngUICamera.h"
@interface IQEngUIPhotoSessionView ()
@property(nonatomic, strong) AVCapturePhotoOutput *photoOutput;
@property (nonatomic,strong) AVCaptureStillImageOutput *photoOutput_old;
@end

@implementation IQEngUIPhotoSessionView

-(instancetype)init{
    if (self = [super init]) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return self;//判断是否支持相机
        
        if ([self.session canAddOutput:self.photoOutput]) {
            [self.session addOutput:self.photoOutput];
        }
        if (IOS10_Early) {
            if ([self.session canAddOutput:self.photoOutput_old]) {
                [self.session addOutput:self.photoOutput_old];
            }
        }else{
            if ([self.session canAddOutput:self.photoOutput]) {
                [self.session addOutput:self.photoOutput];
            }
        }
    }
    return self;
}

-(void)takePhoto
{
    AVCaptureConnection *conntion;
    if (IOS10_Early) {
        conntion = [self.photoOutput_old connectionWithMediaType:AVMediaTypeVideo];
    }else{
        conntion = [self.photoOutput connectionWithMediaType:AVMediaTypeVideo];
    }
    if (!conntion) return;
    if (IOS10_Early) {
        [self.photoOutput_old captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            if(imageDataSampleBuffer != NULL){
                NSData *data = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                [self getImageWithData:data];
            }
        }];
        
    }else{
        AVCapturePhotoSettings *photoSettings = [AVCapturePhotoSettings photoSettings];
        photoSettings.flashMode = self.flashMode;
        [self.photoOutput capturePhotoWithSettings:photoSettings delegate:self];
    }
}

- (void)openFlash
{
    [self.session beginConfiguration];
    [self.device lockForConfiguration:nil];
    if(self.device.torchMode == AVCaptureTorchModeOn)
    {
        [self.device setTorchMode:AVCaptureTorchModeOff];
        [self.device setFlashMode:AVCaptureFlashModeOff];
    }
    [self.device unlockForConfiguration];
    [self.session commitConfiguration];
}

- (void)closeFlash
{
    if ([self.device hasTorch] && [self.device hasFlash])
    {
        if(self.device.torchMode == AVCaptureTorchModeOff)
        {
            [self.session beginConfiguration];
            [self.device lockForConfiguration:nil];
            [self.device setTorchMode:AVCaptureTorchModeOn];
            [self.device setFlashMode:AVCaptureFlashModeOn];
            [self.device unlockForConfiguration];
            [self.session commitConfiguration];
        }
    }
}


#pragma mark - AVCapturePhotoCaptureDelegate
//成功拍照回调sessionPreset
-(void)captureOutput:(AVCapturePhotoOutput *)captureOutput didFinishProcessingPhotoSampleBuffer:(nullable CMSampleBufferRef)photoSampleBuffer previewPhotoSampleBuffer:(nullable CMSampleBufferRef)previewPhotoSampleBuffer resolvedSettings:(AVCaptureResolvedPhotoSettings *)resolvedSettings bracketSettings:(nullable AVCaptureBracketedStillImageSettings *)bracketSettings error:(nullable NSError *)error{
    NSData *data =  [AVCapturePhotoOutput JPEGPhotoDataRepresentationForJPEGSampleBuffer:photoSampleBuffer previewPhotoSampleBuffer:previewPhotoSampleBuffer];
    [self getImageWithData:data];
}

- (void)getImageWithData:(NSData *)data
{
    UIImage *photo = [UIImage imageWithData:data];
    photo = [UIImage imageWithCGImage:photo.CGImage scale:1 orientation:UIImageOrientationUp];
    UIImageWriteToSavedPhotosAlbum(photo, self, nil, NULL);
    if (self.whenTakePhoto) {
        self.whenTakePhoto(photo);
    }
}
#pragma mark - lazy load
-(AVCapturePhotoOutput *)photoOutput{
    if (!_photoOutput) {
        _photoOutput = [[AVCapturePhotoOutput alloc] init];
    }
    return _photoOutput;
}

-(AVCaptureStillImageOutput*)photoOutput_old
{
    if (!_photoOutput_old) {
        _photoOutput_old = [[AVCaptureStillImageOutput alloc] init];
    }
    return _photoOutput_old;
}

-(AVCaptureOutput *)output{
    if (IOS10_Early) {
    return self.photoOutput_old;
    }
    return self.photoOutput;
}
@end
