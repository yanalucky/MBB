//
//  Fcgo_ExterAddressPickerView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/7.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ExterAddressPickerView.h"

@interface Fcgo_ExterAddressPickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    NSInteger selectOne;
    NSInteger selectTwo;
    NSInteger selectThree;
    
    NSInteger currentPro;
    
}
@property (nonatomic,strong) NSMutableArray *provinceArray;
@property (nonatomic,strong) NSMutableArray *cityArray;
@property (nonatomic,strong) NSMutableArray *areaArray;
@property (nonatomic,strong) UIView  *buttonView;
@property (nonatomic,strong) UIPickerView *myPicker;

@property(nonatomic,strong)UIView  *bgView;
@end

@implementation Fcgo_ExterAddressPickerView

- (instancetype)initWithFrame:(CGRect)frame selectAddressBlock:(void(^)(NSMutableDictionary *addressDict))addressBlock
{
    self = [super initWithFrame:frame];
    if (self)
    {
        if (addressBlock) {
            self.addressBlock = addressBlock;
        }
        self.hidden = 1;
        self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
        [self addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        
        [self configData];
        
        [self.bgView addSubview:self.buttonView];
        [self.bgView addSubview:self.myPicker];
        [self addSubview:self.bgView];
    }
    return self;
}

- (void)configData
{
    self.provinceArray = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in [Fcgo_UserTools  shared].cityArray) {
        NSDictionary *dic1 = @{@"areaName":[dic objectForKey:@"areaName"],@"areaId":[dic objectForKey:@"areaId"]};
        [self.provinceArray addObject:dic1];
    }
    [self configCityWithIndex:0];
    [self configAreaWithIndex:0];
    currentPro = 0;
}

- (void)configCityWithIndex:(NSInteger)proIndex
{
    [self.cityArray removeAllObjects];
    NSDictionary *cityDic = [Fcgo_UserTools  shared].cityArray[proIndex];
    for (NSDictionary *dic in cityDic[@"city"]) {
        NSDictionary *dic1 = @{@"areaName":[dic objectForKey:@"areaName"],@"areaId":[dic objectForKey:@"areaId"]};

        [self.cityArray  addObject:dic1];
    }
    currentPro = proIndex;
}

- (void)configAreaWithIndex:(NSInteger)cityIndex
{
    [self.areaArray  removeAllObjects];
    NSDictionary *cityDic = [Fcgo_UserTools  shared].cityArray[currentPro];
    NSArray *arr = [[[cityDic objectForKey:@"city"] objectAtIndex:cityIndex] objectForKey:@"area"];
    for (NSDictionary *dic in arr) {
        NSDictionary *dic1 = @{@"areaName":[dic objectForKey:@"areaName"],@"areaId":[dic objectForKey:@"areaId"]};
        [self.areaArray  addObject:dic1];

    }
    
}

- (void)hide
{
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(0, KScreenHeight, kScreenWidth, 246);
    }completion:^(BOOL finished) {
        self.hidden = 1;
    }];
}

- (void)show
{
    self.hidden = 0;
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.frame = CGRectMake(0, KScreenHeight-246, kScreenWidth, 246);
    }];
}

//地址选择
- (void)areaSelected
{
    if (self.addressBlock) {
        NSMutableDictionary  *mutableDict =[[NSMutableDictionary  alloc] init];
        [mutableDict setObjectWithNullValidate:self.provinceArray[selectOne] forKey:@"province"];
        [mutableDict setObjectWithNullValidate:self.cityArray[selectTwo] forKey:@"city"];
        [mutableDict setObjectWithNullValidate:self.areaArray[selectThree] forKey:@"area"];
        self.addressBlock(mutableDict);
    }
    [self  hide];
}

#pragma mark------UIPickerViewDelegate  UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;
    switch (component) {
        case 0:
            result = self.provinceArray.count;
            break;
        case 1:
            result = self.cityArray.count;
            break;
        case 2:
            result = self.areaArray.count;
            break;
        default:
            break;
    }
    
    return result;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString * title = nil;
    switch (component) {
        case 0:
            title = [self.provinceArray[row] objectForKey:@"areaName"];
            break;
        case 1:
            title = [self.cityArray[row] objectForKey:@"areaName"];
            break;
        case 2:
            title = [self.areaArray[row] objectForKey:@"areaName"];
            break;
        default:
            break;
    }
    
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [self  configCityWithIndex:row];
        [self  configAreaWithIndex:0];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
    }
    
    if (component == 1) {
        [self  configAreaWithIndex:row];
        [pickerView selectRow:0 inComponent:2 animated:YES];
        [pickerView reloadComponent:2];
        
    }
    selectOne   = [pickerView selectedRowInComponent:0];
    selectTwo   = [pickerView selectedRowInComponent:1];
    selectThree = [pickerView selectedRowInComponent:2];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return  kScreenWidth/3;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *lbl = (UILabel *)view;
    if (lbl == nil) {
        lbl = [[UILabel alloc]init];
        //在这里设置字体相关属性
        lbl.font = UIFontSize(16);
        lbl.textColor = UIFontMainGrayColor ;
        [lbl setTextAlignment:1];
    }
    //重新加载lbl的文字内容
    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return lbl;
}

#pragma mark lazy load

- (NSMutableArray  *)cityArray
{
    if (!_cityArray) {
        _cityArray=[[NSMutableArray  alloc] init];
    }
    return _cityArray;
}

- (NSMutableArray  *)areaArray
{
    if (!_areaArray) {
        _areaArray=[[NSMutableArray  alloc] init];
    }
    return _areaArray;
}

- (UIView *)bgView
{
    if (!_bgView) {
        _bgView = [[UIView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, 256)];
        _bgView.backgroundColor = UIFontWhiteColor;
    }
    return _bgView;
}

- (UIView  *)buttonView
{
    if (!_buttonView) {
        _buttonView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        cancelBtn.frame = CGRectMake(12, 0, 50, 40);
        [cancelBtn addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
        [_buttonView addSubview:cancelBtn];
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:UIFontRedColor forState:UIControlStateNormal];
        sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        sureBtn.frame = CGRectMake(kScreenWidth-12-50, 0, 50, 40);
        [sureBtn addTarget:self action:@selector(areaSelected) forControlEvents:UIControlEventTouchUpInside];
        [_buttonView addSubview:sureBtn];
    }
    return _buttonView;
}

- (UIPickerView  *)myPicker
{
    if (!_myPicker) {
        _myPicker =[[UIPickerView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, 216)];
        _myPicker.backgroundColor = UIFontWhiteColor;
        _myPicker.dataSource = self;
        _myPicker.delegate = self;
    }
    return _myPicker;
}
@end

