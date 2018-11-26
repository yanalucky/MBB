//
//  Fcgo_PublicNumberVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_PublicNumberVC.h"

@interface Fcgo_PublicNumberVC ()

@end

@implementation Fcgo_PublicNumberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    self.navigationView.bgAlpha = 0;
    self.navigationView.isShowWhiteTitle = 1;
    [self.navigationView setupTitleLabelWithTitle:@"公众号"];
    
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    NSString *imageString;
    if (IPHONE4)
    {
        imageString = @"bg_public_i4";
    }else if (IPHONE5)
    {
        imageString = @"bg_public_i5";
    }else if (IPHONE6)
    {
        imageString = @"bg_public_i6";
    }else if (IPHONE6P)
    {
        imageString = @"bg_public_i6p";
    }
    bgImageView.image = [UIImage imageNamed:imageString];
    bgImageView.userInteractionEnabled = 1;
    [self.view insertSubview:bgImageView belowSubview:self.navigationView];
    
    
    UIView *shadowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    shadowView.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
    [self.view insertSubview:shadowView belowSubview:self.navigationView];
    
    
    UIImageView *publicImageView = [[UIImageView alloc]init];
    publicImageView.center = CGPointMake(kScreenWidth/2, KScreenHeight/2-kAutoWidth6(20));
    publicImageView.bounds = CGRectMake(0, 0, kAutoWidth6(200), kAutoWidth6(200));
    publicImageView.userInteractionEnabled = 1;
    //publicImageView.backgroundColor = [UIColor redColor];
    publicImageView.image = [UIImage imageNamed:@"ddh code"];
    [self.view addSubview:publicImageView];
    
    UILabel *bigLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, publicImageView.mj_h+publicImageView.mj_y+10, kScreenWidth, 30)];
    bigLabel.font = [UIFont boldSystemFontOfSize:17];
    bigLabel.text = @"扫描二维码关注";
    bigLabel.textColor = UIFontWhiteColor;
    bigLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bigLabel];
    
    UILabel *midleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, bigLabel.mj_h+bigLabel.mj_y+7, kScreenWidth, 20)];
    midleLabel.font = [UIFont systemFontOfSize:14];
    midleLabel.text = @"微信公众平台账号";
    midleLabel.textColor = UIFontWhiteColor;
    midleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:midleLabel];
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, midleLabel.mj_h+midleLabel.mj_y+7, kScreenWidth, 20)];
    bottomLabel.font = [UIFont systemFontOfSize:14];
    bottomLabel.text = @"ddh —— news";
    bottomLabel.textColor = UIFontWhiteColor;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:bottomLabel];
    
    UILongPressGestureRecognizer *longTap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTapClick:)];
    [self.view addGestureRecognizer:longTap];
}

-(void)longTapClick:(UILongPressGestureRecognizer *)gesture {
    if(gesture.state == UIGestureRecognizerStateBegan) {
        [Fcgo_SheetAnimationView showWithArray:@[@"保存到手机"] DidSelectedBlock:^(NSInteger index) {
            UIImageWriteToSavedPhotosAlbum([UIImage imageNamed:@"ddh code"], self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }];
    }
}
#pragma mark --- UIActionSheetDelegate---

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [WSProgressHUD showSuccessWithStatus:@"成功保存到相册"];
    }else{
        [WSProgressHUD showImage:nil status:[error description]] ;
    }
}

@end
