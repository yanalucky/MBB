//
//  Fcgo_SiftMainCollectionCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/9.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SiftMainCollectionCell.h"
#import "Fcgo_SiftCateModel.h"//一级分类
#import "Fcgo_SiftCatemModel.h"//二级分类
#import "Fcgo_BrandModel.h"
#import "Fcgo_AttrModel.h"
#import "Fcgo_GoodsPropertyModel.h"

@implementation Fcgo_SiftMainCollectionCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.layer.cornerRadius  = 3;
    self.layer.borderWidth   = 1;
    self.layer.masksToBounds = 1;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(0);
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
    }];
    self.titleLabel.textColor = UIFontMainGrayColor;
    self.titleLabel.font = UIFontSize(12);
}

- (void)setSelect:(BOOL)select
{
    _select = select;
    if (select) {
        self.layer.borderColor   = UIFontRedColor.CGColor;
        self.titleLabel.textColor = UIFontRedColor;
        self.backgroundColor = UIFontWhiteColor;

    }else{
        
        self.layer.borderColor   = UIFontMiddleGrayColor.CGColor;
        self.titleLabel.textColor = UIFontMiddleGrayColor;
        self.backgroundColor = UIFontWhiteColor;
    }
}

- (void)setType:(ItemSelectedType)type
{
    _type = type;
    if (type == ItemSelectedOnType) {
        self.layer.borderColor    = UIFontRedColor.CGColor;
        self.titleLabel.textColor = UIFontRedColor;
        self.backgroundColor      = UIFontWhiteColor;
    }
    else  if (type == ItemSelectedNotType) {
        self.layer.borderColor    = UIRGBColor(234, 234, 234, 1).CGColor;
        self.titleLabel.textColor = UIFontMiddleGrayColor;
        self.backgroundColor      = UIRGBColor(234, 234, 234, 1);
    }
    else  if (type == ItemSelectedNormalType) {
        self.layer.borderColor    = UIFontMiddleGrayColor.CGColor;
        self.titleLabel.textColor = UIFontMainGrayColor;
        self.backgroundColor      = UIFontWhiteColor;
    }
}

- (void)setObject:(id)object
{
    if ([object isKindOfClass:[NSString class]]) {
        self.titleLabel.text = (NSString *)object;
    }
    else if ([object isKindOfClass:[Fcgo_SiftCateModel class]]) {
        Fcgo_SiftCateModel *model = object;
        self.titleLabel.text = model.name;
        self.select = model.selected.intValue;
    }
    else if ([object isKindOfClass:[Fcgo_SiftCatemModel class]]) {
        Fcgo_SiftCatemModel *model = object;
        self.titleLabel.text = model.name;
        self.select = model.selected.intValue;

    }
    else if ([object isKindOfClass:[Fcgo_BrandModel class]]) {
        Fcgo_BrandModel *model = object;
        self.titleLabel.text = model.brand_name;
        self.select = model.selected.intValue;
    }
    else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *attrDict = object;
        self.titleLabel.text = attrDict[@"name"];
        self.select = [attrDict[@"selected"] intValue];
    }
    else if ([object isKindOfClass:[Fcgo_AttrModel class]]) {
        Fcgo_AttrModel *attrMdoel = object;
        self.titleLabel.text = attrMdoel.f_value_name;
        
        NSString *clas = attrMdoel.clas;
        if ([clas isEqualToString:@"item"]) {
            self.type = ItemSelectedNormalType;
        }
        else if ([clas isEqualToString:@"item selected"]) {
            self.type = ItemSelectedOnType;
        }
        else if ([clas isEqualToString:@"item not-selected"]) {
            self.type = ItemSelectedNotType;
        }
    }
    else if ([object isKindOfClass:[Fcgo_GoodsPropertyModel class]]) {
        Fcgo_GoodsPropertyModel *attrMdoel = object;
        self.titleLabel.text = attrMdoel.f_value_name;
        
        NSString *clas = attrMdoel.clas;
        if ([clas isEqualToString:@"item"]) {
            self.type = ItemSelectedNormalType;
        }
        else if ([clas isEqualToString:@"item selected"]) {
            self.type = ItemSelectedOnType;
        }
        else if ([clas isEqualToString:@"item not-selected"]) {
            self.type = ItemSelectedNotType;
        }
    }
}

@end
