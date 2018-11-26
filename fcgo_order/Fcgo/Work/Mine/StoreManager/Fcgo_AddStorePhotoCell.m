//
//  Fcgo_AddStorePhotoCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_AddStorePhotoCell.h"

@interface Fcgo_AddStorePhotoCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HXPhotoViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UIButton    *storePhotoBtn;
@property (strong, nonatomic) IBOutlet UIView    *bottomLineView;

@property (strong, nonatomic) HXPhotoManager     *manager;
@property (nonatomic,strong) HXPhotoViewController *photoViewController;

@end

@implementation Fcgo_AddStorePhotoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    [self.storePhotoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(15);
    }];
    self.storePhotoLabel.textColor = UIFontMainGrayColor;
    self.storePhotoLabel.font = UIFontSize(15);
    
    [self.storePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.centerY.mas_equalTo(weakSelf.contentView);
        make.width.mas_offset(60*170/106);
        make.height.mas_offset(60);
    }];
    self.bottomLineView.backgroundColor = UISepratorLineColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.outerCamera = YES;
        _manager.openCamera = NO;
        _manager.maxNum = 1;
        _manager.photoMaxNum = 1;
    }
    return _manager;
}

- (IBAction)storePhotoClick:(UIButton *)sender
{
    WEAKSELF(weakSelf)
    [Fcgo_SheetAnimationView showWithArray:@[@"相机",@"相册"] DidSelectedBlock:^(NSInteger index) {
        if (index == 0) {
            UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *picker = [[UIImagePickerController alloc]init];
                picker.delegate = weakSelf;
                picker.allowsEditing = YES;
                picker.sourceType = sourceType;
                [[self viewController:self] presentViewController:picker animated:YES completion:nil];
            }
            else {
                
            }
        }
        else
        {
            HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
            vc.delegate = self;
            vc.manager = self.manager;
            [[self viewController:self] presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
        }
        
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
        [self.storePhotoBtn setBackgroundImage:image forState:UIControlStateNormal];
        if (self.imageBlock) {
            self.imageBlock([Fcgo_Tools imageDealHandleWithImage:image scaleToSize:CGSizeMake(500, 300)]);
        }
        [picker dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)photoViewControllerDidNext:(NSArray *)allList Photos:(NSArray *)photos Videos:(NSArray *)videos Original:(BOOL)original
{
    if (photos.count<=0) {
        return;
    }
    [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
        [self.storePhotoBtn setBackgroundImage:images[0] forState:UIControlStateNormal];
        
        if (self.imageBlock) {
            self.imageBlock([Fcgo_Tools imageDealHandleWithImage:images[0] scaleToSize:CGSizeMake(500, 300)]);
        }
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

@end

//- (void)setModel:(Fcgo_RealNameModel *)model
//{
//    _model = model;
//    WEAKSELF(weakSelf)
//    [self.mainCardBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.model.mchPicurlW] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"add_ID_realName"]];
//
//    [self.backCardBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.model.mchPicurlB] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"add_ID_realName"]];
//
//    NSOperationQueue *loadQueue = [[NSOperationQueue alloc] init];
//    loadQueue.maxConcurrentOperationCount = 5;
//
//    [loadQueue addOperationWithBlock:^{
//
//        NSData *data1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlW]];
//        if (data1) {
//            //下载完毕后，先存储到内存。
//            weakSelf.mainImage = [UIImage imageWithData:data1];
//        }
//
//        NSData *data2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.mchPicurlB]];
//
//        if (data2) {
//            //下载完毕后，先存储到内存。
//            weakSelf.backImage = [UIImage imageWithData:data2];
//        }
//    }];
//}
//
//@end


