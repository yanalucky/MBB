//
//  Fcgo_SiftMainCollectionHeaderView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SiftMainCollectionHeaderView.h"

@implementation Fcgo_SiftMainCollectionHeaderView

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentLeft;
       _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.textColor = UIFontMainGrayColor;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel = label;
    }
    return _descriptionLabel;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        UIImageView *bottomImg = [[UIImageView alloc]init];
        bottomImg.image = [UIImage imageNamed:@"down_icon_arrow"];
        _arrowImageView = bottomImg;
    }
    return _arrowImageView;
}

- (Fcgo_IndexButton *)showBtn
{
    if (!_showBtn) {
        _showBtn = [Fcgo_IndexButton buttonWithType:UIButtonTypeSystem];
       _showBtn.backgroundColor = UIFontClearColor;

       
    }
   return _showBtn;
}

@end
