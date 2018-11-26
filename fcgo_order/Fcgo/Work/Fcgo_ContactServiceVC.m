//
//  Fcgo_ContactServiceVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/3.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ContactServiceVC.h"
#import "Fcgo_ContactServiceCell.h"

@interface Fcgo_ContactServiceVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *table;
@property (nonatomic,strong) NSArray      *titleArray;

@end

@implementation Fcgo_ContactServiceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"联系我们"];
   
    
    NSString *tel = [Fcgo_UserTools shared].tel;
    //前边三个
    NSString *tel1  = [tel substringToIndex:3];
    NSString *tel2 =  [tel substringFromIndex:3];
    //中间三个
    NSString *tel3 = [tel2 substringToIndex:3];
    //后边四个
    NSString *tel4 =  [tel2 substringFromIndex:3];
    NSString *phone  = [NSString stringWithFormat:@"%@-%@-%@",tel1,tel3,tel4];
    
    self.titleArray = @[
                        //@[@"icon_wechat-",@"微信: ddhkfzh"],
                        //@[@"icon_qq-",@"Q  Q: 2753723503"],
                        @[@"icon_lxkf", @"联系客服"],
                        @[@"icon_hotline",[NSString stringWithFormat:@"电话: %@",phone]]
                        ];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_ContactServiceCell class]) bundle:nil] forCellReuseIdentifier:@"contactServiceCell"];
    [self.view addSubview:self.table];
}
    
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_ContactServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactServiceCell"];
    if (self.titleArray.count>0) {
        cell.titleString = self.titleArray[indexPath.row][1];
        cell.iconImageView.image = [UIImage imageNamed:self.titleArray[indexPath.row][0]];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
if (indexPath.row == 0) {
//    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//    [pasteboard setString:@"2753723503"];
//    [WSProgressHUD showSuccessWithStatus:@"微信号已复制\n请打开手机微信联系我们"];
    [[Fcgo_QYIM_JumpTools sharedInstance] qy_jumpWithTitle:nil
                                                 urlString:nil
                                                customInfo:nil
                                              sessionTitle:nil
                                   commodityInfoDictionary:nil];
}
else if (indexPath.row == 1) {
//    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
//    [pasteboard setString:@"2753723503"];
//    [WSProgressHUD showSuccessWithStatus:@"QQ已复制\n请打开手机QQ联系我们"];
    UIWebView *webview = [[UIWebView alloc] init];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[Fcgo_UserTools shared] tel]]]]];
    [[[UIApplication sharedApplication] keyWindow] addSubview:webview];

}
else if (indexPath.row == 2) {
//    UIWebView *webview = [[UIWebView alloc] init];
//    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[[Fcgo_UserTools shared] tel]]]]];
//    [[[UIApplication sharedApplication] keyWindow] addSubview:webview];
//    [[Fcgo_QYIM_JumpTools sharedInstance] qy_jumpWithTitle:nil
//                                urlString:nil
//                               customInfo:nil
//                             sessionTitle:nil];
}
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    footerView.backgroundColor = UINavSepratorLineColor;
    return footerView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight) style:UITableViewStylePlain];
        table.backgroundColor = UIFontWhiteColor;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end
