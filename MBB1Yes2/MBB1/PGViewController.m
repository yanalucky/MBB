//
//  PGViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "PGViewController.h"
#import "AppDelegate.h"
#import "MyView.h"
#import "MenuView.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageOperation.h"
#import "PictureViewController.h"
#import "SvGifView.h"
#import <ImageIO/ImageIO.h>
@interface PGViewController ()<UIScrollViewDelegate>{
    UIColor *wordColor;
    UIColor *bgColor;
    UIScrollView *sv;
    UIScrollView *sv0;
    NSData *imageData;
    LoginUserNSObject *_user;
    int _month;
    NSArray *arr;
//    SvGifView *_gifView;
    
//    UIImageView *_gifView;
    int _numberOfStar;
    NSURL *_url0;
    
    UIView *whiteView;
    UILabel *tishiLabel;
    
}

@end

@implementation PGViewController

#pragma mark - gifView相关


- (void)loadGIFFrom:(NSURL *)url to:(UIImageView *)imageView {
    NSData *gifData = [NSData dataWithContentsOfURL:url];
    [self loadGIFData:gifData to:imageView];
}

- (void)loadGIFData:(NSData *)data to:(UIImageView *)imageView {
    NSMutableArray *frames = nil;
    CGImageSourceRef src = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    CGFloat animationTime = 0.f;
    if (src) {
        size_t l = CGImageSourceGetCount(src);
        frames = [NSMutableArray arrayWithCapacity:l];
        for (size_t i = 0; i < l; i++) {
            CGImageRef img = CGImageSourceCreateImageAtIndex(src, i, NULL);
            NSDictionary *properties = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(src, i, NULL));
            NSDictionary *frameProperties = [properties objectForKey:(NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *delayTime = [frameProperties objectForKey:(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
            animationTime += [delayTime floatValue];
            if (img) {
                [frames addObject:[UIImage imageWithCGImage:img]];
                CGImageRelease(img);
            }
        }
        CFRelease(src);
    }
    [imageView setImage:[frames objectAtIndex:frames.count-1]];
    [imageView setAnimationImages:frames];
    [imageView setAnimationDuration:animationTime];
    [imageView setAnimationRepeatCount:1];
    [imageView startAnimating];
//    [imageView startAnimating];
}

-(void)viewWillAppear:(BOOL)animated{
   
    
    
    
    [_gifView startAnimating];
    NSLog(@"%@",NSStringFromCGRect(_gifView.frame));
    [self.view sendSubviewToBack:sv];
   

   

    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSLog(@"report state - %d",delegate.report);
    if (delegate.report > 1) {
        whiteView.hidden = YES;
    }else if(delegate.report == 1){
        tishiLabel.text = @"线上评估将在一周后反馈，请您耐心等待";
        whiteView.hidden = NO;
    }else if (delegate.report == 0){
        tishiLabel.text = @"您需要先提交记录，医生才能对宝宝进行评估";
        whiteView.hidden = NO;
    }
    
}

-(void)viewDidAppear:(BOOL)animated{
    
    [sv setContentOffset:CGPointMake(0, 0)];
    [sv0 setContentOffset:CGPointMake(0, 0)];
    if ((_audioPlayer == nil)&&(_numberOfStar-1>=0)) {
        
        _audioPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:_url0 error:nil];
        _audioPlayer.numberOfLoops = _numberOfStar-1;
        [_audioPlayer prepareToPlay];
        [_audioPlayer play];

    }
    
    UIButton *button = (UIButton *) [self.view viewWithTag:150];
    button.selected = YES;
    UIButton *button1 = (UIButton *)[self.view viewWithTag:151];
    button1.selected = NO;
    UIImageView *image = (UIImageView *)[self.view viewWithTag:160];
    image.hidden = NO;
    UIImageView *image1 = (UIImageView *)[self.view viewWithTag:161];
    image1.hidden = YES;

}
-(void)viewDidDisappear:(BOOL)animated{
    
    [_audioPlayer stop];
    _audioPlayer = nil;
//    [_gifView removeFromSuperview];
    
}


- (void)viewDidLoad {
    
//    [_audioPlayer prepareToPlay];
    //音乐播放器播放前，需要有一个预加载的过程
    
    _numberOfStar = 0;
//    CGRect fra
//    self.view.backgroundColor = [UIColor whiteColor];
    self.view.alpha = 1;
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    //1.要播放的文件的路径
    NSString *path00 = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"star"] ofType:@"mp3"];
    //2.把文件路径封装成一个url。
    _url0 = [NSURL fileURLWithPath:path00];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        _user = user;
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    [self createUI];
    // Do any additional setup after loading the view.
//    UIControl *control = [[UIControl alloc] initWithFrame:self.view.bounds];
//    [control addTarget:self action:@selector(toucheAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:control];
    
}

-(void)createUI{
    self.view.backgroundColor = [UIColor yellowColor];
    arr = @[@"线上评估",@"线下检查",@"编号",@"出生日期",@"姓名",@"月龄",@"性别",@"报告时间",@"shenchangshengao.jpg",@"tizhong.jpg",@"shengaotizhongbi.jpg",@"shenchangtizhongbi(0~2).jpg"];
    NSMutableArray *textArr = [[NSMutableArray alloc] init];
    if (_user.result.user.filecode) {
        [textArr addObject:_user.result.user.filecode];
    }else{
        [textArr addObject:@""];
    }
    
//    [textArr]
    if (_user.result.user.birthday) {
        [textArr addObject:_user.result.user.birthday];

    }else{
        [textArr addObject:@""];
    }
    if (_user.result.user.feedingtype) {
        
        int enter = [_user.result.user.feedingtype intValue];
        if (enter == 1) {
            [textArr addObject:@"足月儿"];
        }else if (enter == 2){
            [textArr addObject:@"早产儿"];
        }else if (enter == 3){
            [textArr addObject:@"低出生体重"];
        }else{
            [textArr addObject:@""];
        }
    }else{
        [textArr addObject:@""];

    }
    if (_user.result.user.truename) {
        [textArr addObject:_user.result.user.truename];

    }else{
        [textArr addObject:@""];
    }
    
    NSArray *month = [[NSUserDefaults standardUserDefaults] objectForKey:@"time"];
    _month = [month[0] intValue]*12+[month[1] intValue];
    [textArr addObject:[NSString stringWithFormat:@"%d",_month + 1]];
    if (_user.result.user.borntype) {
        int bornType = [_user.result.user.borntype intValue];
        if (bornType == 1) {
            [textArr addObject:@"母乳喂养"];
        }else if (bornType == 2){
            [textArr addObject:@"配方奶喂养"];
        }else if (bornType == 3){
            [textArr addObject:@"混合喂养"];
        }else{
            [textArr addObject:@""];
        }
    }else{
        [textArr addObject:@""];
    }
    
    if (self.sex == 1) {
        [textArr addObject:@"男"];
    }else{
        [textArr addObject:@"女"];
    }
    if (_user.result) {
        if (_user.result.onlineAppraisal) {
            if (_user.result.onlineAppraisal.appraisaltime) {
                [textArr addObject:[_user.result.onlineAppraisal.appraisaltime substringToIndex:10]];
                
            }else{
                [textArr addObject:@""];
            }
        }
    }
    
    
    for (int i=0; i<2; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(463+120*i, 90, 120, 40);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        button.tag = 150+i;
        button.titleLabel.font = [UIFont yaHeiFontOfSize:18];
        [button setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
        [button setTitleColor:wordColor forState:UIControlStateSelected];
        button.titleLabel.font = [UIFont yaHeiFontOfSize:22];
        button.titleLabel.textColor = WORDDARKCOLOR;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:button];
        
        
        UIImageView   *lable = [[UIImageView alloc] initWithFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y+button.frame.size.height, button.frame.size.width, 4)];
        lable.image = [UIImage imageNamed:@"yiliao-xian" ofSex:self.sex];
        lable.tag = 160+i;
        lable.hidden = YES;
        [self.view addSubview:lable];
        if (i==0) {
            lable.hidden = NO;
            button.selected = YES;
        }
    }
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(175, 134, 826, 1.5)];
    line.backgroundColor = wordColor;
    [self.view addSubview:line];
    
    
    UIView *view00 = [[UIView alloc] initWithFrame:CGRectMake(175, 147, 826, self.view.frame.size.height)];
    view00.backgroundColor = [UIColor whiteColor];
    view00.alpha = 1;
     [self.view addSubview:view00];
    
    
    
    whiteView = [[UIView alloc] initWithFrame:view00.frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    UIImageView *doctorHeader = [[UIImageView alloc] initWithFrame:CGRectMake((whiteView.frame.size.width-194)/2-10, (whiteView.frame.size.height-194)/2-150, 194, 194)];
    doctorHeader.image = [UIImage imageNamed:@"doctor"];
    [whiteView addSubview:doctorHeader];
    
    tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, doctorHeader.frame.origin.y + doctorHeader.frame.size.height + 20, whiteView.frame.size.width, 40)];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = [UIFont yaHeiFontOfSize:19];
    tishiLabel.textColor = wordColor;
    [whiteView addSubview:tishiLabel];
    
    whiteView.hidden = YES;
    [self.view addSubview:whiteView];
    
    
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSLog(@"report state - %d",delegate.report);
    if (delegate.report > 1) {
        sv0 = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 826, self.view.frame.size.height-147-10)];
        sv0.backgroundColor = [UIColor whiteColor];
        sv0.alpha = 1;
        [view00 addSubview:sv0];
    }else if(delegate.report == 1){
        tishiLabel.text = @"线上评估将在一周后反馈，请您耐心等待";
        whiteView.hidden = NO;
    }else if (delegate.report == 0){
        tishiLabel.text = @"您需要先提交记录，医生才能对宝宝进行评估";
        whiteView.hidden = NO;
    }
    
    
   
//    [super viewDidLoad];
    
    
   
    
    for (int i=0; i<6; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(55+245*(i%2), 110+35*(i/2), 90, 22)];
        lab.font = [UIFont yaHeiFontOfSize:20];
        lab.text = arr[i+2];
        lab.textColor = WORDDARKCOLOR;
        [sv0 addSubview:lab];
        
    }
    for (int i=0; i<8; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(150+((i%3==1)?(140+123):0)+((i%3==2)?430:0), 110+35*(i/3), 123, 22)];
        label.font = [UIFont yaHeiFontOfSize:20];
        label.text = textArr[i];
        /**
         *  textArr[i]
         */
        label.textColor = wordColor;
        [sv0 addSubview:label];
    }
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 110+35*3+10, sv0.frame.size.width-80, 1.5)];
    line1.backgroundColor = wordColor;
    [sv0 addSubview:line1];
    UILabel *labl = [[UILabel alloc] initWithFrame:CGRectMake(40, line1.frame.origin.y+35, 210, 33)];
    labl.text = @"一、体格生长评价";
    labl.textColor = WORDDARKCOLOR;
    labl.font = [UIFont yaHeiFontOfSize:24];
    [sv0 addSubview:labl];
    /**
     *  画图
     
     */
    for (int i=0; i<3; i++) {
        UIImageView *IView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 290+584*i, 826, 584)];
        
        NSLog(@"_month = %d",_month);
        if (i==2) {
            if (_month < 24) {
                IView.image = [UIImage imageNamed:arr[8+i] ofSex:self.sex];
                
            }else{
                IView.image = [UIImage imageNamed:arr[arr.count - 1] ofSex:self.sex];
            }
        }else{
             IView.image = [UIImage imageNamed:arr[8+i] ofSex:self.sex];
        }
        
        IView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigger:)];
        MyView *myView = [[MyView alloc] initWithFrame:CGRectMake(109, 118, 593, 380)];
        NSDictionary *spot = [self returnCoordinateArr:i frameOfSubView:myView.frame];
        myView.xDataArr = [spot objectForKey:@"x"];
        myView.yDataArr = [spot objectForKey:@"y"];
        [IView addSubview:myView];
        
        [IView addGestureRecognizer:tap];
        IView.tag = 2000+i;
        [sv0 addSubview:IView];
        
    }
    //1850
    UILabel *growth = [[UILabel alloc] initWithFrame:CGRectMake(40, 1850+189, sv0.frame.size.width-80, 100)];
    growth.numberOfLines = 0;
    if (_user.result) {
        if (_user.result.onlineAppraisal) {
            if (_user.result.onlineAppraisal.growthappraisal) {
                NSMutableString *str = [NSMutableString stringWithString:_user.result.onlineAppraisal.growthappraisal];
                NSString *apppp = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                growth.text = apppp;
            }else{
                growth.text = @"";
            }
        }
    }
    
    
    growth.textColor = WORDDARKCOLOR;
    growth.font = [UIFont yaHeiFontOfSize:18];
    growth.numberOfLines = 0;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:growth.text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:10];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, growth.text.length)];
    
    growth.attributedText = attributedString;
    
    CGSize size = [growth sizeThatFits:CGSizeMake(sv0.frame.size.width-80, 1000)];
    growth.frame = CGRectMake(40, 1850+189, size.width, size.height);
    [sv0 addSubview:growth];
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(40, growth.frame.origin.y + growth.frame.size.height + 50, sv0.frame.size.width-80, 1.5)];
    line2.backgroundColor = wordColor;
    [sv0 addSubview:line2];
    
    
    UILabel *secondOfLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, growth.frame.origin.y + growth.frame.size.height + 10, sv0.frame.size.width-80, 40)];
    secondOfLabel.text = @"二、神经心理、发育行为评价";
    secondOfLabel.textColor = WORDDARKCOLOR;
    secondOfLabel.font = [UIFont yaHeiFontOfSize:24];
    [sv0 addSubview:secondOfLabel];
    
    UILabel *mind = [[UILabel alloc] initWithFrame:CGRectMake(40, secondOfLabel.frame.origin.y + secondOfLabel.frame.size.height + 10, sv0.frame.size.width-80, 30)];
    if (_user.result) {
        if (_user.result.onlineAppraisal) {
            if (_user.result.onlineAppraisal.mindappraisal) {
                mind.text = _user.result.onlineAppraisal.mindappraisal;
                _numberOfStar = [_user.result.onlineAppraisal.star intValue];
            }
        }
    }
    
    mind.textColor = WORDDARKCOLOR;
    mind.font = [UIFont yaHeiFontOfSize:18];
    mind.numberOfLines = 0;
    CGSize size1 = [mind sizeThatFits:CGSizeMake(sv0.frame.size.width-80, 3000)];
    mind.frame = CGRectMake(40, secondOfLabel.frame.origin.y + secondOfLabel.frame.size.height + 10, size1.width, size1.height);
    [sv0 addSubview:mind];
    NSLog(@"_numberStar = %d",_numberOfStar);
    //@"%d",_numberOfStar
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%d",_numberOfStar] withExtension:@"gif"];
    //((sv0.frame.size.width-640)/2, -50, 640, 360)
    _gifView = [[UIImageView alloc] initWithFrame:CGRectMake((sv0.frame.size.width-400)/2-20, -50, 400, 400)];
    
//    _gifView.frame = CGRectMake((sv0.frame.size.width-640)/2-20, -50, 640, 360);
    [self loadGIFFrom:fileUrl to:_gifView];
    
    UIView *ciew = [self.view.window viewWithTag:914];

    [sv0 addSubview:_gifView];
//    [_gifView startAnimating];
    sv0.delegate = self;
    [sv0 setContentSize:CGSizeMake(sv0.frame.size.width, mind.frame.size.height + mind.frame.origin.y + 10)];
//    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:[NSString stringWithFormat:@"%d-star(1)",_numberOfStar] withExtension:@"gif"];
//    
//
//    _gifView = [[SvGifView alloc] initWithCenter:CGPointMake(sv0.bounds.size.width / 2, 180) fileURL:fileUrl];
//    _gifView.frame = CGRectMake(sv0.bounds.size.width / 2-320, -50, 640, 362);
//        _gifView.backgroundColor = [UIColor clearColor];
//    _gifView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchAction)];
//    [_gifView addGestureRecognizer:tap];
//    [sv0 addSubview:_gifView];
//    [sv0 bringSubviewToFront:_gifView];
   
    
    if (_user.result) {
        if (_user.result.bodycheckAppraisalList) {
            NSArray *appraosal = _user.result.bodycheckAppraisalList;
            if (appraosal.count != 0) {
                if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
                    self.automaticallyAdjustsScrollViewInsets = NO;
                }
                LoginUserBodycheckAppraisalList *appra = appraosal[0];
                NSURL *url = [NSURL URLWithString:[NSString urlStringOfImage:appra.bodycheckappeaisalurl]];
                
                sv = [[UIScrollView alloc] initWithFrame:CGRectMake(175, 147, 826,1022)];
                sv.backgroundColor = [UIColor whiteColor];
                sv.alpha = 1;
                UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 826,1022)];
                
                [imageV sd_setImageWithURL:url];
                sv.contentSize = CGSizeMake(sv.frame.size.width,1500);
                [sv addSubview:imageV];
                [self.view addSubview:sv];
                [self.view sendSubviewToBack:sv];
            }else{
                tishiLabel.text = @"暂时没有您的线下检查报告";
            }
        }
    }
    
    
    

    
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_gifView stopAnimating];
    [_audioPlayer stop];
}






//returnCoordinateArr:i widthOfImgView:IView.frame.size.width heightOfImgView:IView.frame.size.height
-(NSDictionary *)returnCoordinateArr:(int)numberOfPicture frameOfSubView:(CGRect)frame{
    NSMutableArray *xArr = [[NSMutableArray alloc] init];
    NSMutableArray *yArr = [[NSMutableArray alloc] init];
    if (_user.result) {
        if (_user.result.onlineAppraisal) {
            if (_user.result.onlineAppraisal.imgdata) {
                NSArray *imgData = _user.result.onlineAppraisal.imgdata;
                int beginX = ((_month<24)?65:45);
                int beginY = ((_month<24)?5:1);
                for (LoginUserImgdata *imgda in imgData){
                    double unitOfX = 0.0;
                    double unitOfY = 0.0;
                    if (numberOfPicture == 0) {
                        unitOfX = frame.size.width/60.0;
                        unitOfY = frame.size.height/(122.0-43.0);
                        [xArr addObject:[NSString stringWithFormat:@"%lf",imgda.age*unitOfX]];
                        [yArr addObject:[NSString stringWithFormat:@"%lf",frame.size.height-unitOfY*([imgda.height floatValue]-43)]];
                        
                    }else if (numberOfPicture == 1){
                        unitOfX = frame.size.width/60.0;
                        
                        unitOfY = frame.size.height/24.0;
                        NSLog(@"++++++++++++++++++++++++++++++++++++weight = %f",[imgda.weight floatValue]);
                        [xArr addObject:[NSString stringWithFormat:@"%lf",imgda.age*unitOfX]];
                        [yArr addObject:[NSString stringWithFormat:@"%lf",frame.size.height-unitOfY*([imgda.weight floatValue]-1)]];
                    }else if (numberOfPicture == 2){
                        /**
                         *  2~5岁
                         */
                        unitOfX = frame.size.width/(120.0-65);
                        
                        unitOfY = frame.size.height/(28.0-5.0);
                        
                        [xArr addObject:[NSString stringWithFormat:@"%lf",([imgda.height floatValue]-beginX)*unitOfX]];
                        [yArr addObject:[NSString stringWithFormat:@"%lf",frame.size.height-unitOfY*([imgda.weight floatValue]-beginY)]];
                    }else{
                        [xArr addObject:@""];
                        [yArr addObject:@""];
                        
                    }
                    
                    
                    
                }
                
            }

        }
    }
    
    
   
    
    
    NSDictionary *dic = @{@"x":xArr,@"y":yArr};
    NSLog(@"dic = %@",dic);
    return dic;
}


-(void)buttonClick:(UIButton *)button{
    for (int i=0; i<2; i++) {
        UIButton *butt = (UIButton *)[self.view viewWithTag:150+i];
        butt.selected = NO;
        UIImageView *ivm = (UIImageView *)[self.view viewWithTag:160+i];
        ivm.hidden = YES;
    }
    button.selected = YES;
    UIImageView *iv = (UIImageView *)[self.view viewWithTag:button.tag+10];
    iv.hidden = NO;
    if (button.tag == 150) {
//        [self.view bringSubviewToFront:sv0];
        [self.view sendSubviewToBack:sv];
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
        NSLog(@"report state - %d",delegate.report);
        if (delegate.report > 1) {
            whiteView.hidden = YES;
        }else if(delegate.report == 1){
            tishiLabel.text = @"线上评估将在一周后反馈，请您耐心等待";
            whiteView.hidden = NO;
            [whiteView updateConstraints];
        }else if (delegate.report == 0){
            tishiLabel.text = @"您需要先提交记录，医生才能对宝宝进行评估";
            whiteView.hidden = NO;
            [whiteView updateConstraints];
        }
        
        
    }else{
        if (sv) {
            [self.view bringSubviewToFront:sv];

        }else{
            tishiLabel.text = @"暂时没有您的线下检查报告";
            [whiteView updateConstraints];
            whiteView.hidden = NO;
        }
        
    }
    
    
}



-(void)bigger:(UITapGestureRecognizer *)tap{
    
//    IView.tag = 2000+i;
    ;
    
    PictureViewController *pictureBigger = [[PictureViewController alloc] init];
    int i = tap.view.tag-2000;
    if (i==2) {
        if (_month < 24) {
           pictureBigger.bgImageName = arr[8+i];
            
        }else{
            pictureBigger.bgImageName = arr[arr.count - 1];
        }
    }else{
        pictureBigger.bgImageName = arr[8+i];
    }
    NSDictionary *spot = [self returnCoordinateArr:i frameOfSubView:CGRectMake(0, 0, 1024*615/826, 768*380/584)];
    pictureBigger.xAndYDic = spot;
    [self presentViewController:pictureBigger animated:NO completion:nil];
    
//    static BOOL _isSingle = YES;
//    NSLog(@"放大图片");
//    MenuView *menu = (MenuView *)[self.tabBarController.view viewWithTag:1000];
//    if (_isSingle == YES) {
//        menu.hidden = YES;
//        self.navigationController.navigationBarHidden = YES;
//       
////        UIImageView *big = [tap.view copy];
////        
////        big.tag = 100;
////        big.frame = self.view.bounds;
////        [self.view addSubview:big];
//    }else{
//        menu.hidden = NO;
//        self.navigationController.navigationBarHidden = NO;
////        UIImageView *big = (UIImageView *)[self.view viewWithTag:100];
////        [big removeFromSuperview];
//    }
//    
//    _isSingle = !_isSingle;
//    [sv0 reloadInputViews];
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
/*


+(CGSize)downloadImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;
    
    NSString* absoluteString = URL.absoluteString;
    
#ifdef dispatch_main_sync_safe
    if([[SDImageCache sharedImageCache] diskImageExistsWithKey:absoluteString])
    {
        UIImage* image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:absoluteString];
        if(!image)
        {
            NSData* data = [[SDImageCache sharedImageCache] performSelector:@selector(diskImageDataBySearchingAllPathsForKey:) withObject:URL.absoluteString];
            image = [UIImage imageWithData:data];
        }
        if(image)
        {
            return image.size;
        }
    }
#endif
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [PGViewController downloadPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [PGViewController downloadGIFImageSizeWithRequest:request];
    }
    else{
        size = [PGViewController downloadJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
#ifdef dispatch_main_sync_safe
            [[SDImageCache sharedImageCache] storeImage:image recalculateFromImage:YES imageData:data forKey:URL.absoluteString toDisk:YES];
#endif
            size = image.size;
        }
    }
    return size;
}
+(CGSize)downloadPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
+(CGSize)downloadJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}


*/



@end
