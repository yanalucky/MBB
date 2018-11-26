//
//  Fcgo_backDetailView.m
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_backDetailView.h"
#import "Fcgo_ApplyTypeDetailCell.h"
@interface Fcgo_backDetailView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray *tableArr;
@end

@implementation Fcgo_backDetailView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setUI];
    // Initialization code
}

-(void)setUI{
    
    self.backgroundColor = UIRGBColor(246, 244, 242, 1);
    
    _view0.backgroundColor = UIRGBColor(222, 162, 131, 1);
    _view0LeftView.image = [UIImage imageNamed:@"icon_unsuccessful-refund"];
    _view0Title.text = @"退款失败";
    _view0Title.textColor = UIFontWhiteColor;
    _view0Title.font = UIFontSize(17);
    
    UITableView *table = _tableView; 
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = 0;
    table.backgroundColor = UIBackGroundColor;
    table.separatorStyle =  UITableViewCellSeparatorStyleNone;
    table.bounces = NO;
    table.scrollEnabled = NO;
    [table registerNib:[UINib nibWithNibName:@"Fcgo_ApplyTypeDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Fcgo_ApplyTypeDetailCell"];
    if (@available(iOS 11.0, *)) {
        table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _view3.backgroundColor = UIFontWhiteColor;
    _view3Title.text = @"退款信息";
    _view3Title.textColor = UIFontBlack282828;
    _view3Title.font = UIFontSize(15);
    _view3Line.backgroundColor = UIRGBColor(246, 244, 242, 1);
    _view3Line.text = @"";
    _view3GoodImg.image = [UIImage imageNamed:@"market_icon_goods"];
    _view3GoodTitle.font = UIFontSize(16);
    _view3GoodTitle.textColor = UIFontBlack282828;
    _view3GoodTitle.text = @"花王妙而舒 NB 90片/包 花王妙而舒 NB 90片/包 花王妙而舒 NB 90片/包 花王妙而舒 NB 90片/包 ";
    _view3GoodTitle.numberOfLines = 2;
    _view3GoodAttr.textColor = UIStringColor(@"#7b7b7b");
    _view3GoodAttr.text = @"颜色分类：圆357ML";
    _view3GoodAttr.font = UIFontSize(12);
    _view3GoodAttr.numberOfLines = 2;
    _View3AgainBtn.backgroundColor = UIFontWhiteColor;
    [_View3AgainBtn setTitle:@"再次购买" forState:UIControlStateNormal];
    [_View3AgainBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
    
    _View3AgainBtn.titleLabel.font = UIFontSize(14);
    _View3AgainBtn.layer.masksToBounds = YES;
    _View3AgainBtn.layer.cornerRadius = 3;
    _View3AgainBtn.layer.borderWidth = 0.5;
    _View3AgainBtn.layer.borderColor = [UIFontRedColor CGColor];
    
    _view4.backgroundColor = UIFontWhiteColor;
    _view4OrderNum.text = @"售后单号：";
    _view4OrderNumDetail.text = @"YNMIOS171012131423143121";
    _view4PayTime.text = @"申请时间：";
    _view4PayTimeDetail.text = @"1971-01-01 00:00:00";
    _view4BackMoney.text = @"退款金额：";
    _view4BackMoneyDetail.text = @"￥0.00";
    _view4Address.text = @"售后类型：";
    _view4backReason.text = @"退款原因：";
    _view4backReasonDetail.text = @"包装破损";
    

    _view4OrderNum.textColor = UIStringColor(@"#7b7b7b");
    _view4OrderNum.font = UIFontSize(13);
    _view4OrderNumDetail.textColor = UIStringColor(@"#7b7b7b");
    _view4OrderNumDetail.font = UIFontSize(13);
    _view4OrderNumDetail.textAlignment = NSTextAlignmentRight;
    _view4PayTime.textColor = UIStringColor(@"#7b7b7b");
    _view4PayTime.font = UIFontSize(13);
    _view4PayTimeDetail.textColor = UIStringColor(@"#7b7b7b");
    _view4PayTimeDetail.font = UIFontSize(13);
    _view4PayTimeDetail.textAlignment = NSTextAlignmentRight;

    _view4BackMoney.textColor = UIStringColor(@"#7b7b7b");
    _view4BackMoney.font = UIFontSize(13);
    _view4BackMoneyDetail.textColor = UIStringColor(@"#7b7b7b");
    _view4BackMoneyDetail.font = UIFontSize(13);
    _view4BackMoneyDetail.textAlignment = NSTextAlignmentRight;

    _view4Address.textColor = UIStringColor(@"#7b7b7b");
    _view4Address.font = UIFontSize(13);
    _view4AddressDetail.textColor = UIStringColor(@"#7b7b7b");
    _view4AddressDetail.font = UIFontSize(13);
    _view4AddressDetail.textAlignment = NSTextAlignmentRight;

    _view4backReason.textColor = UIStringColor(@"#7b7b7b");
    _view4backReason.font = UIFontSize(13);
    _view4backReasonDetail.textColor = UIStringColor(@"#7b7b7b");
    _view4backReasonDetail.font = UIFontSize(13);
    _view4backReasonDetail.textAlignment = NSTextAlignmentRight;

}
-(void)setOrderAftersaleNo:(NSString *)orderAftersaleNo{
        _view4OrderNumDetail.text = orderAftersaleNo;
}
-(void)setModel:(Fcgo_ApplyHistoryDetailModel *)model{
    
    _model = model;
    
   
    
    //申请程序
    if (model.afterSaleStreamList && model.afterSaleStreamList.count > 0) {
        _tableArr = model.afterSaleStreamList;
        [_tableView reloadData];
         _view4PayTimeDetail.text = model.afterSaleStreamList[model.afterSaleStreamList.count -1][@"createTime"];
    }
    
    //goodsImg
    [_view3GoodImg sd_setImageWithURL:[NSURL URLWithString:self.goodImg] placeholderImage:[UIImage imageNamed:@"580X580"]];
    _view3GoodTitle.text = model.goodsName;
    _view3GoodAttr.text = model.properties;
    


    _view4AddressDetail.text = self.afterType;
    
    _view4BackMoneyDetail.text = [NSString stringWithFormat:@"¥ %.2f",[model.refundPriceYUAN doubleValue]];
    BOOL isShowPrice = YES;
    if (([self.afterType isEqualToString:@"申请补偿"]&&[model.reason isEqualToString:@"效期不符"])||([self.afterType isEqualToString:@"申请补偿"]&&[model.reason isEqualToString:@"商品发错"])) {
        isShowPrice = NO;
    }
     _view4BackMoneyDetail.text = (isShowPrice)?[NSString stringWithFormat:@"¥ %.2f",[model.refundPriceYUAN doubleValue]]:([model.reason isEqualToString:@"商品发错"]?@"按商品实际差价补偿":@"具体金额以退款标准为准");
    _view4backReasonDetail.text = model.reason;
     _mainSC.contentSize = CGSizeMake(_mainSC.bounds.size.width, ((_tableArr.count-1) * 74+ 50)+ 500);
    [self layoutSubviews];
    
}
-(void)setStatus:(NSNumber *)status{
    //状态status
    //1申请 2处理中 3处理完 4 已驳回
    _view0LeftView.image = [[UIImage imageNamed:@"icon_application"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    _view0Title.text = @"待审核中";
    if ([status intValue] == 2) {
        _view0LeftView.image = [[UIImage imageNamed:@"icon_handle"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _view0Title.text = @"处理中";
    }else if ([status intValue] == 3) {
        _view0LeftView.image = [[UIImage imageNamed:@"icon_successful-refund"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _view0Title.text = @"处理完成";
    }else if ([status intValue] == 4) {
        _view0LeftView.image = [[UIImage imageNamed:@"icon_unsuccessful-refund"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        _view0Title.text = @"已驳回";
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == (_tableArr.count-1)) {
        return kAutoHeight6(64);
    }else{
        return kAutoHeight6(74);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _tableArr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Fcgo_ApplyTypeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Fcgo_ApplyTypeDetailCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell makeCell:_tableArr[indexPath.row] isLast:(indexPath.row == (_tableArr.count-1)) isRed:(indexPath.row == 0)];
    return cell;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    [_mainSC mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self);
        make.top.and.centerX.equalTo(self);
    }];
    [_view0 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(_mainSC);
        make.top.equalTo(_mainSC);
        make.height.mas_equalTo(kAutoHeight6(77));
    }];
    [_view0LeftView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAutoHeight6(18), kAutoHeight6(18)));
        make.left.equalTo(_view0).offset(kAutoWidth6(12));
        make.centerY.equalTo(_view0);
    }];
    [_view0Title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAutoHeight6(100), kAutoHeight6(25)));
        make.left.equalTo(_view0LeftView.mas_right).offset(kAutoWidth6(5));
        make.centerY.equalTo(_view0);
    }];
    [_tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view0.mas_bottom).offset(kAutoHeight6(4));
        make.width.and.centerX.equalTo(_mainSC);
        make.height.mas_equalTo((_tableArr)?(kAutoHeight6((_tableArr.count-1) * 74+ 64)):0);
    }];
   
    [_view3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(_mainSC);
        make.top.equalTo(_view0.mas_bottom).offset((_tableArr)?(kAutoHeight6((_tableArr.count-1) * 74+ 64 + 8)):kAutoHeight6(8));
        make.height.mas_equalTo(kAutoHeight6(168));
    }];
    
    [_view3Title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view3).offset(kAutoWidth6(12));
        make.top.equalTo(_view3).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(100), kAutoHeight6(16)));
    }];
    [_view3Line mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(_view3);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(_view3).offset(kAutoHeight6(40));
    }];
    [_view3GoodImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoWidth6(80)));
        make.left.equalTo(_view3).offset(kAutoWidth6(12));
        make.top.equalTo(_view3Line).offset(kAutoWidth6(12));
    }];
    [_view3GoodTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view3GoodImg.mas_right).offset(kAutoWidth6(5));
        make.top.equalTo(_view3GoodImg);
        make.right.equalTo(_view3).offset(-kAutoWidth6(12));
        make.height.mas_equalTo(kAutoHeight6(38));
    }];
    [_view3GoodAttr mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_view3GoodTitle.mas_bottom).offset(kAutoHeight6(7));
        make.left.equalTo(_view3GoodTitle);
        make.right.equalTo(_view3GoodTitle);
        make.height.mas_equalTo(kAutoHeight6(15));
    }];
    [_View3AgainBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_view3).offset(-kAutoHeight6(12));
        make.right.equalTo(_view3).offset(-kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(73), kAutoHeight6(25)));
    }];
    
    
    [_view4 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.width.and.centerX.equalTo(_mainSC);
        make.top.equalTo(_view3.mas_bottom).offset(kAutoHeight6(4));
        make.height.mas_equalTo(kAutoHeight6(132));
    }];
    
    
    [_view4OrderNum mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view4).offset(kAutoWidth6(12));
        make.top.equalTo(_view4).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(12)));
    }];
    [_view4PayTime mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view4).offset(kAutoWidth6(12));
        make.top.equalTo(_view4OrderNum.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(12)));
    }];
    [_view4BackMoney mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view4).offset(kAutoWidth6(12));
        make.top.equalTo(_view4PayTime.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(12)));
    }];
    [_view4Address mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view4).offset(kAutoWidth6(12));
        make.top.equalTo(_view4BackMoney.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(12)));
    }];
    [_view4backReason mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_view4).offset(kAutoWidth6(12));
        make.top.equalTo(_view4Address.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(80), kAutoHeight6(12)));
    }];
    
    [_view4OrderNumDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view4).offset(-kAutoWidth6(12));
        make.top.equalTo(_view4).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(280), kAutoHeight6(12)));
    }];
    [_view4PayTimeDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view4).offset(-kAutoWidth6(12));
        make.top.equalTo(_view4OrderNum.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(280), kAutoHeight6(12)));
    }];
    [_view4BackMoneyDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view4).offset(-kAutoWidth6(12));
        make.top.equalTo(_view4PayTime.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(280), kAutoHeight6(12)));
    }];
    [_view4AddressDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view4).offset(-kAutoWidth6(12));
        make.top.equalTo(_view4BackMoney.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(280), kAutoHeight6(12)));
    }];
    [_view4backReasonDetail mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_view4).offset(-kAutoWidth6(12));
        make.top.equalTo(_view4Address.mas_bottom).offset(kAutoWidth6(12));
        make.size.mas_equalTo(CGSizeMake(kAutoWidth6(280), kAutoHeight6(12)));
    }];
    
    
}

@end
