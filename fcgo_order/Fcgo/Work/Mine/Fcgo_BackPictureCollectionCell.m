//
//  Fcgo_BackPictureCollectionCell.m
//  Fcgo
//
//  Created by fcg on 2017/10/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BackPictureCollectionCell.h"

@implementation Fcgo_BackPictureCollectionCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self remakeCell];

    }
    return self;
}

-(void)remakeCell{
    _imgView = [[UIImageView alloc] init];
    _imgView.layer.masksToBounds = YES;
    _imgView.layer.cornerRadius = 2;
    [self addSubview:_imgView];
    //btn
    _btnDelete = [UIButton buttonWithType:UIButtonTypeSystem];
    [_btnDelete setBackgroundImage:[[UIImage imageNamed:@"icon_delete_after"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    _btnDelete.hidden = NO;
    [self addSubview:_btnDelete];
}




-(void)layoutSubviews{
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.size.equalTo(self);
    }];
    
    [_btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(18), kAutoWidth6(18)));
    }];
   
}


@end
