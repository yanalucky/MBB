//
//  Fcgo_RegistBackImageCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_RegistBackImageCell.h"

@interface Fcgo_RegistBackImageCell ()<HXPhotoViewDelegate>

@property (strong, nonatomic) HXPhotoManager *manager;

@end

@implementation Fcgo_RegistBackImageCell

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
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.mas_offset(-10);
    }];
    self.descLabel.textColor = UIFontMiddleGrayColor;
    
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.delegate = self;
    photoView.maxNum = 6;
    [self.contentView addSubview:photoView];
    [photoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(10);
        make.bottom.mas_equalTo(weakSelf.descLabel.mas_top).mas_offset(-10);
    }];
}

- (HXPhotoManager *)manager
{
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.outerCamera = YES;
        _manager.maxNum = 6;
        _manager.photoMaxNum = 6;
    }
    return _manager;
}

- (void)photoViewChangeComplete:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)isOriginal
{
    WEAKSELF(weakSelf);
    [HXPhotoTools fetchOriginalForSelectedPhoto:photos completion:^(NSArray<UIImage *> *images) {
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < images.count ; i ++) {
            [array addObject:[Fcgo_Tools imageDealHandleWithImage:images[i]]];
        }
        if (weakSelf.imageBlock) {
            weakSelf.imageBlock(array);
        }
    }];
}

@end

