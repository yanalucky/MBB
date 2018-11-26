//
//  Home_WholePointDetailCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/13.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Home_WholePointDetailCell.h"

@interface Home_WholePointDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImg;
@property (weak, nonatomic) IBOutlet UILabel     *goodsName;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel     *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel     *goodsNormalPrice;
@property (weak, nonatomic) IBOutlet UIButton    *endBtn;
@property (weak, nonatomic) IBOutlet UIButton    *buyBtn;
@property (weak, nonatomic) IBOutlet Fcgo_IndexButton *remindBtn;
@property (weak, nonatomic) IBOutlet UIView      *bottomView;



@end

@implementation Home_WholePointDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    [self.goodsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.height.width.mas_offset(80);
    }];
    [self.goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.goodsImg.mas_top).mas_offset(0);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
        make.right.mas_offset(-15);
    }];
    self.goodsName.numberOfLines = 2;
    
    self.goodsName.textColor = UIFontMainGrayColor;
    self.goodsName.font = UIFontSize(15);
    
    [self.goodsNormalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
    }];
    self.goodsNormalPrice.textColor = UIFontMiddleGrayColor;
    self.goodsNormalPrice.font = UIFontSize(12);
    
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsNormalPrice.mas_top).mas_offset(-8);
        make.left.mas_equalTo(weakSelf.goodsImg.mas_right).mas_offset(8);
    }];
    
    self.goodsPriceLabel.textColor = UIFontRedColor;
    self.goodsPriceLabel.font = UIFontSize(12);
    
    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsNormalPrice.mas_top).mas_offset(-8);
        make.left.mas_equalTo(weakSelf.goodsPriceLabel.mas_right).mas_offset(2);
    }];
    
    self.goodsPrice.textColor = UIFontRedColor;
    self.goodsPrice.font = UIFontSize(17);
    
    [self.endBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.right.mas_offset(-15);
        make.height.mas_offset(30);
        make.width.mas_offset(70);
    }];
    
    [self.endBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.right.mas_offset(-15);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    self.endBtn.backgroundColor = UIRGBColor(170, 170, 170, 1);
    [self.endBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    self.endBtn.enabled = NO;
    self.endBtn.layer.cornerRadius = 3;
    self.endBtn.layer.masksToBounds = 1;
    
    [self.buyBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.right.mas_offset(-15);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    self.buyBtn.backgroundColor = UIFontRedColor;
    [self.buyBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    self.buyBtn.layer.cornerRadius = 3;
    self.buyBtn.layer.masksToBounds = 1;
    
    [self.remindBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.goodsImg.mas_bottom).mas_offset(0);
        make.right.mas_offset(-15);
        make.height.mas_offset(25);
        make.width.mas_offset(70);
    }];
    self.remindBtn.backgroundColor = UIStringColor(@"#ffb100");
    [self.remindBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
    self.remindBtn.layer.cornerRadius = 3;
    self.remindBtn.layer.borderColor = UIStringColor(@"#ffb100").CGColor;
    self.remindBtn.layer.borderWidth = 0.5;
    self.remindBtn.layer.masksToBounds = 1;
    
    self.bottomView.backgroundColor = UISepratorLineColor;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
}

- (void)setType:(WholePointType)type
{
    self.remindBtn.hidden = 1;
    self.buyBtn.hidden    = 1;
    self.endBtn.hidden    = 1;
    if (type == WholePointEndType)
    {
        self.endBtn.hidden    = 0;
    }
    else if (type == WholePointStartType)
    {
        self.buyBtn.hidden    = 0;
    }
    else if (type == WholePointNotStartType)
    {
        self.remindBtn.hidden = 0;
    }
    NSMutableArray *saveArray = [NSMutableArray array];
    NSArray   *array = [OBJC_Defaults objectForKey:@"integral"];
    if (array) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [saveArray addObject:obj];
        }];
    }
    for (int i = 0; i < saveArray.count; i ++) {
        NSDictionary *calendarDict = saveArray[i];
        if ([calendarDict[@"integral_id"] isEqualToNumber:self.model.f_integral_id] && type != WholePointNotStartType) {
            [saveArray removeObject:calendarDict];
            self.remindBtn.select = NO;
            self.remindBtn.backgroundColor = UIStringColor(@"#ffb100");
            [self.remindBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
            
        }
        else if ([calendarDict[@"integral_id"] isEqualToNumber:self.model.f_integral_id] && type == WholePointNotStartType) {
            self.remindBtn.select = YES;
            self.remindBtn.backgroundColor = UIFontWhiteColor;
            [self.remindBtn setTitleColor:UIStringColor(@"#ffb100") forState:UIControlStateNormal];
        }
    }
}

- (void)setModel:(Fcgo_WholePointGoodsModel *)model
{
    _model = model;
    [self.goodsImg sd_setImageWithURL:[NSURL URLWithString:model.picurl] placeholderImage:[UIImage imageNamed:@"580X580"]];
    self.goodsName.text = model.goodsName;
    NSString *goodsPrice = [NSString stringWithFormat:@"%.2f",round([model.bisIntegralPriceSupYUAN floatValue]*100)/100];
    self.goodsPrice.text = [NSString stringWithFormat:@"¥ %@",goodsPrice];
    self.goodsNormalPrice.text = [NSString stringWithFormat:@"¥ %@",model.supPrice];
}

- (IBAction)buy:(UIButton *)sender
{
    if (self.selectedBlock)
    {
        self.selectedBlock(self.model);
    }
}

- (IBAction)remind:(Fcgo_IndexButton *)sender
{
    NSNumber *type;
    if (self.type == WholePointEndType)
    {
        type = @3;
    }
    else if (self.type == WholePointStartType)
    {
        type = @2;
    }
    else if (self.type == WholePointNotStartType)
    {
        type = @0;
    }
    NSMutableArray *saveArray = [NSMutableArray array];
    NSArray   *array = [OBJC_Defaults objectForKey:@"integral"];
    if (array) {
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [saveArray addObject:obj];
        }];
    }
    if (!sender.select)
    {
       [[Fcgo_CalendarTools shared]saveEventwithWholePointModel:self.pointModel goodsModel:self.model block:^{
           sender.select = !sender.select;
           self.remindBtn.backgroundColor = UIFontWhiteColor;
           [self.remindBtn setTitleColor:UIStringColor(@"#ffb100") forState:UIControlStateNormal];
           [WSProgressHUD showImage:nil status:@"设置成功"];
           
           for (int i = 0; i < saveArray.count; i ++) {
               NSDictionary *calendarDict = saveArray[i];
               if ([calendarDict[@"integral_id"] isEqualToNumber:self.model.f_integral_id]) {
                   [saveArray removeObject:calendarDict];
               }
           }
           NSDictionary *calendarDict = @{@"integral_id":self.model.f_integral_id,@"type":type};
           [saveArray addObject:calendarDict];
           [OBJC_Defaults setObject:saveArray forKey:@"integral"];
           [OBJC_Defaults synchronize];
       }];
    }
    else
    {
        [[Fcgo_CalendarTools shared]deleteEventwithWholePointModel:self.pointModel goodsModel:self.model block:^{
            sender.select = !sender;
            self.remindBtn.backgroundColor = UIStringColor(@"#ffb100");
            [self.remindBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
            [WSProgressHUD showImage:nil status:@"取消成功"];
            for (int i = 0; i < saveArray.count; i ++) {
                NSDictionary *calendarDict = saveArray[i];
                if ([calendarDict[@"integral_id"] isEqualToNumber:self.model.f_integral_id]) {
                    [saveArray removeObject:calendarDict];
                }
            }
             [OBJC_Defaults setObject:saveArray forKey:@"integral"];
             [OBJC_Defaults synchronize];
        }];
    }
}

@end
