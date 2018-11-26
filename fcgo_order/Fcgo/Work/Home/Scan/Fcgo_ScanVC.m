//
//  Fcgo_ScanVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/12.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ScanVC.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define TOP (KScreenHeight - 250)/2
#define LEFT (kScreenWidth - 250)/2
#define kScanRect CGRectMake(LEFT, TOP, 250, 250)

@interface Fcgo_ScanVC ()<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
    CAShapeLayer *cropLayer;
    CGFloat _currentLight;
}
@property (strong,nonatomic) AVCaptureDevice            *device;
@property (strong,nonatomic) AVCaptureDeviceInput       *input;
@property (strong,nonatomic) AVCaptureMetadataOutput    *output;
@property (strong,nonatomic) AVCaptureSession           *session;
@property (strong,nonatomic) AVCaptureVideoPreviewLayer *preview;
@property (strong,nonatomic) UIImageView                *line;
@property (strong,nonatomic) UILabel                    *flashlightLabel;
@end

@implementation Fcgo_ScanVC

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.2];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    _currentLight = [[UIScreen mainScreen] brightness];
    [[UIScreen mainScreen] setBrightness: 0.7];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_preview removeFromSuperlayer];
    _line.alpha = 1;
    _preview = nil;
    [timer invalidate];
    timer = nil;
    [[UIScreen mainScreen] setBrightness: _currentLight];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIFontBlackColor;
    [self setupUI];
}

- (void)setupUI;
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"扫一扫"];
    self.navigationView.bgAlpha = 0;
    self.navigationView.isShowLine = 0;
    self.navigationView.isShowWhiteTitle = YES;
    [self setCropRect:kScanRect];
    [self configView];
}

- (void)configView
{
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:kScanRect];
    imageView.image = [UIImage imageNamed:@"scan_border"];
    [self.view addSubview:imageView];
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(LEFT, TOP+10, 250, 2)];
    _line.image = [UIImage imageNamed:@"scan_line"];
    _line.alpha = 0;
    [self.view insertSubview:_line belowSubview:self.navigationView];
    
    UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(0, TOP-80, kScreenWidth, 20)];
    title.font = [UIFont systemFontOfSize:16];
    title.textColor =  UIFontWhiteColor;
    title.text = @"请将 二维码/条形码 放入框内";
    title.textAlignment = NSTextAlignmentCenter;
    [self.view insertSubview:title belowSubview:self.navigationView];
    
    Fcgo_IndexButton * btn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundImage:[UIImage imageNamed:@"ico_flash_i6"] forState:UIControlStateNormal];
    btn.center = CGPointMake(kScreenWidth/2, KScreenHeight - 80);
    btn.bounds = CGRectMake(0, 0, 35, 35);
    [btn addTarget:self action:@selector(openFlash:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UILabel *flashlightLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.mj_h+btn.mj_y + 10, kScreenWidth, 20)];
    flashlightLabel.font = [UIFont systemFontOfSize:14];
    flashlightLabel.textColor =  UIFontWhiteColor;
    flashlightLabel.text = @"打开闪光灯";
    flashlightLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.flashlightLabel = flashlightLabel];
    
}

- (void)animation1
{
    _line.alpha = 1;
    num ++;
    _line.frame = CGRectMake(LEFT, TOP+10+2*num, 250, 2);
    if (2*num == 240) {
        num = 0;
        _line.frame = CGRectMake(LEFT, TOP+10, 250, 2);
    }
}

- (void)setCropRect:(CGRect)cropRect
{
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);
    
    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.4];
    
    [cropLayer setNeedsDisplay];
    
    [self.view.layer insertSublayer:cropLayer below:self.navigationView.layer];
    //[self.view.layer addSublayer:cropLayer];
}

- (void)setupCamera
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        //[self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    //设置扫描区域
    CGFloat top    = TOP/KScreenHeight;
    CGFloat left   = LEFT/kScreenWidth;
    CGFloat width  = 250/kScreenWidth;
    CGFloat height = 250/KScreenHeight;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
     [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    if (!_preview) {
        _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
        _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _preview.frame =self.view.layer.bounds;
        [self.view.layer insertSublayer:_preview atIndex:0];
    }
    
    // Start
    [_session startRunning];
    
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:.03 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
        //[[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    }
}

#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        
        
        //NSLog(@"========%@",stringValue);
        //停止扫描
        [_session stopRunning];
        [timer setFireDate:[NSDate distantFuture]];
        if ([stringValue containsString:@"app_across"]) {
            //停止扫描
            [_session stopRunning];
            [timer setFireDate:[NSDate distantFuture]];
            [self jumpToScanResultVCWithString:stringValue];
        }else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫描结果" message:stringValue preferredStyle:UIAlertControllerStyleAlert];
            [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (_session != nil && timer != nil) {
                    [_session startRunning];
                    [timer setFireDate:[NSDate date]];
                }
            }]];
            [self presentViewController:alert animated:YES completion:nil];
        }
    } else {
        
        return;
    }
}

- (void)jumpToScanResultVCWithString:(NSString *)string
{
    [_preview removeFromSuperlayer];
    _preview = nil;
    
    if ([string isEqualToString:@""]) {
        return;
    }
   [Fcgo_App_acrossTools app_acrossWithJsonString:string webView:nil parentVC:self];
}

- (void)dealloc
{
    [timer invalidate];
    timer = nil;
}

- (void)openFlash:(Fcgo_IndexButton *)btn
{
    if (!btn.select) {
        if([self.device hasTorch] && [self.device hasFlash])
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
             [btn setBackgroundImage:[UIImage imageNamed:@"ico_flash_close_i6"] forState:UIControlStateNormal];
            self.flashlightLabel.text = @"关闭闪光灯";
        }
        //[self.session startRunning];
        
    } else {
        
        [self.session beginConfiguration];
        [self.device lockForConfiguration:nil];
        if(self.device.torchMode == AVCaptureTorchModeOn)
        {
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        [btn setBackgroundImage:[UIImage imageNamed:@"ico_flash_i6"] forState:UIControlStateNormal];
        self.flashlightLabel.text = @"打开闪光灯";
        [self.device unlockForConfiguration];
        [self.session commitConfiguration];
        //[self.session stopRunning];
    }
    btn.select = !btn.select;
}

@end
