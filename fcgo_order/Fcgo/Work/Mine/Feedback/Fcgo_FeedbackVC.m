//
//  Fcgo_FeedbackVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_FeedbackVC.h"
#import "Fcgo_FeedBackTableViewCell.h"


@interface Fcgo_FeedbackVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property (nonatomic,strong) UITableView  *table;
@property (nonatomic,strong) NSArray      *titleArray;
@property (nonatomic,assign) NSInteger    currentIndex;
@property (nonatomic,strong) UIButton     *confirmBtn;
@property (nonatomic,strong) Fcgo_UITextView *textView;

@end

@implementation Fcgo_FeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAKSELF(weakSelf)
    [self.navigationView setupBackBtnBlock:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationView setupTitleLabelWithTitle:@"意见反馈"];
    [self setupUI];
}

- (void)setupUI
{
    self.currentIndex = -1;
    self.titleArray = @[@"商品问题",@"功能问题",@"内容问题",@"其它问题"];
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_FeedBackTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"feedBackTableViewCell"];
    [self.view addSubview:self.table];
    
    [self.confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(50));
    }];
}

- (void)confirm
{
    if (self.currentIndex < 0) {
        [WSProgressHUD showImage:nil status:@"请选择问题类型"];
        return;
    }
    
    if (self.textView.text.length<=0) {
        [WSProgressHUD showImage:nil status:@"请输入您的建议"];
        return;
    }
    WEAKSELF(weakSelf)
    NSMutableDictionary  *paremetwers = [NSMutableDictionary dictionary];
    [paremetwers setObjectWithNullValidate:self.titleArray[self.currentIndex] forKey:@"type"];
    [paremetwers setObjectWithNullValidate:self.textView.text forKey:@"message"];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, COMMONMETHOD, @"suggest") parametersContentCommon:paremetwers successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [WSProgressHUD showSuccessWithStatus:@"反馈成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }
    } failureBlock:^(NSString *description) {}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.titleArray count];
   }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WEAKSELF(weakSelf)
    Fcgo_FeedBackTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"feedBackTableViewCell"];
    cell.titleString = self.titleArray[indexPath.row];
    
    if (self.currentIndex == indexPath.row) {
        cell.checked = 1;
    }else{
        cell.checked = 0;
    }
    cell.feedBackBlock = ^(Fcgo_IndexButton *btn)
    {
        if (btn.select) {
            weakSelf.currentIndex = indexPath.row;
        }
        else{
            weakSelf.currentIndex = -1;
        }
        [weakSelf.table reloadData];
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(45);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_FeedBackTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell.checked) {
        cell.checked = 1;
    }
    else{
        self.currentIndex = indexPath.row;
    }
    [self.table reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kAutoWidth6(30);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *titleArray = @[@"问题类型",@"意见描述"];
    UIView *headView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kAutoWidth6(35))];
    headView.backgroundColor = UIBackGroundColor;
    
    UILabel *titlelabel = [[UILabel alloc]init];
    titlelabel.frame = CGRectMake(15, 0, kScreenWidth-30, kAutoWidth6(30));
    titlelabel.textColor = UIFontRedColor;
    titlelabel.backgroundColor = UIFontClearColor;
    titlelabel.font = UIFontSize(13);
    titlelabel.numberOfLines = 2;
    titlelabel.text = titleArray[section];
    [headView addSubview:titlelabel];
    return headView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
    footerView.backgroundColor = UIBackGroundColor;
    return footerView;
}

#pragma mark Lazy method

- (UITableView *)table
{
    WEAKSELF(weakSelf)
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight - kAutoWidth6(50)) style:UITableViewStylePlain];
        table.backgroundColor = UIBackGroundColor;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        UIView *footerView   = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kAutoWidth6(100)+60)];
        Fcgo_UITextView *textView = [[Fcgo_UITextView alloc]initWithFrame:CGRectMake(8, 0, kScreenWidth-24, kAutoWidth6(100))];
        textView.placeholder = @"请输入您的建议";
        textView.font = UIFontSize(14);
        textView.delegate = self;
        textView.placeholderColor = UIFontPlaceholderColor;
        [footerView addSubview:weakSelf.textView = textView];
        
        UIView *footerView1   = [[UIView alloc]initWithFrame:CGRectMake(0, kAutoWidth6(100), kScreenWidth, 60)];
        footerView1.backgroundColor = UIBackGroundColor;
        
        UILabel *titlelabel = [[UILabel alloc]init];
        titlelabel.frame = CGRectMake(15, 10, kScreenWidth-30, 50);
        titlelabel.textColor = UIFontMiddleGrayColor;
        titlelabel.backgroundColor = UIBackGroundColor;
        titlelabel.font = UIFontSize(13);
        titlelabel.numberOfLines = 0;
        titlelabel.text = @"我们致力于创造更好的购物体验，因此我们重视您的每一条宝贵的建议，并努力完善，感谢您为此付出的关心和支持!";
        [footerView1 addSubview:titlelabel];
        [footerView addSubview:footerView1];
        footerView.backgroundColor = UIFontWhiteColor;
        table.tableFooterView = footerView;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if(textView.text.length==200){
        if ([text isEqualToString:@""]) {
            return YES;
            }else
            return NO;
    }else
        return YES;
}

- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        _confirmBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _confirmBtn.titleLabel.font = UIFontSize(16);
        [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIFontRedColor];
    }
    return _confirmBtn;
}

@end
