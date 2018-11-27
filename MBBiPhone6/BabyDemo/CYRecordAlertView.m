//
//  CYRecordAlertView.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/11.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "CYRecordAlertView.h"

@implementation CYRecordAlertView{
    
    UIView *view;
    
    UILabel *_title;
    UILabel *_detailTitle;
    UIButton *_button;
    
    int _isButton;
    
    UIButton *cancel;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
       self.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
        
        
        self.userInteractionEnabled = YES;
        
        [self makeAlertView];
        _isButton = 0;
        
    }
    
    
    return self;
}

-(void)makeAlertView{
    
    
    view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    view.layer.masksToBounds = YES;
    view.userInteractionEnabled = YES;
    view.layer.cornerRadius = 15*Ratio;
    [self addSubview:view];
    _title = [[UILabel alloc] init];
    [_title makeLabelWithText:nil andTextColor:MBColor(250, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    _title.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_title];
    
    
    _detailTitle = [[UILabel alloc] init];
    [_detailTitle makeLabelWithText:@"" andTextColor:MBColor(102, 103, 104, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    _detailTitle.textAlignment = NSTextAlignmentCenter;
    _detailTitle.numberOfLines = 0;
    [view addSubview:_detailTitle];
    
    
    _button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //50  20
    
    
    
    [view addSubview:_button];
    
    
    
    cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setBackgroundImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:cancel];
    
    
}

-(void)buttonAction:(UIButton *)button{
    
    self.hidden = YES;
    
    [self.window sendSubviewToBack:self];
    
    if (self.payBlocks) {
        self.payBlocks();
    }
}
-(void)cancelAction:(UIButton *)button{
    
    
    self.hidden = YES;
    
    [self.window sendSubviewToBack:self];
    
    
    
    if (self.clickBlocks) {
        self.clickBlocks();
    }
}

#pragma mark -弹出框

-(void)alertViewWith:(NSString *)title andDetailTitle:(NSString *)detailTitle andButtonTitle:(NSString *)buttonTitle{
//    CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
    
    _title.text = title;
    _detailTitle.text = detailTitle;
//    NSForegroundColorAttributeName
    _isButton = [buttonTitle intValue];
    
//    NSLog(@"_detailTitle.text .length = %d",_detailTitle.text.length);
    if (_detailTitle.text.length > 40) {
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:_detailTitle.text];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(0, 1)];
        [attributeStr addAttribute:NSForegroundColorAttributeName value:MBColor(250, 109, 166, 1) range:NSMakeRange(24, 11)];
        _detailTitle.attributedText = attributeStr;
    }
#pragma mark = 1 代表：续费
    if (_isButton > 0) {
        
        [_button setBackgroundImage:[UIImage imageNamed:@"btn_chouti_info_goumai"] forState:UIControlStateNormal];

        [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        if (_isButton == 1) {
            [_button setTitle:@"续费" forState:UIControlStateNormal];
        }else{

            [_button setTitle:@"购买" forState:UIControlStateNormal];
        }
    }else{
        [_button setTitle:@"" forState:UIControlStateNormal];

    }
    self.hidden = NO;
    [self.window bringSubviewToFront:self];
    
    self.payBlocks = nil;
    self.clickBlocks = nil;
}





-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    UITouch *touch = [touches anyObject];
    
    self.hidden = YES;
//    for (int i=0; i<[self.subviews count]; i++) {
//        UIView *ve = self.subviews[i];
//        [ve removeFromSuperview];
//    }
    [self.window sendSubviewToBack:self];

    
    if (self.clickBlocks) {
        self.clickBlocks();
    }
    
    
}
-(void)layoutSubviews{
    
    
    NSMutableDictionary *attri = [[NSMutableDictionary alloc] init];
    attri[NSFontAttributeName] = [UIFont yaHeiFontOfSize:13*Ratio];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    attri[NSParagraphStyleAttributeName] = paragraphStyle;
    CGRect rect = [_detailTitle.text boundingRectWithSize:CGSizeMake(200*Ratio, 30000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    
    
    [view mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(244*Ratio, rect.size.height + (60*Ratio)));
        make.center.equalTo(self);
    }];
    
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 17*Ratio));
        make.centerX.equalTo(view);
        make.top.equalTo(view).offset(10*Ratio);
    }];
    
    
    [_detailTitle mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(220*Ratio, rect.size.height));
        make.top.equalTo(_title.mas_bottom).offset(5*Ratio);
        make.centerX.equalTo(view);
    }];
    
    
    [_button mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*Ratio, (_isButton > 0)?20*Ratio:0));
        make.centerX.equalTo(view);
        make.bottom.equalTo(view).offset(-8*Ratio);
    }];
    
    
    
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view).offset(10*Ratio);
        make.right.equalTo(view).offset(-10*Ratio);
        make.size.mas_equalTo(CGSizeMake(10*Ratio, 10*Ratio));
    }];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
