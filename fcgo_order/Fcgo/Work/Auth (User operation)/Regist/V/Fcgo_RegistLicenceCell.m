//
//  Fcgo_RegistLicenceCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RegistLicenceCell.h"

@interface Fcgo_RegistLicenceCell ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,HXPhotoViewControllerDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;
@property (weak, nonatomic) IBOutlet UIButton *licenceBtn;
@property (weak, nonatomic) IBOutlet UILabel  *titleLabel;

@end

@implementation Fcgo_RegistLicenceCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    WEAKSELF(weakSelf)
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    
    [self.licenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(10);
        make.width.mas_offset(110);
        make.height.mas_offset(110);
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

- (IBAction)licenceClick:(UIButton *)sender
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
        [self.licenceBtn setBackgroundImage:image forState:UIControlStateNormal];
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
        [self.licenceBtn setBackgroundImage:images[0] forState:UIControlStateNormal];
        
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
