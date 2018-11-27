//
//  AddOtherViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "AddOtherViewController.h"
#import "AddOtherTableViewCell.h"
#import "AddOldRecord.h"
#import "RecordStarBabyBeforeRecord.h"

#import "NetRequestManage.h"
#import "CYRecordAlertView.h"

#import "LeftViewController.h"
#import "RickyNavViewController.h"
#import "AppDelegate.h"

@interface AddOtherViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>{
    UITableView *_tableView;
    UIButton *_rightBtn;
    float chaZhi;
    
    NSMutableArray *_dataArr;
    UITextField *_actionField;
}

@end

@implementation AddOtherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    _actionField = [[UITextField alloc] init];
    
    self.navigationController.navigationBarHidden = NO;
    self.title = @"补充记录";
    self.view.backgroundColor = [UIColor whiteColor];
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 39*Ratio, 20*Ratio);
    [_rightBtn setTitle:@"提交" forState:UIControlStateNormal];
    
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_rightBtn addTarget:self action:@selector(commit:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    _rightBtn.enabled = YES;
    
    
    _dataArr = [[NSMutableArray alloc] init];
    
    if (_breakArr) {
        if (_breakArr.count > 0 ) {
            for (int i=0; i<[_breakArr count]; i++) {
                AddOldRecord *oldRecord = [[AddOldRecord alloc] init];
                oldRecord.bodyLength = [NSString stringWithFormat:@"%.2f",0.00];
                oldRecord.weight = [NSString stringWithFormat:@"%.2f",0.00];
                [_dataArr addObject:oldRecord];
                
            }
            [self createTableView];
            
            return;
        }
    }
    for (int i=1; i<[_firstAge intValue]; i++) {
        AddOldRecord *oldRecord = [[AddOldRecord alloc] init];
        oldRecord.bodyLength = [NSString stringWithFormat:@"%.2f",0.00];
        oldRecord.weight = [NSString stringWithFormat:@"%.2f",0.00];
        [_dataArr addObject:oldRecord];

    }
    
    if(_babyBeforeRecord){
        if (_babyBeforeRecord.count > 0) {
            
            for (RecordStarBabyBeforeRecord *babyBefore in _babyBeforeRecord) {
                AddOldRecord *oldRecord = [[AddOldRecord alloc] init];
                oldRecord.bodyLength = babyBefore.height;
                oldRecord.weight = babyBefore.weight;
                [_dataArr replaceObjectAtIndex:([babyBefore.age intValue]-1) withObject:oldRecord];
                
            }
            
        }
    }
    
    
    [self createTableView];
    // Do any additional setup after loading the view.
}

#pragma mark - 提交按钮

-(void)commit:(UIButton *)button{
//    NSLog(@"点击");
    [self.view endEditing:YES];
    NSMutableArray *babyboforeFillArr = [[NSMutableArray alloc] init];
    for (int i=0; i<_dataArr.count; i++) {
//        AddOtherTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        AddOldRecord *record = _dataArr[i];
        if (([record.bodyLength intValue] != 0)||([record.weight intValue] != 0)) {
            if (([record.bodyLength intValue] != 0)&&([record.weight intValue] != 0)) {
                
                NSDictionary *dic = [[NSDictionary alloc] initWithObjectsAndKeys:(_breakArr)?(_breakArr[i]):[NSString stringWithFormat:@"%d",i+1],@"age",record.bodyLength,@"height",record.weight,@"weight",nil];
                
                [babyboforeFillArr addObject:dic];
            }else{
                
                CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
                
                [alert alertViewWith:@"提示！" andDetailTitle:[NSString stringWithFormat:@"请补足%@个月的身长体重",(_breakArr)?(_breakArr[i]):[NSString stringWithFormat:@"%d",i+1]] andButtonTitle:@"0"];
                [alert layoutSubviews];
                
                alert.clickBlocks = ^(void){
                    
                };
                return;
            }
        }
        
    }
//    NSLog(@"babyboforeFillArr = %@",babyboforeFillArr);
    
    [NetRequestManage saveBeforeRecordWithUserId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] andUserRole:[[NSUserDefaults standardUserDefaults] objectForKey:@"userRole"] andNeedInsertBeforeRecordArr:babyboforeFillArr isBreakMonth:(_breakArr)?YES:NO successBlocks:^(NSData *data, NetRequestManage *saveBeforeRecord) {
        
        NSString *str = [[NSString alloc] initWithData:saveBeforeRecord.resultData encoding:NSUTF8StringEncoding];
        NSLog(@"saveBeforeRecord = %@",str);
        NSDictionary *saveBeforeDic = [NSJSONSerialization JSONObjectWithData:saveBeforeRecord.resultData options:NSJSONReadingMutableContainers error:nil];
        if ([[saveBeforeDic objectForKey:@"errorId"] intValue] == 0) {
            
            CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
            [alert alertViewWith:@"提交成功！" andDetailTitle:@"补足数据成功，您可以在曲线图中看到宝宝的发育状况哦~"  andButtonTitle:@"0"];
            [alert layoutSubviews];
            if (_breakArr) {
                alert.clickBlocks = ^(void){
                    LeftViewController *left = [[LeftViewController alloc] init];
                    RickyNavViewController *nav = [[RickyNavViewController alloc] initWithRootViewController:left];

                    [AppDelegate sharedInstance].window.rootViewController = nav;
                };
            }else{
                alert.clickBlocks = ^(void){
                    
                    [self.navigationController popViewControllerAnimated:YES];
                };
            }
            
        }else{
            
            CYRecordAlertView *alert = [self.view.window viewWithTag:9999];
            [alert alertViewWith:@"错误！" andDetailTitle:[ErrorStatus errorStatus:[NSString stringWithFormat:@"%@",[saveBeforeDic objectForKey:@"errorId"]]]  andButtonTitle:@"0"];
            [alert layoutSubviews];
            
            if ([[saveBeforeDic objectForKey:@"errorId"] intValue] == -900) {
                alert.clickBlocks = ^(void){
                    
                    FirPageViewController *firpage = [[FirPageViewController alloc] init];
                    firpage.isAutoLogin = YES;
                    firpage.isOverTime = YES;
                    
                    [AppDelegate sharedInstance].window.rootViewController = firpage;
                };
            
            }
            
        }
        
        
    } andFailedBlocks:^(NSError *error, NetRequestManage *saveBeforeRecord) {
        NSLog(@"saveBeforeRecord error = %@",error.localizedDescription);
    }];
    
    
}
-(void)createTableView{
    
    
#pragma mark = 成长记录
    
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 768*Ratio) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resign:)];
    [_tableView addGestureRecognizer:tap];
    
    [_tableView registerClass:[AddOtherTableViewCell class] forCellReuseIdentifier:@"identifierStr"];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [self.view layoutIfNeeded];

    
    
}

#pragma mark - tableView代理相关
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35*Ratio;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 35*Ratio)];
    view.backgroundColor = MBColor(240, 240, 240, 1);
    UILabel *monthLabel = [[UILabel alloc] init];
    [monthLabel makeLabelWithText:@"月龄" andTextColor:MBColor(145, 145, 145, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [view addSubview:monthLabel];
    [monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(view).offset(50*Ratio);
        make.size.mas_equalTo(CGSizeMake(34*Ratio, 17*Ratio));
    }];
    UILabel *bodyLengLabel = [[UILabel alloc] init];
    [bodyLengLabel makeLabelWithText:@"身长cm" andTextColor:MBColor(145, 145, 145, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [view addSubview:bodyLengLabel];
    [bodyLengLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.left.equalTo(monthLabel.mas_right).offset(65*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 17*Ratio));
    }];
    UILabel *weightLabel = [[UILabel alloc] init];
    [weightLabel makeLabelWithText:@"体重kg" andTextColor:MBColor(145, 145, 145, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
    [view addSubview:weightLabel];
    [weightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(-21*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 17*Ratio));
    }];
    
    return view;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44*Ratio;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_breakArr) {
        if (_breakArr.count > 0) {
            return [_breakArr count];
        }
    }
    return [_dataArr count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"identifierStr";
    AddOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[AddOtherTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.field0.delegate = self;
    [cell.field0 addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];
    
    cell.field1.delegate = self;
    [cell.field1 addTarget:self action:@selector(reformatAsPhoneNumber:) forControlEvents:UIControlEventEditingChanged];

    cell.indexPath = indexPath;
    AddOldRecord *record = _dataArr[indexPath.row];
    cell.field0.text = record.bodyLength;
    cell.field1.text = record.weight;
    [cell makeCellByMonth:[NSString stringWithFormat:@"%ld",(_breakArr)?([_breakArr[indexPath.row] intValue]):((long)indexPath.row+1)]];
    return cell;
}

#pragma mark - textField代理相关

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    _actionField = textField;
    [textField becomeFirstResponder];
    //当键盘遮盖住输入框时，调整偏移量
    chaZhi = [textField superview].frame.origin.y - _tableView.contentOffset.y - ((568 - 129 - 64 - 44 - 44)*Ratio);
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
             _tableView.contentOffset = CGPointMake(0, _tableView.contentOffset.y + chaZhi + 50);
        }];
        [self.view layoutIfNeeded];
    }
//    NSLog(@"cell高度：%f  - 偏移量：%f -  显示高度：%f",[textField superview].frame.origin.y ,_tableView.contentOffset.y,((568 - 129 - 64- 44)*Ratio));
//
//    NSLog(@"差值 %f",chaZhi);
    
    
//    NSLog(@"textField.frame = %@",NSStringFromCGRect(textField.frame));
    
    
    if ([textField.text intValue] == 0) {
        textField.text = @"";
    }
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField{
    if (chaZhi > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.contentOffset = CGPointMake(0, _tableView.contentOffset.y - chaZhi - 50);
        }];
        [self.view layoutIfNeeded];
        chaZhi = 0;
    }
    
    AddOtherTableViewCell *tabCell = (AddOtherTableViewCell *)[textField superview];

    AddOldRecord *record = _dataArr[tabCell.indexPath.row];
    
    if (textField.frame.origin.x > 200) {
        record.weight = (textField.text.length == 0)?@"0.00":textField.text;
    }else{
        record.bodyLength = (textField.text.length == 0)?@"0.00":textField.text;
    }
    if (textField.text.length == 0) {
        textField.text = @"0.00";
    }
    [textField resignFirstResponder];
//    [_tableView reloadRowsAtIndexPaths:@[tabCell.indexPath] withRowAnimation:UITableViewRowAnimationNone];

    
    
    
}

#pragma mark - 非数字不能键入

-(void)reformatAsPhoneNumber:(UITextField *)textField {
    NSUInteger targetCursorPostion = [textField offsetFromPosition:textField.beginningOfDocument toPosition:textField.selectedTextRange.start];
    NSString *phoneNumberWithoutSpaces = [self removeNonDigits:textField.text andPreserveCursorPosition:&targetCursorPostion];
    
    
    textField.text = phoneNumberWithoutSpaces;
    UITextPosition *targetPostion = [textField positionFromPosition:textField.beginningOfDocument offset:targetCursorPostion];
    [textField setSelectedTextRange:[textField textRangeFromPosition:targetPostion toPosition:targetPostion]];
}




- (NSString *)removeNonDigits:(NSString *)string andPreserveCursorPosition:(NSUInteger *)cursorPosition {
    NSUInteger originalCursorPosition =*cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    
    for (NSUInteger i=0; i<string.length; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        
        if(isdigit(characterToAdd)||characterToAdd == '.') {
            NSString *stringToAdd = [NSString stringWithCharacters:&characterToAdd length:1];
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if(i<originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    return digitsOnlyString;
}

#pragma mark -  收键盘

-(void)resign:(UITapGestureRecognizer *)tap{
    
    if (chaZhi > 0) {
        
        [UIView animateWithDuration:0.5 animations:^{
            _tableView.contentOffset = CGPointMake(0, _tableView.contentOffset.y - chaZhi - 50);
        }];
        [self.view layoutIfNeeded];
        chaZhi = 0;

       
         
    }
    [self.view endEditing:YES];

    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
