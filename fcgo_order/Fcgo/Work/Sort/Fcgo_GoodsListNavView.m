 //
//  Fcgo_GoodsListNavView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsListNavView.h"

@interface Fcgo_GoodsListNavView ()<UITextFieldDelegate>


@property (nonatomic,strong) Fcgo_IndexButton    *backBtn,*changeShowListBtn,*cancelBtn;
@property (nonatomic,strong) UIImageView *searchImageView;
@property (nonatomic,strong) UIControl   *searchTextField;

@property (nonatomic,strong) UIView      *searchView;

@end

@implementation Fcgo_GoodsListNavView

- (instancetype)initWithFrame:(CGRect)frame
                         back:(void(^)(void))backBlock
                   changeList:(void(^)(BOOL selected))changeListBlock
                       search:(void(^)(NSString *string))searchBlock
{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.backBlock = backBlock;
        self.changeListBlock = changeListBlock;
        self.searchBlock = searchBlock;
        
        self.searchView.layer.cornerRadius = 15;
        self.searchView.layer.masksToBounds = YES;
        
        [self addSubview:self.searchView];
        [self.searchView addSubview:self.searchImageView];
        [self.searchView addSubview:self.searchTextField];
        [self.searchView addSubview:self.textLabel];

        [self.searchTextField addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:self.backBtn];
        [self addSubview:self.changeShowListBtn];
        [self addSubview:self.cancelBtn];
        
        [self.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        [self.changeShowListBtn addTarget:self action:@selector(change) forControlEvents:UIControlEventTouchUpInside];
        [self.cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        
        [self setupUI];
    }
    return self;
}

- (void)back
{
    if (self.backBlock) {
        self.backBlock();
    }
}

- (void)touch
{
    if (self.searchBlock) {
        self.searchBlock(@"");
    }
}

- (void)change
{
    self.changeShowListBtn.select = !self.changeShowListBtn.select;
    if (self.changeShowListBtn.select) {
       [_changeShowListBtn setBackgroundImage:[UIImage imageNamed:@"collection_goodlist"]forState:UIControlStateNormal];
    }else{
        [_changeShowListBtn setBackgroundImage:[UIImage imageNamed:@"table_goodlist"]forState:UIControlStateNormal];
    }
    if (self.changeListBlock) {
        self.changeListBlock(self.changeShowListBtn.select);
    }
}

- (void)cancel
{
    WEAKSELF(weakSelf)
    self.cancelBtn.alpha = 0;
    [self.searchTextField resignFirstResponder];
    [UIView animateWithDuration:0.4 animations:^{
        weakSelf.backBtn.frame = CGRectMake(8, 5, 34, 34);
        weakSelf.backBtn.alpha = 1;
        weakSelf.cancelBtn.alpha = 0;
        weakSelf.searchView.frame = CGRectMake(self.backBtn.mj_x+self.backBtn.mj_w, 7, self.mj_w - 92, 30);
    }completion:^(BOOL finished) {
        weakSelf.changeShowListBtn.alpha = 1;
    }];
}

- (void)setupUI
{
    self.backBtn.frame = CGRectMake(0, 5, 34, 34);
    self.searchView.frame = CGRectMake(self.backBtn.mj_x+self.backBtn.mj_w+4, 7, self.mj_w - 92, 30);
    self.searchImageView.frame = CGRectMake(7, 7, 16, 16);
    self.searchTextField.frame = CGRectMake(7+16+kAutoWidth6(8), 0, self.searchView.mj_w - (7+16+kAutoWidth6(8)), 30);
    self.textLabel.frame = CGRectMake(7+16+kAutoWidth6(8), 0, self.searchView.mj_w - (7+16+kAutoWidth6(8)), 30);
    self.changeShowListBtn.frame = CGRectMake(kScreenWidth - 41, 10, 26, 26);
    self.cancelBtn.frame = CGRectMake(kScreenWidth - 52, 5, 52, 34);
    self.cancelBtn.alpha = 0;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.changeShowListBtn.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.backBtn.alpha = 0;
        self.backBtn.frame = CGRectMake(8, 5, 0, 34);
        self.searchView.frame = CGRectMake(12, 7, self.mj_w - 52-12, 30);
    }completion:^(BOOL finished) {
        self.cancelBtn.alpha = 1;
    }];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self cancel];
   
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

- (UIControl *)searchTextField
{
    if (!_searchTextField) {
        _searchTextField = [[UIControl alloc]init];
    }
    return _searchTextField;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *lab = [[UILabel alloc]init];
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = UIRGBColor(183,183,200, 1);
        lab.textAlignment = NSTextAlignmentLeft;
        lab.text = @"搜索商品 分类 功效 用户";
        _textLabel = lab;
    }
    return _textLabel;
}

- (Fcgo_IndexButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
        [_backBtn setBackgroundImage:[UIImage imageNamed:@"ico_back"]forState:UIControlStateNormal];
    }
    return _backBtn;
}

- (Fcgo_IndexButton *)changeShowListBtn
{
    if (!_changeShowListBtn) {
        _changeShowListBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
        //[_changeShowListBtn setImage: [UIImage imageNamed:@"table_goodsList"]forState:UIControlStateNormal];
        [_changeShowListBtn setBackgroundImage:[UIImage imageNamed:@"table_goodlist"]forState:UIControlStateNormal];
    }
    return _changeShowListBtn;
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
