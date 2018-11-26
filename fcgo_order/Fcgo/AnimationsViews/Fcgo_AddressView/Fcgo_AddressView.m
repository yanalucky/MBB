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

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectedArray;

@property (nonatomic, strong) UIButton *addAddressBtn;
@property (nonatomic, strong) NSString *titleStr;
@property (nonatomic, assign) BOOL isCanAddAddress;
@end

@implementation Fcgo_AddressView


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self cancelAction];
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title isCanAddAddress:(BOOL)isAdd successBlock:(void(^)(Fcgo_AddressModel *model))selectBlock cancelBlock:(void(^)(void))cancelBlock{
    if (self = [super initWithFrame:frame]) {
        self.selectBlock = selectBlock;
        self.cancelBlock = cancelBlock;
        self.titleStr = title;
        self.isCanAddAddress = isAdd;
        [self setUI];
        
    }
    return self;
}

-(void)setUI
{
    
    self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _selectedArray = [[NSMutableArray alloc] init];
    _dataArray = [[NSMutableArray alloc] init];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"Fcgo_AddressTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"str"];
    //    _tableView.backgroundColor = UIFontRedColor;
    [self addSubview:_tableView];
    self.hidden = YES;
    if (_isCanAddAddress) {
        UIButton *addAddressBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addAddressBtn setTitle:@"添加新地址" forState:UIControlStateNormal];
        [addAddressBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [addAddressBtn setBackgroundColor:UIFontRedColor];
        addAddressBtn.frame = CGRectMake(0, KScreenHeight*1.5-49, kScreenWidth, 49);
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
    
    //两种不同结构的dataArray
    
    [self.selectedArray removeAllObjects];
    if (dataArray.count>0) {
        for (int i = 0; i < dataArray.count; i ++) {
            Fcgo_AddressModel *model = dataArray[i];
            BOOL isExit = NO;
            for (int i = 0; i < self.selectedArray.count; i ++) {
                NSDictionary *saveDict = self.selectedArray[i];
                NSNumber *newID = model.f_address_id;
                NSNumber *saveID = saveDict[@"id"];
                if ([newID isEqualToNumber:saveID]) {
                    isExit = YES;
                }
            }
            if (isExit == NO){
                NSDictionary *saveDict = @{@"id":model.f_address_id,@"select":@0,@"deFault":model.deFault};
                [self.selectedArray addObject:saveDict];
            }
        }
        
        BOOL isExit = NO;
        for (NSDictionary *saveDict in self.selectedArray) {
            NSNumber *saveID = saveDict[@"select"];
            if (saveID.intValue == 1) {
                isExit = YES;
            }
        }
        if(!isExit)
        {
            for (int i = 0; i < self.selectedArray.count; i ++) {
                NSDictionary *saveDict = self.selectedArray[i];
                NSNumber *deFault = saveDict[@"deFault"];
                if (deFault.intValue == 1) {
                    [self.selectedArray replaceObjectAtIndex:i withObject:@{@"id":saveDict[@"id"],@"select":@1,@"deFault":saveDict[@"deFault"]}];
                }
            }
            
        }
    }
    
//    for (int i = 0; i < self.selectedArray.count; i ++) {
//        NSDictionary *saveDict = self.selectedArray[i];
//        NSNumber *saveID = saveDict[@"select"];
//        if (saveID.intValue == 1) {
//            Fcgo_AddressModel *selectedModel = dataArray[i];
//            if (self.selectedAddressBlock) {
//                self.selectedAddressBlock(selectedModel);
//            }
//        }
//    }
    if (_tableView) {
        [_tableView reloadData];
    }
}

- (void)show
{
    self.hidden = NO;
    [self layoutIfNeeded];
    if(self.isCanAddAddress)
    {
        _tableView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, KScreenHeight*0.5);
        [UIView animateWithDuration:0.25 animations:^{
            _tableView.frame = CGRectMake(0, KScreenHeight*0.5, kScreenWidth, KScreenHeight*0.5-49);
            _addAddressBtn.frame = CGRectMake(0, KScreenHeight - 49, kScreenWidth, 49);
        } completion:^(BOOL finished) {}];
    }
    else
    {
        _tableView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, KScreenHeight*0.5);
        [UIView animateWithDuration:0.25 animations:^{
            _tableView.frame = CGRectMake(0, KScreenHeight*0.5, kScreenWidth, KScreenHeight*0.5);
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)cancelAction
{
    WEAKSELF(weakSelf);
    [self cancelActionCompletion:^{
        weakSelf.cancelBlock();
    }];
}

- (void)cancelActionCompletion:(void(^)(void))closeBlock{
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
    if (self.dataArray.count>0) {
        Fcgo_AddressModel *model = self.dataArray[indexPath.row];
        [cell makeCellWithAddress:[NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail] andIsSel:[self.selectedArray[indexPath.row][@"select"] boolValue]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    Fcgo_AddressModel *model = _dataArray[indexPath.row];
    label.text = [NSString stringWithFormat:@"%@%@",model.addressFormal,model.addressDetail];
    CGSize size =[label sizeThatFits:CGSizeMake(kScreenWidth - 80, 3000)];
    return size.height + 30;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.dataArray.count>0) {
        for (int i=0; i<self.selectedArray.count; i++) {
            NSDictionary *saveDict = self.selectedArray[i];
            if ([saveDict[@"select"] boolValue] == 1) {
                [self.selectedArray replaceObjectAtIndex:i withObject:@{@"id":saveDict[@"id"],@"select":@0,@"deFault":saveDict[@"deFault"]}];
            }
        }
        NSDictionary *saveDict = self.selectedArray[indexPath.row];
        [self.selectedArray replaceObjectAtIndex:indexPath.row withObject:@{@"id":saveDict[@"id"],@"select":@1,@"deFault":saveDict[@"deFault"]}];
    }
    [self.tableView reloadData];
    return indexPath;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WEAKSELF(weakSelf)
    
    [self cancelActionCompletion:^{
        weakSelf.selectBlock(self.dataArray[indexPath.row]);
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44)];
    headerView.backgroundColor = UIFontWhiteColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 150, 25)];
    label.text = [self.titleStr isEqualToString:@"选择地区"]?@"选择地区":@"配送至";
    label.textAlignment = NSTextAlignmentCenter;//[self.titleStr isEqualToString:@"选择地区"]?NSTextAlignmentLeft:NSTextAlignmentCenter;
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

