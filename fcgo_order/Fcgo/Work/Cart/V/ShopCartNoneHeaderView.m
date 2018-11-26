//
//  ShopCartNoneHeaderView.m
//  Fcg
//
//  Created by huafanxiao on 2017/4/13.
//  Copyright © 2017年 zgntech. All rights reserved.
//

#import "ShopCartNoneHeaderView.h"

@implementation ShopCartNoneHeaderView
- (UILabel *)likeLabel {
    if (!_likeLabel) {
        _likeLabel = [[UILabel alloc]init];
        _likeLabel.font = UIFontSize(14);
        _likeLabel.text = @"猜您喜欢";
        _likeLabel.textColor = UIStringColor(@"#555555");
    }
    return _likeLabel;
}

- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc]init];
        _imgView.image = [UIImage imageNamed:@"like-"];
    }
    return _imgView;
}
@end
