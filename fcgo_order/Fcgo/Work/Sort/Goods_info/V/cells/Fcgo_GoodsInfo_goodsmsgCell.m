//
//  Fcgo_GoodsInfo_goodsmsgCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/12/26.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import "Fcgo_GoodsInfo_goodsmsgCell.h"

@interface Fcgo_GoodsInfo_goodsmsgCell ()

@property (weak, nonatomic) IBOutlet UILabel  *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel  *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel  *totalPricelabel;
@property (weak, nonatomic) IBOutlet UILabel  *singleLabel;
@property (weak, nonatomic) IBOutlet UILabel  *singlePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel  *freightAndStockLabel;
@property (weak, nonatomic) IBOutlet UILabel  *saleLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_GoodsInfo_goodsmsgCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle  = 0;
    self.goodsNameLabel.font = [UIFont systemFontOfSize:17];
    self.goodsNameLabel.textColor = UIFontMainGrayColor;
    self.goodsNameLabel.numberOfLines = 2;
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    self.totalLabel.font = [UIFont systemFontOfSize:13];
    self.totalLabel.textColor =  UIFontMiddleGrayColor;
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.goodsNameLabel.mas_bottom).mas_offset(15);
        make.left.mas_offset(15);
    }];
    
    self.totalPricelabel.font = [UIFont boldSystemFontOfSize:20];
    self.totalPricelabel.textColor = UIFontRedColor;
    [self.totalPricelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.totalLabel.mas_bottom).mas_offset(2);
        make.left.mas_equalTo(self.totalLabel.mas_right).mas_offset(3);
    }];
    
    self.singlePriceLabel.font = [UIFont boldSystemFontOfSize:20];
    self.singlePriceLabel.textColor = UIFontRedColor;
    [self.singlePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.totalLabel.mas_bottom).mas_offset(2);
        make.right.mas_offset(-15);
    }];

    self.singleLabel.font = [UIFont systemFontOfSize:13];
    self.singleLabel.textColor = UIFontMiddleGrayColor;
    [self.singleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.totalLabel.mas_bottom);
        make.right.mas_equalTo(self.singlePriceLabel.mas_left).mas_offset(-3);
    }];
    
    self.freightAndStockLabel.font = [UIFont systemFontOfSize:13];
    self.freightAndStockLabel.textColor = UIFontMiddleGrayColor;
    [self.freightAndStockLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.totalPricelabel.mas_bottom).mas_offset(10);
        make.left.mas_offset(15);
    }];
    
    self.saleLabel.font = [UIFont systemFontOfSize:13];
    self.saleLabel.textColor = UIFontMiddleGrayColor;
    [self.saleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.freightAndStockLabel.mas_centerY);
        make.right.mas_offset(-15);
    }];
    
    self.bottomLineView.backgroundColor = UIBackGroundColor;
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(5);
    }];
}

- (void)setInfoModel:(Fcgo_GoodsInfoMsgModel *)infoModel
{
    _infoModel = infoModel;
    NSString *str = @"";
    switch (infoModel.texes.integerValue) {
        case 1:
            str = @"[一般贸易] ";
            break;
        case 2:
            str = @"[跨境保税] ";
            break;
        case 3:
            str = @"[海外直邮] ";
            break;
            
        default:
            break;
    }
    NSMutableAttributedString *goodsNameString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSMutableAttributedString *strString = [[NSMutableAttributedString alloc] initWithString:str];
    NSRange strRange = {1,[str length]-3};
    [strString addAttribute:NSForegroundColorAttributeName value:UIFontRedColor range:strRange];
    [strString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:strRange];
    NSMutableAttributedString *nameString = [[NSMutableAttributedString alloc] initWithString:infoModel.goodsName];
    NSRange nameRange = {0,[nameString length]};
    [nameString addAttribute:NSForegroundColorAttributeName value:UIFontMainGrayColor range:nameRange];
    [nameString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:nameRange];
    [goodsNameString appendAttributedString:strString];
    [goodsNameString appendAttributedString:nameString];
    self.goodsNameLabel.attributedText = goodsNameString;
    NSInteger sale = infoModel.goodsSalenum.integerValue+ infoModel.goodsScannum.integerValue;
    if (sale<=0) {
        self.saleLabel.text = @"销量 --";
    }else{
        self.saleLabel.text = [NSString stringWithFormat:@"销量 %ld",sale];
    }
    if (self.skuModel && self.skuModel.totalYUAN) {
        return;
    }
    self.totalPricelabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.minpriceYUAN floatValue]];
    self.singlePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.priceYUAN floatValue]];
    self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存: %@",infoModel.freight_s,infoModel.stock_s];
}

- (void)setSkuModel:(Fcgo_GoodsSkuModel *)skuModel
{
    _skuModel = skuModel;
    if(!skuModel.totalYUAN) return;
     self.totalPricelabel.text = [NSString stringWithFormat:@"¥ %.2f",round([skuModel.totalYUAN floatValue]*100)/100];
    self.singlePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",round([skuModel.unitpriceYUAN floatValue]*100)/100];
    NSString *goodsType = skuModel.goodsType;
    if(![goodsType isEqualToString:@"normal"]){
        if ([goodsType isEqualToString:@"integral"]) {
            if (self.infoModel && (self.infoModel.activityModel.status.integerValue == 2)) {
                goodsType = @"normal";
            }
            else{
                goodsType = @"activity";
            }
        }
        else{
            goodsType = @"activity";
        }
    }else{
        goodsType = @"normal";
    }
    if ([goodsType isEqualToString:@"normal"]) {
        self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%d",skuModel.postageYUAN,skuModel.remain.intValue / skuModel.time.intValue];
    }else{
        self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%d",skuModel.postageYUAN,skuModel.remain.intValue];
    }
}

@end

