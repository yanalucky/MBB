//
//  Fcgo_RegistIDCardCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RegistIDCardCell.h"

@interface Fcgo_RegistIDCardCell ()<HXPhotoViewControllerDelegate,ALiImageReshapeDelegate>

@property (strong, nonatomic) HXPhotoManager     *manager1;
@property (strong, nonatomic) HXPhotoManager     *manager0;
@property (weak, nonatomic) IBOutlet UILabel     *cardLabel;
@property (weak, nonatomic) IBOutlet UIButton    *mainCardBtn;
@property (weak, nonatomic) IBOutlet UIButton    *backCardBtn;
@property (weak, nonatomic) IBOutlet UILabel     *mainCardLabel;

@property (weak, nonatomic) IBOutlet UILabel     *backCardLabel;
@property (weak, nonatomic) IBOutlet UIImageView *mainCardImageView;
@property (weak, nonatomic) IBOutlet UIImageView *backCardImageView;
@property (weak, nonatomic) IBOutlet UILabel     *desLabel1;
@property (weak, nonatomic) IBOutlet UILabel     *desLabel2;

@property (nonatomic,strong) UIImage *mainImage;
@property (nonatomic,strong) UIImage *backImage;

@property (assign, nonatomic) NSInteger type;

@property (nonatomic,strong) HXPhotoViewController *photoViewController;


@end

@implementation Fcgo_RegistIDCardCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    self.type = -1;
    [self.cardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
    }];
    self.cardLabel.textColor = UIFontMainGrayColor;
    
    [self.mainCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.cardLabel.mas_bottom).mas_offset(15);
        make.width.mas_offset((kScreenWidth-30-10)/2);
        make.height.mas_offset((kScreenWidth-30-10)/2 *106/170);
    }];
    
    [self.mainCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.mainCardBtn.mas_bottom).mas_offset(5);
        make.width.mas_offset((kScreenWidth-30-10)/2);
        
    }];
    
    self.mainCardLabel.textColor = UIFontMiddleGrayColor;
    
    [self.backCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weakSelf.cardLabel.mas_bottom).mas_offset(15);
        make.width.mas_offset((kScreenWidth-30-10)/2);
        make.height.mas_offset((kScreenWidth-30-10)/2 *106/170);
    }];
    
    [self.backCardLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weakSelf.backCardBtn.mas_bottom).mas_offset(5);
        make.width.mas_offset((kScreenWidth-30-10)/2);
    }];
    self.backCardLabel.textColor = UIFontMiddleGrayColor;
    
    [self.mainCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.mainCardLabel.mas_bottom).mas_offset(20);
        make.width.mas_offset((kScreenWidth-30-10)/2);
        make.height.mas_offset((kScreenWidth-30-10)/2/1.6);
    }];
    
    [self.backCardImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weakSelf.mainCardLabel.mas_bottom).mas_offset(20);
        make.width.mas_offset((kScreenWidth-30-10)/2);
        make.height.mas_offset((kScreenWidth-30-10)/2/1.6);
    }];
    
    [self.desLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.mainCardImageView.mas_bottom).mas_offset(10);
    }];
    self.desLabel1.textColor = UIFontMainGrayColor;
    
    [self.desLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.desLabel1.mas_bottom).mas_offset(3);
    }];
    self.desLabel2.textColor = UIFontMainGrayColor;
}

- (HXPhotoManager *)manager1
{
    if (!_manager1) {
        HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        manager.outerCamera = YES;
        manager.openCamera = NO;
        manager.maxNum = 1;
        manager.photoMaxNum = 1;
        _manager1 = manager;
    }
    return _manager1;
}
- (HXPhotoManager *)manager0
{
    if (!_manager0) {
        HXPhotoManager *manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        manager.outerCamera = YES;
        manager.openCamera = NO;
        manager.maxNum = 1;
        manager.photoMaxNum = 1;
        _manager0 = manager;
    }
    return _manager0;
}

- (IBAction)mainImageClick:(UIButton *)sender
{
    self.type = 0;
    [self showImageList];
}

- (IBAction)backImageClick:(UIButton *)sender
{
    self.type = 1;
    [self showImageList];
}

- (void)showImageList
{
    WEAKSELF(weakSelf)
    [Fcgo_SheetAnimationView showWithArray:@[@"相机",@"相册"] DidSelectedBlock:^(NSInteger index) {
        if (index == 0) {
            IDCardPhotoVC *v = [[IDCardPhotoVC alloc]init];
            if (weakSelf.type == 0) {
                v.isHeaderFace = 1;
            }
            else{
                v.isHeaderFace = 0;
            }
            v.whenFinsh = ^(UIImage *image)
            {
                if (weakSelf.type == 0) {
                    weakSelf.mainImage = image;
                    [weakSelf.mainCardBtn setBackgroundImage:image forState:UIControlStateNormal];
                }
                else if (weakSelf.type == 1)
                {
                    weakSelf.backImage = image;
                    [weakSelf.backCardBtn setBackgroundImage:image forState:UIControlStateNormal];
                }
                if (weakSelf.imageBlock) {
                    weakSelf.imageBlock(self.mainImage,self.backImage);
                }
            };
            [[self viewController:self] presentViewController:v animated:YES completion:nil];
        }
        else
        {
            HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
            vc.delegate = self;
            if (self.type == 0) {
                vc.manager = self.manager0;
            }
            else if(self.type == 1) {
                vc.manager = self.manager1;
            }
            vc.isNotAutoClose = YES;
            self.photoViewController = vc;
            [[self viewController:self] presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }
    }];
}

#pragma mark - ALiImageReshapeDelegate

- (void)imageReshaperController:(AliImageReshapeController *)reshaper didFinishPickingMediaWithInfo:(UIImage *)image
{
    if (self.type == 0) {
        self.mainImage = image;
        [self.mainCardBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    else if (self.type == 1)
    {
        self.backImage = image;
        [self.backCardBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    if (self.imageBlock) {
        self.imageBlock(self.mainImage,self.backImage);
    }
    [self.photoViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imageReshaperControllerDidCancel:(AliImageReshapeController *)reshaper
{
    [self.photoViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original
{
    if (photos.count<=0) {
        return;
    }
    [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
        UIImage *image = images[0];
        AliImageReshapeController *vc = [[AliImageReshapeController alloc] init];
        vc.sourceImage = image;
        vc.reshapeScale = 341./213.;
        vc.delegate = self;
        [self.photoViewController.navigationController pushViewController:vc animated:YES];
        }];
    
}

- (UIViewController*)viewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UINavigationController class]] || [nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

- (void)setModel:(Fcgo_RealNameModel *)model
{
    _model = model;
    WEAKSELF(weakSelf)
    [self.mainCardBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.model.mchPicurlW] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"add_ID_realName"]];
    
    [self.backCardBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.model.mchPicurlB] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"add_ID_realName"]];
    
    NSOperationQueue *loadQueue = [[NSOperationQueue alloc] init];
    loadQueue.maxConcurrentOperationCount = 5;
    
    [loadQueue addOperationWithBlock:^{
        
        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlW]];
        if (data1) {
            //下载完毕后，先存储到内存。
            weakSelf.mainImage = [UIImage imageWithData:data1];
        }
        
        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlB]];
        
        if (data2) {
            //下载完毕后，先存储到内存。
            weakSelf.backImage = [UIImage imageWithData:data2];
        }
    }];
}

@end

