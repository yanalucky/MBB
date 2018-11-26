//
//  Fcgo_AddressView.m
//  Fcgo
//
//  Created by fcg on 2017/10/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_AddressView.h"
#import "Fcgo_AddressTableViewCell.h"
#import "Fcgo_AddressModel.h"

@interface Fcgo_AddressView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *selArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *addAddressBtn;
@property (nonatomic, strong)NSString *titleStr;
@property (nonatomic, assign)BOOL isCanAddAddress;
@end

@implementation Fcgo_AddressView


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAction];
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title isCanAddAddress:(BOOL)isAdd successBlock:(void(^)(NSMutableDictionary *selDic))selectBlock cancelBlock:(void(^)(void))cancelBlock{
    if (self = [super initWithFrame:frame]) {
        self.selectBlock = selectBlock;
        self.cancelBlock = cancelBlock;
        self.titleStr = title;
        self.isCanAddAddress = isAdd;
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    self.backgroundColor = UIRGBColor(0, 0, 0, 0.55);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, KScreenHeight*0.5, kScreenWidth,  KScreenHeight*0.5) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = 0;
    _selArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"Fcgo_AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"str"];
    //    _tableView.backgroundColor = UIFontRedColor;
    [self addSubview:_tableView];
    
    self.hidden = YES;
    
    //    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(44*(_dataArray.count+1));
    //        make.top.equalTo(self.mas_bottom);
    //        make.width.equalTo(self);
    //        make.left.equalTo(self);
    //    }];
    
    if (_isCanAddAddress) {
        UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [addAddressBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [addAddressBtn setBackgroundColor:UIFontRedColor];
        addAddressBtn.frame = CGRectMake(0, KScreenHeight+(44*7), kScreenWidth, 49);
        [addAddressBtn addTarget:self action:@selector(addNewAddress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.addAddressBtn =addAddressBtn];
    }
}

-(void)addNewAddress:(UIButton *)button{
    if (self.addNewAddressBlock) {
        self.addNewAddressBlock();
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    _tableView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, 44*7);
    
    //两种不同结构的dataArray
    
    if (dataArray.count>0) {
        NSDictionary *object = dataArray[0];
        if ([object.allKeys containsObject:@"id"]) {
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *dic = dataArray[i];
                BOOL isExit = NO;
                for (int i = 0; i < self.selArray.count; i ++) {
                    NSDictionary *saveDict = self.selArray[i];
                    NSNumber *newID = dic[@"id"];
                    NSNumber *saveID = saveDict[@"id"];
                    if ([newID isEqualToNumber:saveID]) {
                        isExit = YES;
                    }
                }
                if (isExit == NO){
                    NSDictionary *saveDict = @{@"id":dic[@"id"],@"select":@"0",@"deFault":dic[@"deFault"]};
                    [self.selArray addObject:saveDict];
                }
            }
            
            BOOL isExit = NO;
            for (NSDictionary *saveDict in self.selArray) {
                NSNumber *saveID = saveDict[@"select"];
                if (saveID.intValue == 1) {
                    isExit = YES;
                }
            }
            if(!isExit)
            {
                for (int i = 0; i < self.selArray.count; i ++) {
                    NSDictionary *saveDict = self.selArray[i];
                    NSNumber *deFault = saveDict[@"deFault"];
                    if (deFault.intValue == 1) {
                        [self.selArray replaceObjectAtIndex:i withObject:@{@"id":saveDict[@"id"],@"select":@"1",@"deFault":saveDict[@"deFault"]}];
                    }
                }
                
            }
        }
        else
        {
            for (int i = 0; i < dataArray.count; i ++) {
                NSDictionary *dic = dataArray[i];
                BOOL isExit = NO;
                for (int i = 0; i < self.selArray.count; i ++) {
                    NSDictionary *saveDict = self.selArray[i];
                    NSString *newID = dic[@"addressId"];
                    NSString *saveID = saveDict[@"addressId"];
                    if ([newID isEqualToString:saveID]) {
                        isExit = YES;
                    }
                }
                if (isExit == NO){
                    NSDictionary *saveDict = @{@"addressId":dic[@"addressId"],@"select":@"0",@"defaultAddress":dic[@"defaultAddress"]};
                    [self.selArray addObject:saveDict];
                }
            }
            
            BOOL isExit = NO;
            for (NSDictionary *saveDict in self.selArray) {
                NSNumber *saveID = saveDict[@"select"];
                if (saveID.intValue == 1) {
                    isExit = YES;
                }
            }
            if(!isExit)
            {
                for (int i = 0; i < self.selArray.count; i ++) {
                    NSDictionary *saveDict = self.selArray[i];
                    NSNumber *deFault = saveDict[@"defaultAddress"];
                    if (deFault.intValue == 1) {
                        [self.selArray replaceObjectAtIndex:i withObject:@{@"addressId":saveDict[@"addressId"],@"select":@"1",@"defaultAddress":saveDict[@"defaultAddress"]}];
                    }
                }
                
            }
        }
    }
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (void)showWithDataArray:(NSMutableArray *)dataArray
{
    self.dataArray = dataArray;
    self.hidden = NO;
    [self layoutIfNeeded];
    self.hidden = NO;
    [self layoutIfNeeded];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    NSInteger count =  6;
    [UIView animateWithDuration:0.25 animations:^{
        
        _tableView.frame = CGRectMake(0, KScreenHeight-(44*7)-((_isCanAddAddress)?49:0), kScreenWidth, 44*(count+1));
        _addAddressBtn.frame = CGRectMake(0, KScreenHeight - ((_isCanAddAddress)?49:0), kScreenWidth, 49);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)cancelAction
{
    WEAKSELF(weakSelf);
    [self cancelActionCompletion:^{
        weakSelf.cancelBlock();
    }];
}

-(void)cancelActionCompletion:(void(^)(void))closeBlock{
    WEAKSELF(weakSelf);
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.4 animations:^{
        
        _tableView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, 44*7);
        _addAddressBtn.frame = CGRectMake(0, KScreenHeight+(44*7), kScreenWidth, 49);
        
    } completion:^(BOOL finished) {
        weakSelf.hidden = YES;
        closeBlock();
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"str";
    Fcgo_AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"Fcgo_AddressTableViewCell" owner:self options:nil] lastObject];
        
    }
    [cell makeCellWithAddress:[_dataArray[indexPath.row] objectForKey:@"totalAddress"] andIsSel:[_selArray[indexPath.row][@"select"] boolValue]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.text = [_dataArray[indexPath.row] objectForKey:@"totalAddress"];
    CGSize size =[label sizeThatFits:CGSizeMake(kScreenWidth - 80, 3000)];
    return size.height + 22;
}

-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>0) {
        NSDictionary *object = self.dataArray[0];
        if ([object.allKeys containsObject:@"id"]) {
            for (int i=0; i<_selArray.count; i++) {
                NSDictionary *saveDict = _selArray[i];  // = @{@"id":dic[@"id"],@"select":@"0"};
                if ([saveDict[@"select"] boolValue] == 1) {
                    [_selArray replaceObjectAtIndex:i withObject:@{@"id":saveDict[@"id"],@"select":@"0",@"deFault":saveDict[@"deFault"]}];
                }
            }
            NSDictionary *saveDict = _selArray[indexPath.row];
            [_selArray replaceObjectAtIndex:indexPath.row withObject:@{@"id":saveDict[@"id"],@"select":@"1",@"deFault":saveDict[@"deFault"]}];
            
        }
        else
        {
            for (int i=0; i<_selArray.count; i++) {
                NSDictionary *saveDict = _selArray[i];  // = @{@"id":dic[@"id"],@"select":@"0"};
                if ([saveDict[@"select"] boolValue] == 1) {
                    [_selArray replaceObjectAtIndex:i withObject:@{@"addressId":saveDict[@"addressId"],@"select":@"0",@"select":@"1",@"defaultAddress":saveDict[@"defaultAddress"]}];
                }
            }
            NSDictionary *saveDict = _selArray[indexPath.row];
            [_selArray replaceObjectAtIndex:indexPath.row withObject:@{@"addressId":saveDict[@"addressId"],@"select":@"1",@"select":@"1",@"defaultAddress":saveDict[@"defaultAddress"]}];
        }
    }
    
    
    [self.tableView reloadData];
    return indexPath;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF(weakSelf)
    [self cancelActionCompletion:^{
        weakSelf.selectBlock(_dataArray[indexPath.row]);
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    headerView.backgroundColor = UIFontWhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 25)];
    label.text = [self.titleStr isEqualToString:@"选择地区"]?@"选择地区":@"配送至";
    label.textAlignment = [self.titleStr isEqualToString:@"选择地区"]?NSTextAlignmentLeft:NSTextAlignmentCenter;
    label.textColor = UIStringColor(@"#7b7b7b");
    label.font = [UIFont systemFontOfSize:16];
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - kAutoWidth6(30), kAutoHeight6(25)));
        make.left.equalTo(headerView).offset(kAutoHeight6(15));
    }];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.frame = CGRectMake(kScreenWidth - 35, 5, 30, 30);
    [cancelBtn setBackgroundImage:[UIImage imageNamed:@"btn-shut down"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:cancelBtn];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 43.5, kScreenWidth, 0.5)];
    line.backgroundColor = UISepratorLineColor;
    [headerView addSubview:line];
    return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

@end

