//
//  Fcgo_BasicWebView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicWebView.h"
//#import <VasSonic/Sonic.h>
@interface Fcgo_BasicWebView()//<SonicSessionDelegate>
@property (nonatomic, strong) NSURLRequest *customRequest;
@end

@implementation Fcgo_BasicWebView

- (instancetype)initWithFrame:(CGRect)frame
                      ofStart:(LoadStartBlock )startBlock
                    ofSuccess:(LoadSuccessBlock )successBlock
                       ofFail:(LoadFailBlock )failBlock {
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.startBlock   = startBlock;
        self.successBlock = successBlock;
        self.failBlock    = failBlock;
        
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                      ofStart:(LoadStartBlock )startBlock
                    ofSuccess:(LoadSuccessBlock )successBlock
                       ofFail:(LoadFailBlock )failBlock
              ofWebViewHeight:(void(^)(CGFloat height))returnHeightBlock {
    self=[super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.startBlock   = startBlock;
        self.successBlock = successBlock;
        self.failBlock    = failBlock;
        self.returnHeightBlock = returnHeightBlock;
        
        [self setup];
    }
    return self;
}

- (void)setup {
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
//    [NSURLProtocol registerClass:[SonicURLProtocol class]];
}

- (void)dealloc {
    
//    [[SonicClient sharedClient] removeSessionWithWebDelegate:self];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSString *requestString = [[[request URL] absoluteString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //NSLog(@"===首页的H5==%@",requestString);
    if (![Fcgo_Tools isNullString:requestString]) {
        if ([requestString isEqualToString:self.urlString]) {
            
            return YES;
        }
    }
    if ([requestString containsString:@"app_across="]) {
        return [Fcgo_App_acrossTools app_acrossWithJsonString:requestString webView:webView parentVC:[Fcgo_Tools topViewController]];
    }
    if ([requestString hasPrefix:@"tel:"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:requestString]];
        return NO;
    }
    if (self.homeDetailBlock)
    {
        NSString *urlString = requestString;
        
        if ([requestString containsString:@"?"]) {
            if (![requestString containsString:@"merId="]) {
                urlString = [NSString stringWithFormat:@"%@&merId=%@",urlString, MerId];
            }
            if (![requestString containsString:@"token="]) {
                urlString = [NSString stringWithFormat:@"%@&token=%@",urlString,Token];
            }
        }else{
            urlString = [NSString  stringWithFormat:@"%@?merId=%@&token=%@",requestString, MerId,Token];
        }
        //NSLog(@"===首页的H51==%@",urlString);
        self.homeDetailBlock(urlString);
        return NO;
    }
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    if (self.startBlock) {
        self.startBlock();
    }
}

- (void) webViewDidFinishLoad:(UIWebView *)webView {
    [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    [self stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
    if (self.successBlock) {
        self.successBlock();
    }
    
    if(self.returnHeightBlock)
    {
//        CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight;"] floatValue];
//        self.returnHeightBlock(height);
    }
    if (@available(iOS 11.0, *)) {
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    if (self.failBlock) {
        self.failBlock();
    }
    if ([error code] == NSURLErrorCancelled) return;
    [WSProgressHUD showErrorWithStatus:@"网络请求失败"];
}

- (void)setUrlString:(NSString *)urlString {
    if (self.customRequest) {
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.customRequest];
    }
    _urlString = urlString;
    self.customRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5];
    [self loadRequest:self.customRequest];
//    [[SonicClient sharedClient] createSessionWithUrl:urlString withWebDelegate:self];
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    if ([[SonicClient sharedClient] sessionWithWebDelegate:self]) {
//        [self loadRequest:sonicWebRequest(request)];
//    } else {
//        [self loadRequest:request];
//    }
}

- (void)reload {
    self.urlString = self.request.URL.absoluteString;
    [super reload];
}

#pragma mark - Sonic Session Delegate
//- (void)sessionWillRequest:(SonicSession *)session {
//    
//}
//
//- (void)session:(SonicSession *)session requireWebViewReload:(NSURLRequest *)request {
//    
//}


@end
