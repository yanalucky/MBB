//
//  Fcgo_FromHomeWebVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_FromHomeWebVC.h"

@interface Fcgo_FromHomeWebVC ()

@end

@implementation Fcgo_FromHomeWebVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.scrollView.scrollEnabled = !self.scroll;
}

@end
