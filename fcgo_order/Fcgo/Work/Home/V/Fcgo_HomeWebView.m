//
//  Fcgo_HomeWebView.m
//  Fcgo
//
//  Created by fcg on 2017/9/22.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeWebView.h"
#import "Fcgo_BasicWebView.h"

@interface Fcgo_HomeWebView ()


@property (nonatomic,strong) UIActivityIndicatorView *activityIndicatorView;

@end
@implementation Fcgo_HomeWebView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self addSubview:self.webView];
        [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.right.mas_offset(0);
        }];
        
        [self addSubview:self.activityIndicatorView];
        [self.activityIndicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self);
        }];
        self.activityIndicatorView.hidden = YES;
    }
    
    return self;
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
            _webView.homeDetailBlock = ^(NSString *str){
                
                if (weakSelf.detailBlock) {
                    weakSelf.detailBlock(str);
                }
                
            };
        } ofFail:^{
            weakSelf.activityIndicatorView.hidden = YES;
            [weakSelf.activityIndicatorView stopAnimating];
            !weakSelf.failBlock?:weakSelf.failBlock();
        } ofWebViewHeight:^(CGFloat height) {
            
            //NSLog(@">>>>>>>%f",height);
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
        _webView.scrollView.scrollEnabled = YES;
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

- (void)setUrlString:(NSString *)urlString
{
    
    _urlString = urlString;
    if (self.parentVC) {
        self.webView.parentVC = self.parentVC;
    }
    [self.webView setUrlString:urlString];
}


@end
