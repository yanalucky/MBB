
//
//  PictureViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/25.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "PictureViewController.h"
#import "DrawImageView.h"
#import "OnlineAppraisalImgdata.h"
#import "PictureDetailViewController.h"

@interface PictureViewController ()<UIScrollViewDelegate>{
    UIView *mainview;
    UIScrollView *sc;
    NSMutableArray *_scArr;
    NSArray *colorArr;
    
    //曲线图
    int nowImage;
    NSMutableArray *_pictureDataArr;
    
    UIButton *detailBtn;
 
    
    UIButton *_rightBtn;
}

@end

@implementation PictureViewController
-(instancetype)initWithMonth:(int)month andSex:(BOOL)sex{
    if (self = [super init]) {
        
        self.month = month;
        self.sex = sex;
        
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    mainview.backgroundColor = colorArr[nowImage-1195];
    UIButton *butt = (UIButton *)[self.view viewWithTag:1190 + nowImage - 1195];
    butt.selected = YES;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    if ((nowImage - 1195) < 3) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfQuxian"]) {
            [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfQuxian"];

        }
        
    }else{
        
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfFayu"]) {
            [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
            [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfFayu"];

        }
    }
    
    

}

-(void)showAlertView{
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.1];
    UIImageView *yindao = [[UIImageView alloc] init];
    if ((nowImage - 1195) < 3) {
        yindao.image = [UIImage imageNamed:@"pingu_quxian_yindao"];
    }else{
        yindao.image = [UIImage imageNamed:@"pingu_fayu_yindao"];
    }
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    [ciew addSubview:yindao];
    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 568*Ratio));
        make.edges.equalTo(ciew);
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfPG"];
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)removeView{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    [self.view.window sendSubviewToBack:ciew];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
#pragma mark - 右侧按钮
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightBtn.frame = CGRectMake(0, 0, 14.5*Ratio, 14.5*Ratio);
    [_rightBtn setBackgroundImage:[UIImage imageNamed:@"pinggu_wenhao"] forState:UIControlStateNormal];
    
    [_rightBtn addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    
    
    
    NSLog(@"imgDataArr = %@",_imgDataArr);
    NSLog(@"_month = %d",_month);
//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    self.view.backgroundColor = [UIColor whiteColor];
    if (_number == 1) {
        self.title = @"身长曲线图";
    }else if (_number == 2){
        self.title = @"体重曲线图";
    }else if (_number == 3){
        self.title = @"身长体重比";
    }else if (_number == 4){
        self.title = @"发育进程图";
    }
    
    //曲线背景图
    _scArr = [[NSMutableArray alloc] init];
    [_scArr addObject:[NSString stringWithFormat:@"%d%@",_sex,@"_shenchang"]];
    [_scArr addObject:[NSString stringWithFormat:@"%d%@",_sex,@"_tizhong"]];
    [_scArr addObject:[NSString stringWithFormat:@"%d%@",_sex,(_month < 25)?@"_BMI":@"_BMI_2"]];
    [_scArr addObject:@"fayujincheng"];
    colorArr = @[MBColor(239, 167, 114, 1),MBColor(250, 109, 167, 1),MBColor(33, 227, 251, 1),MBColor(162, 108, 231, 1)];
    
    
    //曲线图数据数组
    
    _pictureDataArr = [NSMutableArray arrayWithArray:_imgDataArr];
    
    [self createInterface];
    
}

-(void)createInterface{
    mainview = [[UIView alloc] init];
    mainview.backgroundColor = MBColor(250, 109, 167, 1);
    [self.view addSubview:mainview];
    [mainview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.mas_equalTo(395*Ratio);
    }];
    
    
    UILabel *message = [[UILabel alloc] init];
    [message makeLabelWithText:@"来源：WHO儿童成长标准，世界卫生组织" andTextColor:[UIColor whiteColor] andFont:[UIFont yaHeiFontOfSize:9*Ratio]];
    message.textAlignment = NSTextAlignmentCenter;
    [mainview addSubview:message];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainview).offset(8*Ratio);
        make.centerX.equalTo(mainview);
        make.size.mas_equalTo(CGSizeMake(183*Ratio, 12*Ratio));
    }];
#pragma mark = 详细
    detailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    detailBtn.backgroundColor = [UIColor whiteColor];
    detailBtn.layer.masksToBounds = YES;
    detailBtn.layer.cornerRadius = 11.25*Ratio;
    [detailBtn setTitle:@"详细" forState:UIControlStateNormal];
    [detailBtn setTitleColor:colorArr[_number-1] forState:UIControlStateNormal];
    [detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [mainview addSubview:detailBtn];
    [detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(mainview);
        make.bottom.mas_equalTo(-15*Ratio);
        make.size.mas_equalTo(CGSizeMake(75*Ratio, 22.5*Ratio));
    }];
    
    sc = [[UIScrollView alloc] init];
    sc.scrollEnabled = YES;
    sc.showsHorizontalScrollIndicator=NO;
    sc.showsVerticalScrollIndicator=NO;
    sc.delegate = self;
    sc.bounces=NO;
    sc.bouncesZoom=NO;
    sc.minimumZoomScale=1;
    sc.maximumZoomScale=5;
    sc.userInteractionEnabled = YES;
    [mainview addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(mainview);
        make.top.equalTo(message.mas_bottom).offset(5*Ratio);
        make.height.mas_equalTo(318*Ratio);
    }];
    
    for (int i=0; i<4; i++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.tag = 1195+i;
        imageV.image = [UIImage imageNamed:_scArr[i]];
        
        [sc addSubview:imageV];
        [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(sc);
            make.size.equalTo(sc);
        }];
        
        DrawImageView *imgV = [[DrawImageView alloc] init];
        imageV.backgroundColor = [UIColor clearColor];
        NSDictionary *spot = [self returnCoordinateArr:i frameOfSubView:CGRectMake(19*Ratio, 19*Ratio, 270*Ratio,275*Ratio)];
        imgV.xDataArr = [spot objectForKey:@"x"];
        imgV.yDataArr = [spot objectForKey:@"y"];
        [imageV addSubview:imgV];
        [imgV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(imageV);
            make.size.equalTo(imageV);
        }];
        
    }
    
    [sc bringSubviewToFront:sc.subviews[_number - 1]];
    nowImage = _number - 1 + 1195;
    
    
#pragma mark = 四个图
    NSArray *butonArr = @[@"pinggu_icon_long",@"pinggu_icon_height",@"pinggu_icon_bmi",@"pinggu_icon_fayu",@"pinggu_icon_long_set",@"pinggu_icon_height_set",@"pinggu_icon_bmi_set",@"pinggu_icon_fayu_set"];
    UIButton *lastBtn = nil;
    for (int i=0; i<4; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[i]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:butonArr[4+i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1190+i;
        [self.view addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mainview.mas_bottom).offset(23*Ratio);
            make.size.mas_equalTo(CGSizeMake(75*Ratio, 57*Ratio));
            if (lastBtn) {
                make.left.equalTo(lastBtn.mas_right).offset(5*Ratio);
            }else{
                make.left.equalTo(self.view).offset(2*Ratio);
            }
        }];
        
        lastBtn = button;
    }

    
}
#pragma mark - scrollview代理相关
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    UIView *view = [scrollView viewWithTag:nowImage];
    if ([view isKindOfClass:[UIImageView class]]) {
         return view;
    }
    return 0;
    
}
#pragma mark - 切换每张图

-(void)buttonClick:(UIButton *)button{
    sc.zoomScale = 1;
    for (int i=0; i<4; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:1190+i];
        butt.selected = NO;
    }
    button.selected = YES;
    
    if (button.tag == 1190) {
        self.title = @"身长曲线图";
    }else if (button.tag == 1191){
        self.title = @"体重曲线图";
    }else if (button.tag == 1192){
        self.title = @"身长体重比";
    }else if (button.tag == 1193){
        self.title = @"发育进程图";
    }

 
    [detailBtn setTitleColor:colorArr[button.tag - 1190] forState:UIControlStateNormal];

    [sc bringSubviewToFront:[sc viewWithTag:button.tag + 5]];
    nowImage = (int)button.tag + 5;
    mainview.backgroundColor = colorArr[button.tag - 1190];
    
}

#pragma mark -绘图的坐标

-(NSDictionary *)returnCoordinateArr:(int)numberOfPicture frameOfSubView:(CGRect)frame{
    NSMutableArray *xArr = [[NSMutableArray alloc] init];
    NSMutableArray *yArr = [[NSMutableArray alloc] init];

    float unitOfX = 0.0;
    float dayUnitOfX = 0.0;
    float unitOfY = 0.0;
    if (numberOfPicture == 0) {
        unitOfX = 7.5*Ratio;
        dayUnitOfX = unitOfX/30;
        unitOfY = 18.5*Ratio/5.0;
        for (OnlineAppraisalImgdata *imgda in _pictureDataArr){
            int day = imgda.monthDay;
            if (day == 31) {
                day = 30;
            }
//            if ([imgda.height floatValue] >= 45) {
                [xArr addObject:[NSString stringWithFormat:@"%lf",(imgda.age*unitOfX)+((day-1)*dayUnitOfX)+frame.origin.x]];
                [yArr addObject:[NSString stringWithFormat:@"%lf",318*Ratio-(unitOfY*([imgda.height floatValue]-45))-(24*Ratio)]];
//            }
            
        }
        
    }else if (numberOfPicture == 1){
        unitOfX = 7.5*Ratio;
        dayUnitOfX = unitOfX/30;
        unitOfY = 18.5*Ratio/2.0;
        for (OnlineAppraisalImgdata *imgda in _pictureDataArr){
            
//            NSLog(@"++++++++++++++++++++++++++++++++++++weight = %f",[imgda.weight floatValue]);
            int day = imgda.monthDay;
            if (day == 31) {
                day = 30;
            }
            if ([imgda.weight floatValue]>=0) {
                [xArr addObject:[NSString stringWithFormat:@"%lf",(imgda.age*unitOfX)+((day-1)*dayUnitOfX)+frame.origin.x]];
                [yArr addObject:[NSString stringWithFormat:@"%lf",318*Ratio-(unitOfY*[imgda.weight floatValue])-(24*Ratio)]];
            }
            
        }
        
    }else if (numberOfPicture == 2){
        int beginX = ((_month<=24)?45:65);
        unitOfX = (_month<=24)?((263.0/(110.0-45)*Ratio)):((263.0/(120.0-65)*Ratio));
        unitOfY = frame.size.height/30.0;
        
        for (OnlineAppraisalImgdata *imgda in _pictureDataArr){
            int day = imgda.monthDay;
            if (day == 31) {
                day = 30;
            }
//            if (([imgda.height floatValue]>=beginX)&&([imgda.weight floatValue]>= 0)&&(imgda.age>=((_month < 25)?0:25))) {

            if (([imgda.weight floatValue]>= 0)&&(imgda.age>=((_month < 25)?0:25))) {
                [xArr addObject:[NSString stringWithFormat:@"%lf",([imgda.height floatValue]-beginX)*unitOfX + +frame.origin.x]];
                [yArr addObject:[NSString stringWithFormat:@"%lf",318*Ratio-(unitOfY*[imgda.weight floatValue])-(24*Ratio)]];
            }
            
        }
        
    }else{
        
        
        [yArr addObject:[NSString stringWithFormat:@"%lf",50*Ratio]];
        [yArr addObject:[NSString stringWithFormat:@"%lf",261*Ratio]];
        int beginX = 12*Ratio;
        unitOfX = 595.0/60.0*Ratio/2.0;
        [xArr addObject:[NSString stringWithFormat:@"%lf",_month*unitOfX +beginX]];
        [xArr addObject:[NSString stringWithFormat:@"%lf",_month*unitOfX +beginX]];

        
        
   
    }

    
    NSDictionary *dic = @{@"x":xArr,@"y":yArr};
    NSLog(@"%d dic = %@",numberOfPicture,dic);
    return dic;
}

#pragma mark - 跳至详情页
-(void)detailBtnClick:(UIButton *)button{
    NSLog(@"%d",nowImage);
    
    PictureDetailViewController *pvc = [[PictureDetailViewController alloc] init];
    pvc.number = nowImage - 1195 + 1;
    pvc.pictureArr = _pictureDataArr;
    pvc.currentMonthFeatureArr = _currentMonthFeatureArr;
    [self.navigationController pushViewController:pvc animated:YES];
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
