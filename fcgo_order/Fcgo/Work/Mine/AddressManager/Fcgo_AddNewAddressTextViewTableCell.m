//
//  Fcgo_AddNewAddressTextViewTableCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddNewAddressTextViewTableCell.h"

@implementation Fcgo_AddNewAddressTextViewTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}

- (void)setupUI
{
    self.selectionStyle = 0;
    [self.contentView addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(kScreenWidth-24);
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.bottom.mas_offset(-5);
    }];
}

- (Fcgo_UITextView *)textView
{
    if (!_textView) {
        Fcgo_UITextView *textView = [[Fcgo_UITextView alloc]initWithFrame:CGRectMake(8, 0, kScreenWidth-24, 100)];
        textView.placeholderColor = UIFontPlaceholderColor;
        textView.font = UIFontSize(15);
        textView.textColor = UIFontMainGrayColor;
        textView.tintColor = UIFontMainGrayColor;
        textView.scrollEnabled = 0;
        _textView = textView;
    }
    return _textView;
}

@end
