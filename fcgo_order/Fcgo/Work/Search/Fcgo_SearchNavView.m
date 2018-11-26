//
//  Fcgo_SearchNavView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/14.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SearchNavView.h"

@interface Fcgo_SearchNavView ()<UITextFieldDelegate>


@property (nonatomic,strong) Fcgo_IndexButton *cancelBtn;
@property (nonatomic,strong) UIImageView *searchImageView;

@property (nonatomic,strong) UIView      *searchView;

@end

@implementation Fcgo_SearchNavView

- (instancetype)initWithFrame:(CGRect)frame
                       cancel:(void(^)(void))cancelBlock
                        start:(void(^)(BOOL containText,NSString *string))startBlock
                       search:(void(^)(NSString *string))searchBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.cancelBlock = cancelBlock;
        self.searchBlock = searchBlock;
        self.startBlock  = startBlock;
        self.searchView.layer.cornerRadius = 15;
        self.searchView.layer.masksToBounds = YES;
        
        [self addSubview:self.searchView];
        [self.searchView addSubview:self.searchImageView];
        [self.searchView addSubview:self.searchTextField];
        [self.searchTextField addTarget:self action:@selector(change) forControlEvents:UIControlEventEditingChanged];
        
        self.searchTextField.delegate = self;

        [self addSubview:self.cancelBtn];
        [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
//    self.searchView.frame = CGRectMake(12, 7, self.mj_w - 52-12, 30);
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
        make.right.mas_equalTo(self.cancelBtn.mas_left);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_equalTo(0);
        make.width.mas_equalTo(52);
    }];
    [self.searchView layoutIfNeeded];
    self.searchImageView.frame = CGRectMake(7, 7, 16, 16);
    self.searchTextField.frame = CGRectMake(7+16+kAutoWidth6(8), 0, self.searchView.mj_w - (7+16+kAutoWidth6(8)), 30);
//    self.cancelBtn.frame = CGRectMake(kScreenWidth - 52, 5, 52, 34);
}

- (void)change
{
    if (self.searchTextField.text.length <= 0) {
        if (self.startBlock) {
            self.startBlock(NO,self.searchTextField.text);
        }
    }else{
        if (self.startBlock) {
            self.startBlock(YES,self.searchTextField.text);
        }
    }
}

- (void)cancel
{
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.searchBlock) {
        self.searchBlock(textField.text);
    }
    return YES;
}

- (UIView *)searchView
{
    if (!_searchView) {
        _searchView = [[UIView alloc]init];
        _searchView.backgroundColor = UIRGBColor(240, 240, 240, 1);
    }
    return _searchView;
}

- (UIImageView *)searchImageView
{
    if (!_searchImageView) {
        _searchImageView = [[UIImageView alloc]init];
        _searchImageView.image = [UIImage imageWithName:@"b_search" ofType:@"png"];
    }
    return _searchImageView;
}

- (UITextField *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc]init];
        _searchTextField.font = [UIFont systemFontOfSize:13];
        _searchTextField.textColor = UIFontMainGrayColor;
        _searchTextField.tintColor = UIFontMainGrayColor;
        _searchTextField.clearButtonMode = UITextFieldViewModeAlways;
        _searchTextField.textAlignment = NSTextAlignmentLeft;
        _searchTextField.returnKeyType = UIReturnKeySearch;
        _searchTextField.placeholder = @"搜索商品 分类 功效 用户";
    }
    return _searchTextField;
}

- (Fcgo_IndexButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _cancelBtn;
}
@end

