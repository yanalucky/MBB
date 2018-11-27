//
//  FeedViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/4/18.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FeedViewController.h"
//#import "DetailViewController.h"
#import "DataView.h"
#import "MovieViewController.h"


@interface FeedViewController ()<UIScrollViewDelegate,UIPickerViewDelegate,UIPickerViewDataSource>{
    UIButton *_rightBtn;
    NSDictionary *_record;

    NSString *_title;
    UIScrollView *rule;
    
    UILabel *_number;
    DataView *feedNum;
    void(^_myBlocks)(NSString *number0 , NSString *number1);

    UIView *pickerBgView;//选择器
    UIPickerView *picker;
    
    
    int _newData;
    int _newData1;

}

@end

@implementation FeedViewController

-(instancetype)initWithMonth:(int)month andName:(int)numb{
    if (self = [super init]) {
        
        self.month = month;
        self.name = numb;
        
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [self.view layoutIfNeeded];
    
    if (_newData != 0) {
        _number.text = [NSString stringWithFormat:@"%d",_newData];
    }
    double old = (114*Ratio - 117.5)/1.30 + 0.0;
    float x = ([_number.text floatValue]-old)*1.3;
    
    [rule setContentOffset:CGPointMake(x, 0) animated:NO];
    
    [feedNum.button setTitle:[NSString stringWithFormat:@"%d",_newData1] forState:UIControlStateSelected];
    [feedNum.button setTitle:[NSString stringWithFormat:@"%d",_newData1] forState:UIControlStateNormal];
    
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
    UIEdgeInsets inset = UIEdgeInsetsMake((64-(64*Ratio))*2, 0, 0, 0);
    
    yindao.image = [[UIImage imageNamed:@"jilu_weiyang_0"] resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
//    yindao.image = [UIImage imageNamed:@"jilu_weiyang_0"];
    yindao.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeView)];
    [yindao addGestureRecognizer:tap];
    [ciew addSubview:yindao];
    [yindao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(ciew);
        make.top.equalTo(ciew);
        make.right.equalTo(ciew);
    }];
    [[NSUserDefaults standardUserDefaults] setObject:@"YES" forKey:@"manyOfFeed"];
    [self.view.window bringSubviewToFront:ciew];
    
    
}
-(void)removeView{
    
    UIView *ciew = [self.view.window viewWithTag:6666];
    ciew.hidden = YES;
    ciew.backgroundColor = [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:0.3];
    
    [self.view.window sendSubviewToBack:ciew];
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"manyOfFeed"]) {
    
        [self performSelector:@selector(showAlertView) withObject:nil afterDelay:0.1];
        
        
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    //    self.sex = 0;
    //女生
    if (_name) {
        if (_name == 1) {
            _title = @"母乳喂养";
            
        }else{
            _title = @"配方奶喂养";
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
    

    
    [self createInterface];
    // Do any additional setup after loading the view.
}
#pragma mark - 完成

-(void)finish:(UIButton *)button{
    
    
   
    _myBlocks(_number.text,feedNum.button.titleLabel.text);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)changeDataBlock:(void (^)(NSString *, NSString *))block{
    _myBlocks = [block copy];
}
-(void)createInterface{
    
    NSDictionary *milkDic = [_record objectForKey:@"奶量"];
    NSString *cankao = [milkDic objectForKey:@"参考值"][_month];
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
    if (_data) {
        _number.text = [NSString stringWithFormat:@"%d",_data];
    }else{
        _number.text = @"130";
    }
    _newData = [_number.text intValue];
    
    _number.textAlignment = NSTextAlignmentCenter;
    _number.font = [UIFont yaHeiFontOfSize:24*Ratio];
    _number.textColor = MBColor(121, 122, 123, 1);
    [contentView addSubview:_number];
    [_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView).offset(18*Ratio);
        make.size.mas_equalTo(CGSizeMake(45*Ratio, 20*Ratio));
        make.left.equalTo(contentView).offset(50*Ratio);
    }];
    
    UILabel *unit = [[UILabel alloc] init];
    [unit makeLabelWithText:@"毫升" andTextColor:MBColor(136, 136, 136, 1) andFont:[UIFont yaHeiFontOfSize:18*Ratio]];
    [contentView addSubview:unit];
    [unit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_number.mas_right).offset(15*Ratio);
        make.centerY.equalTo(_number);
        make.size.mas_equalTo(CGSizeMake(50*Ratio, 22*Ratio));
    }];
    
#pragma mark = 尺子
    
    UIImageView *scrollBg = [[UIImageView alloc] init];
    scrollBg.image = [UIImage imageNamed:@"naiping_bac"];
    scrollBg.userInteractionEnabled = YES;
    [contentView addSubview:scrollBg];
    
    [scrollBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(15*Ratio);
        make.top.equalTo(_number.mas_bottom).offset(18*Ratio);
        make.size.mas_equalTo(CGSizeMake(305*Ratio, 114*Ratio));
    }];
    rule = [[UIScrollView alloc] init];
    rule.showsHorizontalScrollIndicator = NO;
    rule.delegate = self;
    rule.bounces = NO;
    [scrollBg addSubview:rule];
    [rule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollBg).offset(42.5*Ratio);
        make.left.equalTo(scrollBg).offset(90*Ratio);
        make.size.mas_equalTo(CGSizeMake(205*Ratio, 52));
        
    }];
    UIView *ruleContentView = [[UIView alloc] init];
    [rule addSubview:ruleContentView];
    [ruleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(rule);
        make.height.equalTo(rule);
    }];
    UIImageView *ruleImg = [[UIImageView alloc] init];
    ruleImg.image = [UIImage imageNamed:@"naiping-1"];
    [ruleContentView addSubview:ruleImg];
    [ruleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ruleContentView);
        make.top.equalTo(ruleContentView);
        make.height.mas_equalTo(52);
        make.width.mas_equalTo(551);
    }];
    [ruleContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ruleImg);
    }];
    
    //标尺
    UILabel *scaleSmart = [[UILabel alloc] init];
    scaleSmart.backgroundColor = MBColor(234, 105, 151, 1);
    [scrollBg addSubview:scaleSmart];
    [scaleSmart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(scrollBg).offset(204*Ratio);
        make.centerY.equalTo(scrollBg);
        make.size.mas_equalTo(CGSizeMake(3, 30*Ratio));
    }];
#pragma mark = 次数
    feedNum = [[DataView alloc] init];
    
    [feedNum makeViewWithTitle:(_name == 1)?@"人乳喂养次数":@"配方奶喂养次数" andUnit:@"次/天" andNumberData:[NSString stringWithFormat:@"%d",_data1]];
    [feedNum.button addTarget:self action:@selector(feedNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:feedNum];
    [feedNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).offset(20*Ratio);
        make.top.equalTo(scrollBg.mas_bottom).offset(16*Ratio);
        make.size.mas_equalTo(CGSizeMake(280*Ratio, 47*Ratio));
    }];
    _newData1 = _data1;
    
    [feedNum addShadeLayerFrom:-21 andTo:300*Ratio];
    
    UILabel *cankaoLab = [[UILabel alloc] init];
    [cankaoLab makeLabelWithText:[NSString stringWithFormat:@"参考值：%@",cankao] andTextColor:MBColor(95, 95, 95, 1) andFont:[UIFont yaHeiFontOfSize:11*Ratio]];
    cankaoLab.numberOfLines = 0;
    [contentView addSubview:cankaoLab];
    
    [cankaoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(feedNum.mas_bottom).offset(5*Ratio);
        make.left.equalTo(contentView).offset(15*Ratio);
        make.width.equalTo(contentView).offset(-30*Ratio);
        CGSize size = [cankaoLab sizeThatFits:CGSizeMake(290*Ratio, 2000)];
        make.height.equalTo(@(size.height));
    }];
    
    [cankaoLab addShadeLayerFrom:-15*Ratio andTo:320*Ratio];
#pragma mark = 喂养方法
    
    UILabel *titleLab = [[UILabel alloc] init];
    [titleLab makeLabelWithText:_title andTextColor:MBColor(252, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.equalTo(cankaoLab.mas_bottom).offset(20*Ratio);
        make.size.mas_equalTo(CGSizeMake(110*Ratio, 17*Ratio));
    }];
    [titleLab addShadeLayerFrom:-105*Ratio andTo:320*Ratio];
    UILabel *lastFeedLabel = nil;
    if (_name == 1) {
        NSArray *mumFeedArr = [milkDic objectForKey:@"0~11母乳喂养"];
        for (int i=0; i<mumFeedArr.count; i++) {
            UILabel *mesa = [[UILabel alloc] init];
            mesa.numberOfLines = 0;
            [mesa makeLabelWithText:mumFeedArr[i] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
            mesa.attributedText = attributedString;
            CGSize size = [mesa sizeThatFits:CGSizeMake(290*Ratio, 200000)];
            [contentView addSubview:mesa];
            [mesa mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(290*Ratio));
                make.height.equalTo(@(size.height));
                make.left.equalTo(contentView).offset(15*Ratio);
                if (lastFeedLabel) {
                    make.top.equalTo(lastFeedLabel.mas_bottom).offset(5*Ratio);
                }else{
                    make.top.equalTo(titleLab.mas_bottom).offset(10*Ratio);
                }
            }];
            
            lastFeedLabel = mesa;
            
        }

    }else{
        NSDictionary *otherFeedDic = [milkDic objectForKey:@"配方奶喂养"];
        UILabel *mesa = [[UILabel alloc] init];
        mesa.numberOfLines = 0;
        [mesa makeLabelWithText:(_month<3)?[otherFeedDic objectForKey:@"0~3个月"]:[otherFeedDic objectForKey:@"4个月以后"] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
        [paragraphStyle setLineSpacing:6];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
        mesa.attributedText = attributedString;
        CGSize size = [mesa sizeThatFits:CGSizeMake(290*Ratio, 200000)];
        [contentView addSubview:mesa];
        [mesa mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@(290*Ratio));
            make.height.equalTo(@(size.height));
            make.left.equalTo(contentView).offset(15*Ratio);
            make.top.equalTo(titleLab.mas_bottom).offset(5*Ratio);
        }];
        
       
       
        UILabel *milkFeedLab = [[UILabel alloc] init];
        [milkFeedLab makeLabelWithText:@"奶制品喂养" andTextColor:MBColor(252, 109, 166, 1) andFont:[UIFont yaHeiFontOfSize:15*Ratio]];
        milkFeedLab.textAlignment = NSTextAlignmentCenter;
        [contentView addSubview:milkFeedLab];
        [milkFeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(contentView);
            make.top.equalTo(mesa.mas_bottom).offset(20*Ratio);
            make.size.mas_equalTo(CGSizeMake(110*Ratio, 17*Ratio));
        }];
        [milkFeedLab addShadeLayerFrom:-105*Ratio andTo:320*Ratio];

        

        NSArray *milkFeedArr = [milkDic objectForKey:@"其他奶制品喂养"];
        for (int i=0; i<milkFeedArr.count; i++) {
            UILabel *mesa = [[UILabel alloc] init];
            mesa.numberOfLines = 0;
            [mesa makeLabelWithText:milkFeedArr[i] andTextColor:MBColor(102, 102, 102, 1) andFont:[UIFont yaHeiFontOfSize:12*Ratio]];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:mesa.text];;
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
            [paragraphStyle setLineSpacing:6];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, mesa.text.length)];
            mesa.attributedText = attributedString;
            CGSize size = [mesa sizeThatFits:CGSizeMake(290*Ratio, 200000)];
            [contentView addSubview:mesa];
            [mesa mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@(290*Ratio));
                make.height.equalTo(@(size.height));
                make.left.equalTo(contentView).offset(15*Ratio);
                if (lastFeedLabel) {
                    make.top.equalTo(lastFeedLabel.mas_bottom).offset(5*Ratio);
                }else{
                    make.top.equalTo(milkFeedLab.mas_bottom).offset(10*Ratio);
                }
            }];
            
            lastFeedLabel = mesa;
            
        }
        
    }
    
#pragma mark = 小视频
    UIView *lastMovieView = nil;
    NSArray *movArr = @[@"mrxb",@"mrws",@"mrbqs",@"mrzq",@"mrcw",@"rgwy"];
    if (_month > 11) {
        
        /*
        NSString *mov = [[NSBundle mainBundle] pathForResource:@"rgwy" ofType:@"mov"];
        NSURL *url = [NSURL fileURLWithPath:mov];
        DetailViewController *dvc = [[DetailViewController alloc] initWithContentURL:url];
        dvc.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
        dvc.moviePlayer.shouldAutoplay = NO;
        [dvc.moviePlayer prepareToPlay];
        dvc.moviePlayer.controlStyle = MPMovieControlStyleNone;
        [self addChildViewController:dvc];
        UIView *movieView = dvc.view;
        //    movieView.userInteractionEnabled = YES;
        
        [contentView addSubview:movieView];
        [movieView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
            make.centerX.equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
        }];
        */
        UIImageView *movieView = [[UIImageView alloc] init];
        movieView.image = [UIImage imageNamed:@"rgwy"];
        movieView.userInteractionEnabled = YES;
        
        [contentView addSubview:movieView];
        [movieView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
            make.centerX.equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
        }];
        
        UIImageView *movieView1 = [[UIImageView alloc] init];
        movieView1.image = [UIImage imageNamed:@"jilu_dabofang"];
        movieView1.tag = 1286;
        movieView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *movieTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moviePlay:)];
        
        [movieView1 addGestureRecognizer:movieTap];
        [contentView addSubview:movieView1];
        [movieView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
            make.centerX.equalTo(contentView);
            make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
        }];

        
        
        
        
        lastMovieView = movieView;
    }else {
        
        for (int i=0; i<[movArr count]; i++) {
            /*
            NSString *mov = [[NSBundle mainBundle] pathForResource:movArr[i] ofType:@"mov"];
            NSURL *url = [NSURL fileURLWithPath:mov];
            DetailViewController *dvc = [[DetailViewController alloc] initWithContentURL:url];
            dvc.moviePlayer.scalingMode = MPMovieScalingModeAspectFill;
            dvc.moviePlayer.shouldAutoplay = NO;
            [dvc.moviePlayer prepareToPlay];
            dvc.moviePlayer.controlStyle = MPMovieControlStyleNone;
            [self addChildViewController:dvc];

            UIView *movieView = dvc.view;
            //    movieView.userInteractionEnabled = YES;
            
            [contentView addSubview:movieView];
            [movieView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(contentView);
                make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
                
                if (lastMovieView) {
                    make.top.equalTo(lastMovieView.mas_bottom).offset(23*Ratio);
                }else{
                    make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
                }
            }];
             
             */
            
            
            UIImageView *movieView = [[UIImageView alloc] init];
            movieView.image = [UIImage imageNamed:movArr[i]];
            movieView.userInteractionEnabled = YES;
            
            [contentView addSubview:movieView];
            [movieView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(contentView);
                make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
                
                if (lastMovieView) {
                    make.top.equalTo(lastMovieView.mas_bottom).offset(23*Ratio);
                }else{
                    make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
                }
            }];
            
            UIImageView *movieView1 = [[UIImageView alloc] init];
            movieView1.image = [UIImage imageNamed:@"jilu_dabofang"];
            movieView1.tag = 1281+i;
            movieView1.userInteractionEnabled = YES;
            UITapGestureRecognizer *movieTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moviePlay:)];
            
            [movieView1 addGestureRecognizer:movieTap];
            [contentView addSubview:movieView1];
            [movieView1 mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.centerX.equalTo(contentView);
                make.size.mas_equalTo(CGSizeMake(226*Ratio, 170*Ratio));
                
                if (lastMovieView) {
                    make.top.equalTo(lastMovieView.mas_bottom).offset(23*Ratio);
                }else{
                    make.top.equalTo(lastFeedLabel.mas_bottom).offset(23*Ratio);
                }
            }];
            
            lastMovieView = movieView;
        }
        
        
    }
    
   

    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(lastMovieView).offset(50*Ratio);
        
    }];

    
    
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

    
    
}
-(void)feedNumClick:(UIButton *)button{
    
    [picker selectRow:[button.titleLabel.text intValue] inComponent:0 animated:NO];
    pickerBgView.hidden = NO;
    
    [self.view bringSubviewToFront:pickerBgView];
    
}


#pragma mark - scrollView滑动相关

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //    double old = 22.20;
    
    
    if (scrollView == rule) {
        double old = (114*Ratio - 117.5)/1.30 + 0.0;
        //    NSLog(@"%lf",old);
        _number.text = [NSString stringWithFormat:@"%.f",scrollView.contentOffset.x/1.3 + old];
        
        _newData = [_number.text intValue];
    }
    
    
}
#pragma mark - 播放视频

-(void)moviePlay:(UITapGestureRecognizer *)tap{
    
    NSArray *movArr = @[@"mrxb",@"mrws",@"mrbqs",@"mrzq",@"mrcw",@"rgwy"];

    NSString *mov = [[NSBundle mainBundle] pathForResource:movArr[tap.view.tag - 1281] ofType:@"mov"];
    NSURL *url = [NSURL fileURLWithPath:mov];
    
    
    MovieViewController *movie = [[MovieViewController alloc] initWithContentURL:url];
    
    movie.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    movie.moviePlayer.shouldAutoplay = YES;
    [movie.moviePlayer prepareToPlay];
    [self presentViewController:movie animated:NO completion:nil];
    movie.moviePlayer.controlStyle = MPMovieControlStyleFullscreen;
    
    [movie.moviePlayer.view setBackgroundColor:[UIColor clearColor]];
}
#pragma mark - 选择器相关

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 20;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
   
    return 320*Ratio;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    
    
    feedNum.button.selected = YES;
    [feedNum.button setTitle:[NSString stringWithFormat:@"%ld",(long)row] forState:UIControlStateSelected];
    [feedNum.button setTitle:[NSString stringWithFormat:@"%ld",(long)row] forState:UIControlStateNormal];
    _newData1 = (int)row;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    
    return [NSString stringWithFormat:@"%ld",(long)row];
    
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
