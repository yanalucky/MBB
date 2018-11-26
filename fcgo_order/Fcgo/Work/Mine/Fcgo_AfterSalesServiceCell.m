//
//  Fcgo_AfterSalesServiceCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AfterSalesServiceCell.h"

@interface Fcgo_AfterSalesServiceCell ()


@property (weak, nonatomic) IBOutlet UILabel     *orderNumberLabel;
@property (weak, nonatomic) IBOutlet UIView      *middleLineView;
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel     *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel     *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView      *middleTwoLineView;
@property (weak, nonatomic) IBOutlet UIButton    *afterType;

@property (weak, nonatomic) IBOutlet UIView      *bottomLineView;
@property (weak, nonatomic) IBOutlet Fcgo_OrderListButton *detailBtn;
@property(nonatomic,strong)NSMutableArray        *mutableArray;


@end

@implementation Fcgo_AfterSalesServiceCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    
    
    _mutableArray = [[NSMutableArray alloc] init];
    NSDictionary *dic0 = @{@"img":@"pending_after-sales",@"title":@"申请补偿"};
    NSDictionary *dic1 = @{@"img":@"drawback_after-sales",@"title":@"仅退款"};
    NSDictionary *dic2 = @{@"img":@"succeeded_after-sales",@"title":@"退货退款"};
    [_mutableArray addObject:dic0];
    [_mutableArray addObject:dic1];
    [_mutableArray addObject:dic2];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 4)];
    lineView.backgroundColor = UIBackGroundColor;
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.and.left.equalTo(self);
        make.height.mas_equalTo(kAutoHeight6(4));
    }];
    [self.orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoHeight6(4));
        make.left.mas_offset(kAutoWidth6(15));
        make.height.mas_equalTo(kAutoHeight6(39));
    }];
    
    self.orderNumberLabel.textColor = UIFontMiddleGrayColor;
    self.orderNumberLabel.font = UIFontSize(13);
    self.orderNumberLabel.userInteractionEnabled = YES;
    [self.orderNumberLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(copyAfterNum)]];
   
    
    [self.middleLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.orderNumberLabel.mas_bottom);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleLineView.backgroundColor = UISepratorLineColor;
    
    [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.middleLineView.mas_bottom).mas_offset(kAutoHeight6(12));
        make.left.mas_offset(kAutoWidth6(12));
        make.height.width.mas_offset(kAutoHeight6(80));
    }];
    
    [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_top);
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(kAutoWidth6(12));
        make.right.mas_offset(-kAutoWidth6(12));
    }];
    
    self.goodsNameLabel.textColor = UIFontMainGrayColor;
    self.goodsNameLabel.font = UIFontSize(16);
    self.goodsNameLabel.numberOfLines = 2;
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.goodsNameLabel.mas_bottom).offset(kAutoHeight6(12));
        make.left.mas_equalTo(weakSelf.goodsImageView.mas_right).mas_offset(kAutoWidth6(12));
        make.right.mas_offset(-kAutoWidth6(12));
    }];
    self.goodsPriceLabel.textColor = UIStringColor(@"#7b7b7b");
    self.goodsPriceLabel.font = UIFontSize(12);
    self.goodsPriceLabel.numberOfLines = 2;
    
    [self.totalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImageView.mas_bottom).mas_offset(kAutoHeight6(5));
        make.right.mas_offset(-kAutoWidth6(12));
    }];
    self.totalPriceLabel.textColor = UIFontRedColor;
    self.totalPriceLabel.font = UIFontSize(17);
    
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.totalPriceLabel.mas_bottom);
        make.right.mas_equalTo(weakSelf.totalPriceLabel.mas_left).mas_offset(-kAutoWidth6(3));
    }];
    self.totalLabel.textColor = UIFontMainGrayColor;
    self.totalLabel.font = UIFontSize(13);
    
    [self.middleTwoLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.totalPriceLabel.mas_bottom).mas_offset(kAutoHeight6(10));
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    self.middleTwoLineView.backgroundColor = UISepratorLineColor;
    
   
    
    self.detailBtn.layer.borderColor   = UIFontRedColor.CGColor;
    self.detailBtn.layer.borderWidth   = 0.5;
    self.detailBtn.layer.cornerRadius  = 3;
    self.detailBtn.layer.masksToBounds = 1;
    [self.detailBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    [self.detailBtn setBackgroundColor:UIFontWhiteColor];
    self.detailBtn.enabled = NO;
    [self.detailBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-kAutoWidth6(12));
        make.height.mas_offset(kAutoHeight6(25));
        make.width.mas_offset(kAutoWidth6(70));
        make.bottom.mas_equalTo(weakSelf).mas_offset(-kAutoWidth6(7));
    }];
    
   
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_offset(0);
        make.height.mas_offset(0);
    }];
    self.bottomLineView.backgroundColor = UIBackGroundColor;
   
    [self.afterType setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    self.afterType.titleLabel.font = UIFontSize(14);
    self.afterType.imageEdgeInsets = UIEdgeInsetsMake(0, (-kAutoWidth6(12)), 0, 0);
    [self.afterType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(kAutoWidth6(12));
        make.centerY.equalTo(self.detailBtn);
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(15)));
    }];
}
-(void)copyAfterNum
{
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.model.orderAftersaleNo];
    [WSProgressHUD showImage:nil status:@"订单号已复制"];
}
- (void)setModel:(Fcgo_AfterSalesServiceListModel *)model
{
    _model = model;
    self.orderNumberLabel.text = [NSString stringWithFormat:@"售后单号: %@",model.orderAftersaleNo];
   [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsNameLabel.text = model.goodsName;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"%@",model.properties];
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[model.refundPriceYUAN doubleValue]];
    [self.afterType setTitle:model.aftersaleType forState:UIControlStateNormal];
    for (NSDictionary *dic in _mutableArray) {
        if ([[dic objectForKey:@"title"] isEqualToString:model.aftersaleType]) {
            [self.afterType setImage:[[UIImage imageNamed:[dic objectForKey:@"img"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        }
    }
}

@end

