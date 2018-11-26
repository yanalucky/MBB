//
//  Fcgo_ServiceDetailSection2Row0Cell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ServiceDetailSection2Row0Cell.h"

@implementation Fcgo_ServiceDetailSection2Row0Cell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    self.selectionStyle = 0;
    self.backgroundColor = UIBackGroundColor;
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.bottom.mas_offset(0);
        
    }];
    self.whiteView.backgroundColor = UIFontWhiteColor;
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(weakSelf.whiteView.mas_left).mas_offset(12);
    }];
    self.titleLabel.textColor = UIFontMiddleGrayColor;
    self.titleLabel.font = UIFontSize(14);
    self.titleLabel.numberOfLines = 0;
    [self.goodsImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(10);
        make.left.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(70));
        make.right.mas_offset(0);
    }];
}

- (void)setDetailModel:(Fcgo_AfterSalesService_DetailModel *)detailModel
{
    _detailModel = detailModel;
    self.titleLabel.text = detailModel.f_refund_reason;
    
    
    // 先移除，后添加
    [[self.goodsImageScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (NSInteger i = 0; i < detailModel.f_refund_picurlArray.count; i++) {
        UIImageView *goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(12+(kAutoWidth6(77)*i), 0, kAutoWidth6(70), kAutoWidth6(70))];
        [goodsImageView sd_setImageWithURL:[NSURL URLWithString:detailModel.f_refund_picurlArray[i]]placeholderImage:[UIImage imageNamed:@"580X580"]];
        goodsImageView.userInteractionEnabled = 0;
        [self.goodsImageScrollView addSubview:goodsImageView];
    }
}
   
@end
