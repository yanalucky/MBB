//
//  SleepViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/18.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "SleepViewController.h"

@interface SleepViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSString *_title;
    UIButton *_rightBtn;
    NSDictionary *_record;
    void(^_myBlocks)(BOOL _isDefecate, NSString *number0 , NSString *number1);
    
    UIView *pickerBgView;//选择器
    UIPickerView *picker;
    
    NSMutableArray *pickerDataArr;
    NSMutableArray *defecateDataArr;
    UIView *defecateView;//排便view
}

@end

@implementation SleepViewController


-(instancetype)initWithMonth:(int)month andName:(int)numb{
    if (self = [super init]) {
        self.month = month;
        self.name = numb;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    if (_name == 3||_name == 4) {
        UIButton *button0 = [defecateView viewWithTag:1114];
        UIButton *button1 = [defecateView viewWithTag:1115];
        [button0 setTitle:_data forState:UIControlStateNormal];
        [button0 setTitle:_data forState:UIControlStateSelected];
        [button1 setTitle:_data1 forState:UIControlStateNormal];
        [button1 setTitle:_data1 forState:UIControlStateSelected];
        defecateView.hidden = NO;
        
    }else{
        [_number setTitle:_data forState:UIControlStateNormal];
        [_number setTitle:_data forState:UIControlStateSelected];
        defecateView.hidden = YES;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    pickerDataArr = [[NSMutableArray alloc] init];
    for (int i=0; i<24; i++) {
        [pickerDataArr addObject:[NSString stringWithFormat:@"%d",i]];
        
    }
    defecateDataArr = [[NSMutableArray alloc] init];
    for (int i=0; i<2; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<10; i++) {
            [array addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [defecateDataArr addObject:array];
    }
    //    _name = 3;
    if (_name) {
        
        if (_name == 1) {
            _title = @"夜间睡眠";
            
        }else if (_name == 2){
            _title = @"日间睡眠";
        }else if (_name == 5){
            _title = @"排尿";
        }else{
            _title = @"排便";
        }
        
        self.title = _title;
    }
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 50*Ratio, 40*Ratio);
    [_rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    
    [_rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_rightBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [_rightBtn addTarget:self action:@selector(finish:) forControlEvents:UIControlEventTouchUpInside];
    _rightBtn.titleLabel.font = [UIFont yaHeiFontOfSize:16*Ratio];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    _rightBtn.enabled = YES;
    
    
    //读取参考值
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"Record" ofType:@"plist"];
    NSDictionary *recordDic = [NSDictionary dictionaryWithContentsOfFile:path0];
    _record = recordDic;
    //    self.sex = 0;//女生
    [self createMainView];
    
    // Do any additional setup after loading the view.
}
-(void)finish:(UIButton *)button{
    

    UIButton *button0 = [defecateView viewWithTag:1114];
    UIButton *button1 = [defecateView viewWithTag:1115];
    _myBlocks(defecateView.hidden == NO,(defecateView.hidden == YES)?_number.titleLabel.text:button0.titleLabel.text,button1.titleLabel.text);

    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)changeDataBlock:(void (^)(BOOL, NSString *, NSString *))block{
    _myBlocks = [block copy];
}
#pragma mark -   主页面

    

-(void)createMainView{
    
    UILabel *title = [[UILabel alloc] init];
   
    [title makeLabelWithText:(_name > 2)?@"":[NSString stringWithFormat:@"%@%@",_title,@"时间"] andTextColor:MBColor(51, 51, 51, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    title.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo((_name > 2)?0:18*Ratio);
        make.width.mas_equalTo(100*Ratio);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(17*Ratio);
    }];
    
    _number = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_number setBackgroundImage:[UIImage imageNamed:@"jilu_kuang"] forState:UIControlStateNormal];
    [_number setBackgroundImage:[UIImage imageNamed:@"jilu_kuang_set"] forState:UIControlStateSelected];
    [_number setTitle:@"6" forState:UIControlStateNormal];
    [_number setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [_number addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(49*Ratio, 25*Ratio));
        make.right.equalTo(self.view.mas_centerX).offset(Ratio);
        make.top.equalTo(title.mas_bottom).offset(19*Ratio);
    }];
    
    
    
    UILabel *unit = [[UILabel alloc] init];
    
    
    [unit makeLabelWithText:[NSString stringWithFormat:(_name < 3)?@"小时/天":@"次/天"] andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
    
    [self.view addSubview:unit];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 15*Ratio));
        make.centerY.equalTo(_number);
        make.left.equalTo(_number.mas_right).offset(15*Ratio);
    }];
    UIView *shadowLineView = [[UIView alloc] init];
    shadowLineView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:shadowLineView];
    [shadowLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(_number.mas_bottom).offset(20*Ratio);
        make.height.equalTo(@(14*Ratio));
    }];
    [shadowLineView addShadeLayerFrom:0 andTo:320*Ratio];
    
    
    
    NSString *tishiMesg = nil;
    if (_name == 5) {
        
        NSArray *mess = (NSArray *)[_record objectForKey:_title];
        NSLog(@"%@",mess);
        UILabel *tempLabel = nil;
        for (int i=0; i<[mess count]; i++) {
            UILabel *referTo0 = [[UILabel alloc] init];
            referTo0.numberOfLines = 0;
            //        mesa.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            [referTo0 makeLabelWithText:mess[i] andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referTo0.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, referTo0.text.length)];
            referTo0.attributedText = attributedString;
            CGSize size = [referTo0 sizeThatFits:CGSizeMake(290*Ratio, 200000)];
            [self.view addSubview:referTo0];
            [referTo0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(290*Ratio));
                make.height.equalTo(@(size.height));
                make.left.equalTo(self.view).offset(15*Ratio);
                if (tempLabel) {
                    make.top.equalTo(tempLabel.mas_bottom).offset(5*Ratio);

                }else{
                    make.top.equalTo(shadowLineView.mas_bottom);
                }
            }];
            
            tempLabel = referTo0;
            
        }
        
        
        
    }else{
        if ((_name == 3)||(_name == 4)){
            
            tishiMesg = [[_record objectForKey:_title] objectAtIndex:_month];

        }else{
            tishiMesg = [NSString stringWithFormat:@"参考值：%d个月的宝宝，平均%@时间为%@",_month+1,_title,[[_record objectForKey:_title] objectAtIndex:_month]];
        }
        
        
        UILabel *tishi = [[UILabel alloc] init];
        tishi.numberOfLines = 0;
        [tishi makeLabelWithText:tishiMesg andTextColor:MBColor(101, 102, 103, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tishi.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, tishi.text.length)];
        tishi.attributedText = attributedString;
        CGSize size = [tishi sizeThatFits:CGSizeMake(286*Ratio, 200000)];
        [self.view addSubview:tishi];
        [tishi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(290*Ratio));
            make.height.equalTo(@(size.height));
            make.left.equalTo(self.view).offset(15*Ratio);
            make.top.equalTo(shadowLineView.mas_bottom);
        }];
    }
   
    
    
    

#pragma mark = 选择器
    
    pickerBgView = [[UIView alloc] init];
    pickerBgView.backgroundColor = MBColor(190, 191, 192, 0.5);
    pickerBgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pickerViewClick:)];
    [pickerBgView addGestureRecognizer:tap];
    
    [self.view addSubview:pickerBgView];
    [pickerBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    
    picker = [[UIPickerView alloc] init];
    picker.dataSource = self;
    picker.delegate = self;
    picker.backgroundColor = [UIColor whiteColor];
    picker.showsSelectionIndicator = NO;
    [picker selectRow:6 inComponent:0 animated:YES];
    [picker reloadComponent:0];
    
    [pickerBgView addSubview:picker];
    [picker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(pickerBgView);
        
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 215*Ratio));
        make.centerX.equalTo(pickerBgView);
    }];
    [self.view bringSubviewToFront:pickerBgView];
    
    pickerBgView.hidden = YES;
    
    
    #pragma mark - 排便
    
    
    defecateView = [[UIView alloc] init];
    defecateView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:defecateView];
    [defecateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(65*Ratio);
    }];
    
    for (int i=0; i<2; i++) {
        UIButton *button0 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button0 setBackgroundImage:[UIImage imageNamed:@"jilu_kuang"] forState:UIControlStateNormal];
        [button0 setBackgroundImage:[UIImage imageNamed:@"jilu_kuang_set"] forState:UIControlStateSelected];
        [button0 setTitle:@"6" forState:UIControlStateNormal];
        [button0 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        button0.tag = 1114+i;
        [button0 addTarget:self action:@selector(defecateClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [defecateView addSubview:button0];
        [button0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(64*Ratio, 29*Ratio));
            make.left.equalTo(defecateView).offset((58+115*i)*Ratio);
            make.top.equalTo(defecateView).offset(16*Ratio);
        }];
        
        
        
        UILabel *unit0 = [[UILabel alloc] init];
        
        
        [unit0 makeLabelWithText:[NSString stringWithFormat:@"%@",(i==0)?@"天":@"次"] andTextColor:MBColor(128, 128, 128, 1) andFont:[UIFont yaHeiFontOfSize:13*Ratio]];
        
        [defecateView addSubview:unit0];
        [unit0 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20*Ratio, 20*Ratio));
            make.centerY.equalTo(button0);
            make.left.equalTo(button0.mas_right).offset(13*Ratio);
        }];

    }
    
    
    
}



-(void)buttonClick:(UIButton *)button{
    
    [picker reloadAllComponents];
    [picker selectRow:[button.titleLabel.text intValue] inComponent:0 animated:NO];
    pickerBgView.hidden = NO;
    
    [self.view bringSubviewToFront:pickerBgView];
    
}
-(void)defecateClick:(UIButton *)button{
    
    [picker reloadAllComponents];
    UIButton *button0 = [defecateView viewWithTag:1114];
    UIButton *button1 = [defecateView viewWithTag:1115];
    [picker selectRow:[button0.titleLabel.text intValue] inComponent:0 animated:NO];
    [picker selectRow:[button1.titleLabel.text intValue] inComponent:2 animated:NO];

    pickerBgView.hidden = NO;
    
    [self.view bringSubviewToFront:pickerBgView];
    
    
}
#pragma mark - 选择器相关

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (defecateView.hidden == YES) {
        
        return pickerDataArr.count;
        
    }else{
        
        if (component == 0) {
            return [defecateDataArr[0] count];
        }else if (component == 1){
            return 1;
        }else if (component == 2){
            return [defecateDataArr[1] count];
        }else{
            return 1;
        }
    }
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (defecateView.hidden == YES) {
        
        return 1;
        
    }else{
        
        return 4;
    }
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (defecateView.hidden == YES) {
        
        return 320*Ratio;
        
    }else{
        if (component % 2 == 0) {
            return 60*Ratio;
        }else{
            return 35*Ratio;
        }
        
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
   
//    _number.titleLabel.text = pickerDataArr[row];
    if (defecateView.hidden == YES) {
        _number.selected = YES;
        [_number setTitle:pickerDataArr[row] forState:UIControlStateSelected];
    }else{
        
        UIButton *button = (UIButton *)[defecateView viewWithTag:1114+(int)component/2];
        button.selected = YES;
        [button setTitle:defecateDataArr[(int)component/2][row] forState:UIControlStateSelected];
        
    }
    
    
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (defecateView.hidden == YES) {

        return  pickerDataArr[row];
        
    }else{
        if (component == 0) {
            return [defecateDataArr[0] objectAtIndex:row];
        }else if (component == 1) {
            return @"天";
        }else if (component == 2){
            return [defecateDataArr[1] objectAtIndex:row];

        }else{
            return @"次";
        }
        
    }
    
    
}

-(void)pickerViewClick:(UITapGestureRecognizer *)tap{
    if (tap.view.hidden == NO) {
        tap.view.hidden = YES;
    }
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
