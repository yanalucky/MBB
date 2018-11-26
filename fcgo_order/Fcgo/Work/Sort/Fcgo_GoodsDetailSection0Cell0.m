//
//  Fcgo_GoodsDetailSection0Cell0.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsDetailSection0Cell0.h"

@interface Fcgo_GoodsDetailSection0Cell0 ()
@property (weak, nonatomic) IBOutlet UILabel  *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel  *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel  *totalPricelabel;
@property (weak, nonatomic) IBOutlet UILabel  *singleLabel;
@property (weak, nonatomic) IBOutlet UILabel  *singlePriceLabel;
@property (weak, nonatomic) IBOutlet UILabel  *freightAndStockLabel;
@property (weak, nonatomic) IBOutlet UILabel  *saleLabel;
@property (strong, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation Fcgo_GoodsDetailSection0Cell0

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
    self.height = 120;
}


- (void)setInfoModel:(Fcgo_GoodsInfoModel *)infoModel
{
    _infoModel = infoModel;
    self.goodsNameLabel.text = infoModel.goodsName;
    self.saleLabel.text = [NSString stringWithFormat:@"销量 %ld", infoModel.goodsSalenum.integerValue];// + infoModel.goodsVirtualNum.integerValue
    if (!self.bestSKUModel) {
        self.totalPricelabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.minpriceYUAN floatValue]];
        self.singlePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[infoModel.priceYUAN floatValue]];
       
        
        if (!infoModel.freight && !infoModel.stock) {
            self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%@",infoModel.freight_s,infoModel.stock_s];
        }else{
            self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%@",@"0.00",infoModel.stock];
        }

    }
    
    self.totalLabel.text = @"商城价:";
    self.singleLabel.text = @"到店价:";
    
}

- (void)setBestSKUModel:(Fcgo_BestSKUModel *)bestSKUModel
{
    _bestSKUModel = bestSKUModel;
    
    NSString *total = [NSString stringWithFormat:@"%.2f",round([bestSKUModel.totalYUAN floatValue]*100)/100];
    self.totalPricelabel.text = [NSString stringWithFormat:@"¥ %@",total];
    self.singlePriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",round([bestSKUModel.unitpriceYUAN floatValue]*100)/100];
    if ([self.goodsType isEqualToString:@"normal"]) {
       self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%d",bestSKUModel.postageYUAN,bestSKUModel.remain.intValue / bestSKUModel.time.intValue];
    }else{
       self.freightAndStockLabel.text = [NSString stringWithFormat:@"运费:¥ %@ 库存:%d",bestSKUModel.postageYUAN,bestSKUModel.remain.intValue];
    }
}

@end
