//
//  HotCollectionCell.m
//  Fcg
//
//  Created by huafanxiao on 2017/3/29.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "HotCollectionCell.h"

@implementation HotCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    UIView *superView = self.contentView;
    
    superView.layer.borderColor = UIRGBColor(234, 234, 234, 1).CGColor;
    superView.layer.borderWidth = 0.5;
    superView.layer.masksToBounds = YES;
    
    
    WEAKSELF(weakSelf);
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_offset(kAutoWidth6px(573));
    }];
    
    [self.leftTopImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.mas_offset(0);
        make.height.mas_offset(kAutoWidth6px(62));
        make.width.mas_offset(kAutoWidth6px(162));
    }];
    
    [self.leftTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.mas_offset(3);
        make.height.mas_offset(kAutoWidth6px(62));
        make.width.mas_offset(kAutoWidth6px(162));
    }];
    /*
    
    
    
    
    需改动
     
    
    
    
    
    */
    
    self.leftTopLabel.alpha = 0;
    self.leftTopImg.alpha  = 0;
    
    self.leftTopLabel.text = @"高毛利率";
    self.leftTopLabel.textColor = UIFontWhiteColor;
    self.leftTopLabel.font = UIFontSize(9);
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(0.5);
        make.right.mas_offset(0);
    }];
    self.line.backgroundColor = UIRGBColor(234, 234, 234, 1);
    self.line.alpha = 0;
    
    
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.line.mas_bottom).mas_offset(12);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    self.goodsName.numberOfLines = 2;
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = UIFontSize(13);
    //self.goodsName.text = @"坚实的空间费口舌四大皆空国剧盛典空格是的困jog降低搜看你尚德机构ID搜";
    
    [self.goodsDesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsName.mas_bottom).mas_offset(5);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(0);
    }];
    
    self.goodsDesLabel.numberOfLines = 3;
    self.goodsDesLabel.textColor = UIFontMiddleGrayColor;
    self.goodsDesLabel.font = [UIFont systemFontOfSize:11];
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-9);
        make.left.right.mas_offset(0);
    }];
    self.goodsPrice.textColor = UIFontRedColor;
    self.goodsPrice.font = UIFontSize(17);
    self.goodsPrice.textAlignment = NSTextAlignmentCenter;
    //self.goodsPrice.text = @"¥345";
    
    [self.goodsSalePrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.goodsPrice.mas_centerY);
        make.right.mas_offset(-15);
    }];
    self.goodsSalePrice.textColor = UIFontRedColor;
    self.goodsSalePrice.font = UIFontSize(12);
    //self.goodsSalePrice.text = @"建议零售价: ¥345";
    self.goodsSalePrice.hidden = 1;
}

- (void)setDict:(NSDictionary *)dict
{
    if (dict.count>0) {
        [self.goodsImg sd_setImageWithURL:[NSURL  URLWithString:[dict  objectForKey:@"f_picurl_logo"]]placeholderImage:[UIImage imageNamed:@"580X580"]];
        self.goodsName.text = [dict  objectForKey:@"f_goods_name"];
        NSString *price = [dict  objectForKey:@"f_price"];
        
        CGFloat price_f = [price floatValue];
        self.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",price_f];
        //self.goodsPrice.text = [NSString stringWithFormat:@"¥ %@",price];
        self.goodsSalePrice.text = [NSString stringWithFormat:@"建议零售价:¥%@",[dict  objectForKey:@"f_jprice"]];
    }
}

- (void)setGoodsModel:(Fcgo_HomeGoodsModel *)goodsModel
{
    _goodsModel = goodsModel;
    [self.goodsImg sd_setImageWithURL:[NSURL  URLWithString:goodsModel.picurlLogo]placeholderImage:[UIImage imageNamed:@"580X580"]];
    NSString *str = @"";
    switch (goodsModel.texe.integerValue) {
        case 1:
            str = @"【一般贸易】";
            break;
        case 2:
            str = @"【跨境保税】";
            break;
        case 3:
            str = @"【海外直邮】";
            break;
            
        default:
            break;
    }
    self.goodsName.text = [str stringByAppendingString:goodsModel.goodsName?:@""];
    CGFloat price_f = [goodsModel.priceYUAN floatValue];
    self.goodsPrice.text = [NSString stringWithFormat:@"¥ %.2f",price_f];
    self.goodsSalePrice.text = [NSString stringWithFormat:@"建议价:¥ %.2f",[goodsModel.jpriceYUAN floatValue]];
}

- (void)setGoodsDesLableHieghtIndex:(NSInteger )item
{
    WEAKSELF(weakSelf);
    if (item == 5) {
        [self.goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(weakSelf.goodsPrice.mas_top).mas_offset(-5);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
        }];
        self.goodsDesLabel.text = @"我们拥有优质的服务,海量的商品供您选择,优惠多多,欢迎您的使用";
    }else{
        [self.goodsDesLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.bottom.mas_equalTo(weakSelf.goodsPrice.mas_top).mas_offset(-5);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(0);
        }];
    }
}
@end
