//
//  BodyLengthViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/11.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "BodyLengthViewController.h"
#import <QuartzCore/QuartzCore.h>
//#import "DetailViewController.h"
#import "MovieViewController.h"

#define WORDCOLOR MBColor(121, 122, 123, 1)

@interface BodyLengthViewController ()<UIScrollViewDelegate>{
    UIButton *_rightBtn;
    NSDictionary *_record;
//    DetailViewController *dvc;
    NSString *_title;
    UIScrollView *rule;
    void(^_myBlocks)(NSString *number);
    

    float _newData;
}

@end

@implementation BodyLengthViewController


-(instancetype)initWithSex:(BOOL)sex andName:(int)numb{
    if (self = [super init]) {
        self.sex = sex;
        self.name = numb;
      
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.view layoutIfNeeded];
    double old = 0;
    if (_newData != 0) {
        _number.text = [NSString stringWithFormat:@"%.2lf",_newData];
//        _number.text = [NSString stringWithFormat:@"%f",_data];
    }

    if (_name == 1) {
        old = (139*Ratio - 133.5)/70.0 + 20.0;
    
    }else if (_name == 2){
        
        old = (139*Ratio - 132.5)/70.0 + 1.0;

    }else{
        old = (139*Ratio - 133.5)/70.0 + 20.01;
    }
    if ([_number.text floatValue] > 0 ) {
        float x = ([_number.text floatValue]-old)*70.0;
        
        [rule setContentOffset:CGPointMake(x, 0) animated:NO];
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
    yindao.image = [UIImage imageNamed:@"jilu_shenchang_0"];
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    [ciew addSubview:yindao];
    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ciew);
        make.left.and.right.equalTo(ciew);
        make.height.equalTo(@(580*Ratio));
        
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfRecordLength"];
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)removeView{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    [self.view.window sendSubviewToBack:ciew];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    if (_name == 1) {
        if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfRecordLength"]) {
        
            [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
            
            
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    _name = 3;//    self.sex = 0;//女生
//    self.month = 12;
    
    if (_name) {
        if (_name == 1) {
             _title = @"身长";

        }else if (_name == 2){
            _title = @"体重";
        }else if (_name == 3){
            _title = @"头围";
        }else if (_name == 4){
            _title = @"胸围";
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
    
    NSString *path0 = [[NSBundle mainBundle] pathForResource:@"Record" ofType:@"plist"];
    NSDictionary *recordDic = [NSDictionary dictionaryWithContentsOfFile:path0];
    _record = recordDic;

    [self createMainView];

    // Do any additional setup after loading the view.
}
-(void)finish:(UIButton *)button{
    _myBlocks(_number.text);
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)changeDataBlock:(void (^)(NSString *))block{
    
    _myBlocks = [block copy];
    
}
#pragma mark - 身长

-(void)createMainView{
    NSDictionary *shenchang = [_record objectForKey:_title];
    NSString *cankao;
    if (self.sex == 0) {
        cankao = [shenchang objectForKey:@"参考值0"][_month];
    }else{
        cankao = [shenchang objectForKey:@"参考值1"][_month];
        
    }
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    UIScrollView *sc = [[UIScrollView alloc] init];
    sc.delegate = self;
    [self.view addSubview:sc];
    [sc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.and.bottom.equalTo(self.view);
    }];
    UIView *contentView = [[UIView alloc] init];
    [sc addSubview:contentView];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(sc);
        make.width.equalTo(sc);
    }];
    
    
    _number = [[UILabel alloc] init];
    if (_name == 2) {
        if (_data == 0) {
            _number.text = [cankao substringToIndex:3];

        }else{
            _number.text = [NSString stringWithFormat:@"%f",_data];

        }
        
    }else{
        if (_data == 0) {
            if (cankao.length > 4) {
                _number.text = [cankao substringToIndex:4];
            }
            
            
        }else{
            _number.text = [NSString stringWithFormat:@"%f",_data];
            
        }
    }
    
    _newData = [_number.text floatValue];
    _number.textAlignment = NSTextAlignmentCenter;
    _number.font = [UIFont yaHeiFontOfSize:16];
    _number.textColor = MBColor(121, 122, 123, 1);
    [contentView addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(15*Ratio);
        make.size.mas_equalTo(CGSizeMake(75*Ratio, 20*Ratio));
        make.right.equalTo(contentView.mas_centerX);
    }];
    
    UILabel *unit0 = [[UILabel alloc] init];
    unit0.textAlignment = NSTextAlignmentLeft;
    [unit0 makeLabelWithText:(_name == 2)?@"公斤":@"厘米" andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:unit0];
    [unit0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 20*Ratio));
        make.left.equalTo(contentView.mas_centerX);
        make.centerY.equalTo(_number);
    }];
    
    UILabel *cankaozhi = [[UILabel alloc] init];
    [cankaozhi makeLabelWithText:[NSString stringWithFormat:@"参考值：%@",cankao] andTextColor:MBColor(250, 116, 170, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    cankaozhi.textAlignment = NSTextAlignmentCenter;
    cankaozhi.adjustsFontSizeToFitWidth = YES;
    [contentView addSubview:cankaozhi];
    [cankaozhi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(unit0.mas_bottom).offset(10*Ratio);
        make.size.mas_equalTo(CGSizeMake(180*Ratio, 13*Ratio));
        
    }];
    
#pragma mark = 尺子
    
    UIImageView *scrollBg = [[UIImageView alloc] init];
    if (_name%2 == 1) {
        scrollBg.image = [UIImage imageNamed:@"jilu_long_bg"];

    }else{
        scrollBg.image = [UIImage imageNamed:@"jilu_height_bg"];

    }
    scrollBg.userInteractionEnabled = YES;
    [contentView addSubview:scrollBg];
    
    [scrollBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(cankaozhi.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(290*Ratio, 66*Ratio));
    }];
    rule = [[UIScrollView alloc] init];
    rule.showsHorizontalScrollIndicator = NO;
    rule.delegate = self;
    rule.bounces = NO;
    [scrollBg addSubview:rule];
    [rule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollBg).offset(20*Ratio);
        make.left.equalTo(scrollBg).offset(5*Ratio);
        make.size.mas_equalTo(CGSizeMake(205*Ratio, 39.5));
        
    }];
    UIView *ruleContentView = [[UIView alloc] init];
    [rule addSubview:ruleContentView];
    [ruleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rule);
        make.height.equalTo(rule);
    }];
    
    UIImageView *ruleImg = [[UIImageView alloc] init];
    if (_name == 1) {
        ruleImg.image = [UIImage imageNamed:@"height1"];

    }else if(_name == 2){
        ruleImg.image = [UIImage imageNamed:@"weight-1"];

    }else{
        ruleImg.image = [UIImage imageNamed:@"head"];
    }
    [ruleContentView addSubview:ruleImg];
    [ruleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ruleContentView);
        make.top.equalTo(ruleContentView);
        make.height.mas_equalTo(39.5);
        if (_name == 1) {
            make.width.mas_equalTo(7970);
        }else if(_name == 2){
            make.width.mas_equalTo(4399);
        }else{
            make.width.mas_equalTo(3068);
        }
    }];
    [ruleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ruleImg);
    }];
    
    //标尺
    UILabel *scaleSmart = [[UILabel alloc] init];
    scaleSmart.backgroundColor = MBColor(234, 105, 151, 1);
    [scrollBg addSubview:scaleSmart];
    [scaleSmart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(rule);
        make.centerX.equalTo(scrollBg);
        make.size.mas_equalTo(CGSizeMake(2*Ratio, 16*Ratio));
    }];
    
    
    id referToArr = [shenchang objectForKey:@"增长"][_month];
     UILabel *lastReferTo = nil;
    if ([referToArr isKindOfClass:[NSString class]]) {
        
        NSString *message = (NSString *)referToArr;
        lastReferTo = [[UILabel alloc] init];
        lastReferTo.numberOfLines = 0;
        [lastReferTo makeLabelWithText:message andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
//        lastReferTo.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:lastReferTo];
        
        [lastReferTo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(scrollBg.mas_bottom).offset(5*Ratio);
            make.left.equalTo(contentView).offset(15*Ratio);
            make.width.equalTo(contentView).offset(-30*Ratio);
            if ([[shenchang objectForKey:@"增长"][_month] length]>0) {
                CGSize size = [lastReferTo sizeThatFits:CGSizeMake(300*Ratio, 2000)];
                make.height.equalTo(@(size.height));
            }else{
                make.height.equalTo(@(0));
            }
        }];
    }else if ([referToArr isKindOfClass:[NSArray class]]){
         NSArray *mess = (NSArray *)referToArr;
//        NSLog(@"%@",mess);
        for (int i=0; i<[mess count]; i++) {
            UILabel *referTo0 = [[UILabel alloc] init];
            referTo0.numberOfLines = 0;
            //        mesa.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
            [referTo0 makeLabelWithText:mess[i] andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:referTo0.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, referTo0.text.length)];
            referTo0.attributedText = attributedString;
            CGSize size = [referTo0 sizeThatFits:CGSizeMake(286*Ratio, 200000)];
            [contentView addSubview:referTo0];
            [referTo0 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(286*Ratio));
                make.height.equalTo(@(size.height));
                make.left.equalTo(contentView).offset(15*Ratio);
                if (lastReferTo) {
                    make.top.equalTo(lastReferTo.mas_bottom).offset(5*Ratio);
                }else{
                    make.top.equalTo(scrollBg.mas_bottom).offset(5*Ratio);
                }
            }];
            
            lastReferTo = referTo0;
            
        }

    }
   
    
    
    
    
    
   
    
    // 加辅助线
    
   
    

#pragma mark = 家庭正确的身长测量方法
    UILabel *measure = [[UILabel alloc] init];
    measure.textAlignment = NSTextAlignmentCenter;
    [measure makeLabelWithText:[NSString stringWithFormat:@"家庭正确的%@测量方法",_title] andTextColor:MBColor(249,92,161,1) andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
    [contentView addSubview:measure];
    [measure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastReferTo.mas_bottom).offset(23*Ratio);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(320*Ratio, 18*Ratio));
    }];
    
    [measure addShadeLayerFrom:0 andTo:320*Ratio];
    
    
    
    
    
    NSArray *measu = [shenchang objectForKey:@"家庭正确的身长测量方法"];
    UILabel *lastMeasuLabel = nil;
    for (int i=0; i<measu.count; i++) {
        UILabel *mesa = [[UILabel alloc] init];
        mesa.numberOfLines = 0;
//        mesa.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
        [mesa makeLabelWithText:measu[i] andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(286*Ratio, 200000)];
        [contentView addSubview:mesa];
        [mesa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(286*Ratio));
            make.height.equalTo(@(size.height));
            make.left.equalTo(contentView).offset(15*Ratio);
            if (lastMeasuLabel) {
                make.top.equalTo(lastMeasuLabel.mas_bottom).offset(5*Ratio);
            }else{
                make.top.equalTo(measure.mas_bottom).offset(5*Ratio);
            }
        }];
        
        lastMeasuLabel = mesa;
        
    }
    
   
#pragma mark = 小视频
    NSString *movieStr = nil;
    if (_name == 1) {
        movieStr = @"celiangshengao1";
    }else if(_name == 2){
        movieStr = @"celiangtizhong1";
    }else if (_name == 3){
        movieStr = @"celiangtouwei1";
    }else if (_name == 4){
        movieStr = @"celiangxiongwei1";
    }
     /*
    NSString *mov = [[NSBundle mainBundle] pathForResource:movieStr ofType:@"mov"];
    NSURL *url = [NSURL fileURLWithPath:mov];
    
    dvc = [[DetailViewController alloc] initWithContentURL:url];
    dvc.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
    dvc.moviePlayer.shouldAutoplay = NO;
    [dvc.moviePlayer prepareToPlay];
    dvc.moviePlayer.controlStyle = MPMovieControlStyleNone;
    [self addChildViewController:dvc];
    */
    UIImageView *movieView = [[UIImageView alloc] init];
    movieView.image = [UIImage imageNamed:movieStr];
    movieView.userInteractionEnabled = YES;
    
    [contentView addSubview:movieView];
    [movieView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastMeasuLabel.mas_bottom).offset(23*Ratio);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
    }];
    
    UIImageView *movieView1 = [[UIImageView alloc] init];
    movieView1.image = [UIImage imageNamed:@"jilu_dabofang"];
    
    movieView1.userInteractionEnabled = YES;
    UITapGestureRecognizer *movieTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moviePlay)];
   
    [movieView1 addGestureRecognizer:movieTap];
    [contentView addSubview:movieView1];
    [movieView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lastMeasuLabel.mas_bottom).offset(23*Ratio);
        make.centerX.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
    }];
    
#pragma mark = 备注
    
//    UILabel *beizhu = [[UILabel alloc] init];
//    
//    [beizhu makeLabelWithText:@"备注" andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:14*Ratio]];
//    
//    [contentView addSubview:beizhu];
//    
//    [beizhu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(movieView.mas_bottom).offset(10*Ratio);
//        make.left.equalTo(contentView);
//        make.width.equalTo(@(290*Ratio))
//    }];
    NSArray *beiz = [shenchang objectForKey:@"备注"];

    UILabel *lastBeiZhu = nil;
    for (int i=0; i<[beiz count]; i++) {
        
        //        CGRect rect = [beiz[i] boundingRectWithSize:CGSizeMake(sc.frame.size.width-referTo.frame.origin.x, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
        UILabel *beizhu = [[UILabel alloc] init];
        [beizhu makeLabelWithText:beiz[i] andTextColor:WORDCOLOR andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
        if (i == 0) {
            beizhu.text = [NSString stringWithFormat:@"备注：%@",beizhu.text];
            [beizhu addShadeLayerFrom:-15*Ratio andTo:320*Ratio];
        }
        beizhu.numberOfLines = 0;
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:beizhu.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, beizhu.text.length)];
        
        beizhu.attributedText = attributedString;
       
        CGSize size = [beizhu sizeThatFits:CGSizeMake(290*Ratio, 2000)];
         [contentView addSubview:beizhu];
        [beizhu mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(contentView).offset(15*Ratio);
            make.size.mas_equalTo(CGSizeMake(290*Ratio, size.height));
            if (lastBeiZhu) {
                make.top.equalTo(lastBeiZhu.mas_bottom).offset(5*Ratio);
            }else{
                make.top.equalTo(movieView.mas_bottom).offset(10*Ratio);
            }
            
        }];
        lastBeiZhu = beizhu;
        
        
    }
 
    
    
    
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastBeiZhu).offset(100*Ratio);
        
    }];

    
    
    
}

#pragma mark - 播放视频

-(void)moviePlay{
    
#pragma mark = 小视频
    NSString *movieStr = nil;
    if (_name == 1) {
        movieStr = @"celiangshengao1";
    }else if(_name == 2){
        movieStr = @"celiangtizhong1";
    }else if (_name == 3){
        movieStr = @"celiangtouwei1";
    }else if (_name == 4){
        movieStr = @"celiangxiongwei1";
    }
    
    NSString *mov = [[NSBundle mainBundle] pathForResource:movieStr ofType:@"mov"];
    NSURL *url = [NSURL fileURLWithPath:mov];

    
    MovieViewController *movie = [[MovieViewController alloc] initWithContentURL:url];
    
    movie.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    movie.moviePlayer.shouldAutoplay = YES;
    [movie.moviePlayer prepareToPlay];
    [self presentViewController:movie animated:NO completion:nil];
    movie.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    
    [movie.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
}

#pragma mark - scrollView滑动相关

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    double old = 22.20;
    

    if (scrollView == rule) {
        if (_name == 1) {
            double old = (139*Ratio - 133.5)/70.0 + 20.0;
            //    NSLog(@"%lf",old);
            _number.text = [NSString stringWithFormat:@"%.2lf",scrollView.contentOffset.x/70.0 + old];
        }else if (_name == 2){
            
            double old = (139*Ratio - 132.5)/70.0 + 1.0;
            
            _number.text = [NSString stringWithFormat:@"%.2lf",scrollView.contentOffset.x/70.0 + old];
            
        }else{
            double old = (139*Ratio - 133.5)/70.0 + 20.01;
            
            _number.text = [NSString stringWithFormat:@"%.2lf",scrollView.contentOffset.x/70.0 + old];
        }
        
        _newData = [_number.text floatValue];
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
