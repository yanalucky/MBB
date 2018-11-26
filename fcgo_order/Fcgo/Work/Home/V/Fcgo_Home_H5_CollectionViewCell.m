//
//  Fcgo_Home_H5_CollectionViewCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/8/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_Home_H5_CollectionViewCell.h"
#import "Fcgo_BasicWebView.h"
@interface Fcgo_Home_H5_CollectionViewCell ()


@property (nonatomic,strong) Fcgo_BasicWebView *webView;
@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end

@implementation Fcgo_Home_H5_CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self.contentView addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_offset(0);
    }];
    
    [self.contentView addSubview:self.activityIndicatorView];
    [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.contentView);
    }];
    self.activityIndicatorView.hidden = YES;
}

- (UIWebView *)webView
{
    WEAKSELF(weakSelf)
    if (!_webView) {
        _webView = [[Fcgo_BasicWebView alloc]initWithFrame:CGRectZero ofStart:^{
            weakSelf.activityIndicatorView.hidden = NO;
            [weakSelf.activityIndicatorView startAnimating];
        } ofSuccess:^{
            weakSelf.activityIndicatorView.hidden = YES;
            [weakSelf.activityIndicatorView stopAnimating];
        } ofFail:^{
            weakSelf.activityIndicatorView.hidden = YES;
            [weakSelf.activityIndicatorView stopAnimating];
        } ofWebViewHeight                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   :^(CGFloat height) {
            if (weakSelf.height == height) {
                return ;
            }
            if(weakSelf.returnHeightBlock)
            {
                weakSelf.returnHeightBlock(height);
                weakSelf.height = height;
            }
        }];
        _webView.scalesPageToFit = 1;
        _webView.scrollView.scrollEnabled = NO;
        _webView.backgroundColor = [UIColor whiteColor];
    }
    return _webView;
}

- (UIActivityIndicatorView *)activityIndicatorView
{
    if (!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectZero];
        _activityIndicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _activityIndicatorView;
}

- (void)setUrlString:(NSString *)urlString {
    _urlString = urlString;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

@end
