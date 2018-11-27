//
//  HeadViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "HeadViewController.h"
#import "AppDelegate.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MenuView.h"
#import "DataModels.h"
#import "UIImageView+WebCache.h"
#import "NetRequestManage.h"
#import "PGViewController.h"
#import "UIImagePickerController+rotate.h"
#import "ImageViewController.h"

#import "ASIFormDataRequest.h"
#import "CYOverRunView.h"
@interface HeadViewController ()<UITextFieldDelegate>{
    UIColor *wordColor;
    UIImageView *header;
    UIImageView *headerEdge;
    UIImageView *bigHeader;
    LoginUserUser *_user;
    BOOL _isAccessory;
    int _tagOfTextfield;
    UIScrollView *sv;
    UIScrollView *svTreat;
    UIView *recordView;
    UIView *treatView;
    BOOL _isChangeParents;
    BOOL _isChangeBabysitter;
    
}
@end

@implementation HeadViewController

#pragma mark - 自定义 alertview 相关
-(void)overRun{
    CYOverRunView *ciew = [self.view.window viewWithTag:999];
    ciew.hidden = NO;
    ciew.clickBlocks = ^(void){
        
        [self.tabBarController dismissViewControllerAnimated:NO completion:nil];
    };
    [self.view.window bringSubviewToFront:ciew];
}


-(void)viewWillAppear:(BOOL)animated{
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    NSLog(@"path = %@",path);
    
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        if (user) {
            _user = user.result.user;

        }
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    
    [self.view updateConstraints];
    [self.view bringSubviewToFront:_bgView];
    [self.view bringSubviewToFront:_right1];
    
    
    
}
-(void)viewDidAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(accessoryViewShow:) name:UITextFieldTextDidChangeNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated{
    [[SDImageCache sharedImageCache] clearDisk];

    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)accessoryViewShow:(NSNotificationCenter *)info{
    UIView *view;
    if (_tagOfTextfield > 209) {
        view = _right3;
    }else{
        view = _right2;
    }
    UITextField *textF = [view viewWithTag:_tagOfTextfield];
    UITextField *textAccess = [textF.inputAccessoryView viewWithTag:8000];
    if (_isAccessory) {
        textF.text = textAccess.text;
    }else{
        textAccess.text = textF.text;
    }
}

-(void)setInputAccessoryViewByElsa:(UITextField *)textF{
    UIView *view0 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1024, 44)];
    
    UITextField *text = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, view0.frame.size.width-150, view0.frame.size.height-10)];
    text.delegate = self;
    text.tag = 8000;
    [text setLeftViewOfBlankforWidth:8];
    //    [text addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    text.backgroundColor = [UIColor whiteColor];
    text.borderStyle = UITextBorderStyleRoundedRect;
    text.placeholder = textF.placeholder;
    text.text = textF.text;
    [view0 addSubview:text];
    
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.frame = CGRectMake(view0.frame.size.width-140, 5, 60, view0.frame.size.height-10);
    [finish setTitle:@"完成" forState:UIControlStateNormal];
    [finish setTitleColor:wordColor forState:UIControlStateNormal];
    [finish addTarget:self action:@selector(finishAction:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:finish];
    
    UIButton *remov = [UIButton buttonWithType:UIButtonTypeCustom];
    remov.frame = CGRectMake(view0.frame.size.width-70, 5, 60, view0.frame.size.height-10);
    [remov setTitle:@"取消" forState:UIControlStateNormal];
    [remov setTitleColor:wordColor forState:UIControlStateNormal];
    [remov addTarget:self action:@selector(removeText:) forControlEvents:UIControlEventTouchUpInside];
    [view0 addSubview:remov];
    
    view0.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    [textF setInputAccessoryView:view0];
}
-(void)finishAction:(UIButton *)button{
    UIView *view;
    if (_tagOfTextfield > 209) {
        view = _right3;
    }else{
        view = _right2;
    }
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    [textAccess resignFirstResponder];
    
    
    
    UITextField *text1 = (UITextField *)[view viewWithTag:_tagOfTextfield];
    [text1 resignFirstResponder];
    
    
    
}


-(void)removeText:(UIButton *)button{
    UIView *view;
    if (_tagOfTextfield > 209) {
        view = _right3;
    }else{
        view = _right2;
    }
    UITextField *textAccess = (UITextField *)[button.superview viewWithTag:8000];
    
    textAccess.text = nil;
    [textAccess resignFirstResponder];
    
    
    UITextField *text2 = (UITextField *)[view viewWithTag:_tagOfTextfield];
    text2.text = nil;
    
    [text2 resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessory = YES;
    }else{
        _tagOfTextfield = textField.tag;
    }
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField.tag == 8000) {
        _isAccessory = YES;
    }else{
        _isAccessory = NO;
         _tagOfTextfield = textField.tag;
    }
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}



#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _isAccessory = NO;
    _isChangeParents = NO;
    _isChangeBabysitter = NO;
    _tagOfTextfield = 200;
    _baobaoDataArr = [[NSMutableArray alloc]init];
    _parentsDataArr = [[NSMutableArray alloc] init];
    _babysitterDataArr = [[NSMutableArray alloc] init];
    _buyServeDataArr = [[NSMutableArray alloc] init];
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        if (user) {
            _user = user.result.user;

        }
        
        
    }else{
        NSLog(@"路径不存在！");
    }

  
    if (_user.truename) {
        [_baobaoDataArr addObject:_user.truename];

    }else{
        [_baobaoDataArr addObject:@""];
    }
    if (_user.filecode) {
        [_baobaoDataArr addObject:_user.filecode];

    }else{
        [_baobaoDataArr addObject:@""];
    }
    NSString *sexy;
    if (self.sex == 0) {
        sexy = @"女";
    }else{
        sexy = @"男";
    }
    [_baobaoDataArr addObject:sexy];
    if (_user.birthday) {
        [_baobaoDataArr addObject:_user.birthday];

    }else{
        [_baobaoDataArr addObject:@""];
    }
    [_baobaoDataArr addObject:[NSString stringWithFormat:@"%@周",_user.pregnancy]];
    [_baobaoDataArr addObject:[NSString stringWithFormat:@"%@公斤",_user.bornweight]];
    [_baobaoDataArr addObject:[NSString stringWithFormat:@"%@厘米",_user.bornheight]];
    
    [_parentsDataArr addObject:_user.dadphone];
    [_parentsDataArr addObject:_user.dadeducation];
    [_parentsDataArr addObject:[NSString stringWithFormat:@"%@厘米",_user.dadheight]];
    [_parentsDataArr addObject:_user.dademail];
    [_parentsDataArr addObject:_user.mumphone];
    [_parentsDataArr addObject:_user.mumeducation];
    [_parentsDataArr addObject:[NSString stringWithFormat:@"%@厘米",_user.mumheight]];
    [_parentsDataArr addObject:_user.mumemail];
    
    
    [_babysitterDataArr addObject:_user.carer];
    [_babysitterDataArr addObject:_user.carername];
    if ([_user.carersex boolValue] == YES) {
        [_babysitterDataArr addObject:@"男"];

    }else{
        [_babysitterDataArr addObject:@"女"];
    }
    [_babysitterDataArr addObject:_user.carerphone];
    
    
    
    [_buyServeDataArr addObject:[NSString stringWithFormat:@"%@/%@",_user.treatusedcount,_user.treattotalcount]];
    [_buyServeDataArr addObject:[NSString stringWithFormat:@"%@/%@",_user.bcusedcount,_user.bctotalcount]];
    
    [_buyServeDataArr addObject:@""];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
    }
    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    self.bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.alpha = 1;
    [self.view addSubview:_bgView];
    [self createRightView];
    
    [self createLeftView];
    if (_user.bornreport.length) {
        recordView = [[UIView alloc] initWithFrame:self.view.bounds];
        recordView.backgroundColor = [UIColor whiteColor];
        recordView.alpha = 1;
        
        NSURL *url = [NSURL URLWithString:[NSString urlStringOfImage:_user.bornreport]];
//        CGSize size = [PGViewController downloadImageSizeWithURL:url];
//        NSLog(@"------------------------------sizeOfImage = %@",NSStringFromCGSize(size));
        sv = [[UIScrollView alloc] initWithFrame:CGRectMake(175, 147, 826,self.view.frame.size.height-160)];
        sv.backgroundColor = [UIColor whiteColor];
        sv.alpha = 1;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, 1100)];
//        imageV.userInteractionEnabled = YES;
        [imageV sd_setImageWithURL:url];
        [sv addSubview:imageV];
        sv.contentSize = CGSizeMake(826, 1100);
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(sv.center.x-100, 100, 200, 30)];
        title.text = @"萌宝宝档案记录";
        title.textColor = wordColor;
        title.font = [UIFont yaHeiFontOfSize:24];
        [recordView addSubview:title];
        
        UIButton *fanHui = [UIButton buttonWithType:UIButtonTypeCustom];
        fanHui.frame =CGRectMake(sv.frame.origin.x, title.frame.origin.y, 24, 41);
        [fanHui setBackgroundImage:[UIImage imageNamed:@"yangyu-left" ofSex:self.sex] forState:UIControlStateNormal];
        [fanHui addTarget:self action:@selector(fanHuiAction:) forControlEvents:UIControlEventTouchUpInside];
        [recordView addSubview:fanHui];
        
        
        [recordView addSubview:sv];
        recordView.hidden = YES;
        [self.view addSubview:recordView];
        
    }
    if (_user.enterreport.length) {
        treatView = [[UIView alloc] initWithFrame:self.view.bounds];
        treatView.backgroundColor = [UIColor whiteColor];
        treatView.alpha = 1;
        
        NSURL *url = [NSURL URLWithString:[NSString urlStringOfImage:_user.enterreport]];
        //        CGSize size = [PGViewController downloadImageSizeWithURL:url];
        //        NSLog(@"------------------------------sizeOfImage = %@",NSStringFromCGSize(size));
        svTreat = [[UIScrollView alloc] initWithFrame:CGRectMake(180, 147, 826,self.view.frame.size.height-160)];
        svTreat.backgroundColor = [UIColor whiteColor];
        svTreat.alpha = 1;
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, 1100)];
        //        imageV.userInteractionEnabled = YES;
        [imageV sd_setImageWithURL:url];
        [svTreat addSubview:imageV];
        svTreat.contentSize = CGSizeMake(826, 1100);
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(sv.center.x-100, 80, 200, 40)];
        title.text = @"入会体检报告";
        title.textColor = wordColor;
        title.font = [UIFont yaHeiFontOfSize:30];
        [treatView addSubview:title];
        
        UILabel *lin = [[UILabel alloc] initWithFrame:CGRectMake(svTreat.frame.origin.x+15, svTreat.frame.origin.y-5, svTreat.frame.size.width, 2)];
        lin.backgroundColor = wordColor;
        [treatView addSubview:lin];
        
        UIButton *fanHui = [UIButton buttonWithType:UIButtonTypeCustom];
        fanHui.frame =CGRectMake(sv.frame.origin.x, title.frame.origin.y+10, 38, 50);
        UIImageView *fanhuiImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 30)];
        fanhuiImg.image = [UIImage imageNamed:@"yangyu-left" ofSex:self.sex];
        [fanHui addSubview:fanhuiImg];
        
        [fanHui addTarget:self action:@selector(fanHuiAction:) forControlEvents:UIControlEventTouchUpInside];
        [treatView addSubview:fanHui];
        
        
        [treatView addSubview:svTreat];
        treatView.hidden = YES;
        [self.view addSubview:treatView];
        
    }

    

}

-(void)fanHuiAction:(UIButton *)buton{
    UIButton *butt = (UIButton *)[_right1 viewWithTag:1110];
    butt.selected = NO;
    [self.view sendSubviewToBack:treatView];
    [self.view sendSubviewToBack:recordView];
}
-(void)createLeftView{
    
    
    UIImageView *headerBg = [[UIImageView alloc]initWithFrame:CGRectMake(193, 100, 273, 273)];
    headerBg.image = [UIImage imageNamed:@"shouye-touxiang" ofSex:self.sex];
    [_bgView addSubview:headerBg];
    headerEdge = [[UIImageView alloc] initWithFrame:CGRectMake(198, 105, 263, 263)];
    headerEdge.image = [UIImage imageNamed:@"xinxi-gaitouxiang" ofSex:self.sex];
    headerEdge.hidden = YES;
    [_bgView addSubview:headerEdge];
    header = [[UIImageView alloc]initWithFrame:CGRectMake(201, 108, 257, 257)];

    header.layer.masksToBounds = YES;
    header.layer.cornerRadius = 128.5;
    if (_user.headimg.length>0) {
    
        NSString *headImg = [NSString urlStringOfPrefix:_user.headimg];
//        NSLog(@"headImg = %@",_user.headimg);
        NSURL *url = [NSURL URLWithString:headImg];
         [[SDImageCache sharedImageCache] clearDisk];
        [header sd_setImageWithURL:url];
    }else{
        header.backgroundColor = [UIColor clearColor];
    }
    
    [_bgView addSubview:header];
    header.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bringRightView0:)];
    [header addGestureRecognizer:tap];
    
    NSArray *titleArr = @[@"宝宝信息",@"父母信息",@"照养人信息",@"入会体检",@"已购服务"];
    for (int i=0; i<5; i++) {
        UIButton *baobao = [UIButton buttonWithType:UIButtonTypeCustom];
        baobao.frame = CGRectMake(193+10+10, 390+70*i, 234, 55);
        [baobao setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang" ofSex:self.sex] forState:UIControlStateNormal];
        [baobao setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateSelected];
            [baobao setBackgroundImage:[UIImage imageNamed:@"xinxi-kuang2" ofSex:self.sex] forState:UIControlStateHighlighted];
        [baobao setTitle:titleArr[i] forState:UIControlStateNormal];
        baobao.titleLabel.font = [UIFont yaHeiFontOfSize:19];
        [baobao setTitleColor:wordColor forState:UIControlStateNormal];
        
        [baobao addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        baobao.tag = 100+i;
        [_bgView addSubview:baobao];
    }
}
-(void)bringRightView0:(UITapGestureRecognizer *)tap{
    headerEdge.hidden = NO;
    [_bgView bringSubviewToFront:_right0];
    for (int i=0; i<5; i++) {
        UIButton *button = (UIButton *)[_bgView viewWithTag:100+i];
        button.selected = NO;
    }
    
}
/**
 *  左侧控件
 *
 *  @param button button点击事件
 */
-(void)btnClick:(UIButton *)button{
    for (int i=0; i<5; i++) {
        UIButton *but = (UIButton *)[self.view viewWithTag:100+i];
        
        but.selected = NO;
    }
    button.selected = YES;
    if (button.tag == 100) {
        [_bgView bringSubviewToFront:_right1];
    }else if (button.tag == 101){
        [_bgView bringSubviewToFront:_right2];
        _right1ChangeBtn.selected = NO;
        for (int i=0; i<8; i++) {
            UITextField *field = (UITextField *)[_right2 viewWithTag:200+i];
            
            field.text = _parentsDataArr[i];
            field.enabled = NO;
            field.backgroundColor = [UIColor clearColor];
        }

        
    }else if (button.tag == 102){
        [_bgView bringSubviewToFront:_right3];
        _right1ChangeBtn.selected = NO;
        for (int i=0; i<4; i++) {
            UITextField *field = (UITextField *)[_right3 viewWithTag:210+i];
            
             field.text = _babysitterDataArr[i];
            field.enabled = NO;
            field.backgroundColor = [UIColor clearColor];
        }
        UIButton *butn = [_right3 viewWithTag:12344];
        butn.selected = NO;
        
    }else if (button.tag == 104){
        [_bgView bringSubviewToFront:_right4];
    }else if (button.tag == 103){
        treatView.hidden = NO;
        [self.view bringSubviewToFront:treatView];
    }
   
    headerEdge.hidden = YES;
}




#pragma mark - 右边图
-(void)createRightView{
    
    _right0 = [[UIView alloc]initWithFrame:FRAMEOFRIGHTVIEW];
    _right1 = [[UIView alloc]initWithFrame:FRAMEOFRIGHTVIEW];
    _right2 = [[UIView alloc]initWithFrame:FRAMEOFRIGHTVIEW];
    _right3 = [[UIView alloc]initWithFrame:FRAMEOFRIGHTVIEW];
    _right4 = [[UIView alloc]initWithFrame:FRAMEOFRIGHTVIEW];
    if (self.sex == YES) {
        _right0.backgroundColor = BOY_RIGHTVIEWCOLOR;
        _right1.backgroundColor = BOY_RIGHTVIEWCOLOR;
        _right2.backgroundColor = BOY_RIGHTVIEWCOLOR;
        _right3.backgroundColor = BOY_RIGHTVIEWCOLOR;
        _right4.backgroundColor = BOY_RIGHTVIEWCOLOR;
    }else{
        _right0.backgroundColor = GIRL_RIGHTVIEWCOLOR;
        _right1.backgroundColor = GIRL_RIGHTVIEWCOLOR;
        _right2.backgroundColor = GIRL_RIGHTVIEWCOLOR;
        _right3.backgroundColor = GIRL_RIGHTVIEWCOLOR;
        _right4.backgroundColor = GIRL_RIGHTVIEWCOLOR;
        
    }
    [self changeHeader];
    [self baobaoMessages];
    [self parentsMessages];
    [self babysitterMessages];
    [self buyServe];

    [_bgView addSubview:_right0];
    [_bgView addSubview:_right1];
    [_bgView addSubview:_right2];
    [_bgView addSubview:_right3];
    [_bgView addSubview:_right4];
    
}
#pragma mark - 各图UI
-(void)changeHeader{
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-100, 36, 200, 36)];
    title.text = @"更换头像";
    title.textColor = wordColor;
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont yaHeiFontOfSize:30];
    [_right0 addSubview:title];
    UIImageView *imageEdge = [[UIImageView alloc] initWithFrame:CGRectMake((_right0.bounds.size.width-391)/2, 120, 391, 391)];
    imageEdge.image = [UIImage imageNamed:@"xinxi-gaitouxiang" ofSex:self.sex];
    [_right0 addSubview:imageEdge];
    bigHeader = [[UIImageView alloc] initWithFrame:CGRectMake((_right0.bounds.size.width-391)/2+3, 120+3, 385, 385)];
//    bigHeader.image = [UIImage imageNamed:@"xinxi-gaitouxiang" ofSex:self.sex];
    if (_user.headimg.length>0) {
         [[SDImageCache sharedImageCache] clearDisk];
        [bigHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfPrefix:_user.headimg]]];

    }else{
        bigHeader.image = [UIImage imageNamed:@"shouye-touxiang" ofSex:self.sex];
    }
    bigHeader.layer.masksToBounds = YES;
    bigHeader.layer.cornerRadius = 192.5;
    [_right0 addSubview:bigHeader];
    
    UIButton *camera = [UIButton buttonWithType:UIButtonTypeCustom];
    camera.frame = CGRectMake(bigHeader.frame.origin.x+80, 550, 40, 30);
    [camera setBackgroundImage:[UIImage imageNamed:@"xinxi-zhaoxiang" ofSex:self.sex] forState:UIControlStateNormal];
    camera.tag = 110;
    [camera addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
    [_right0 addSubview:camera];
    
    
    UIButton *album = [UIButton buttonWithType:UIButtonTypeCustom];
    album.frame =CGRectMake(camera.frame.origin.x+bigHeader.frame.size.width-camera.frame.size.width-150, camera.frame.origin.y, camera.frame.size.width, camera.frame.size.height);
    album.tag = 111;
    [album setBackgroundImage:[UIImage imageNamed:@"xinxi-pic" ofSex:self.sex] forState:UIControlStateNormal];
    [album addTarget:self action:@selector(picClick:) forControlEvents:UIControlEventTouchUpInside];
    [_right0 addSubview:album];
    
}
-(void)baobaoMessages{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-100, 59, 200, 36)];
    label.text = @"宝宝信息";
    label.textColor = wordColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont yaHeiFontOfSize:30];
    [_right1 addSubview:label];
    NSArray *labelTextArr = @[@"宝宝姓名",@"档案编号",@"性别",@"出生年月",@"孕期",@"宝宝出生体重",@"宝宝出生身长"];
    for (int i=0; i<4; i++) {
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(93, 144+38*i, 200, 22)];
        text.text = labelTextArr[i];
        text.font = [UIFont yaHeiFontOfSize:20];
        text.textColor = WORDDARKCOLOR;
        text.adjustsFontSizeToFitWidth = NO;
        text.shadowColor = [UIColor clearColor];
        [_right1 addSubview:text];
        
        
        UILabel *data = [[UILabel alloc]initWithFrame:CGRectMake(text.frame.origin.x+210, text.frame.origin.y, text.frame.size.width, text.frame.size.height)];
        data.text = _baobaoDataArr[i];
        data.font = [UIFont yaHeiFontOfSize:17];
        data.adjustsFontSizeToFitWidth = NO;
        data.textColor = WORDDARKCOLOR;
        data.shadowColor = [UIColor clearColor];
        [_right1 addSubview:data];
        
    }
    for (int i=0; i<3; i++) {
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(93, 320+38*i, 200, 22)];
        text.text = labelTextArr[i+4];
        text.font = [UIFont yaHeiFontOfSize:20];
        text.textColor = WORDDARKCOLOR;
        text.shadowColor = [UIColor clearColor];
        [_right1 addSubview:text];
        
        
        UILabel *data = [[UILabel alloc]initWithFrame:CGRectMake(text.frame.origin.x+210, text.frame.origin.y, text.frame.size.width, text.frame.size.height)];
        data.text = _baobaoDataArr[i+4];
        data.font = [UIFont yaHeiFontOfSize:17];

        data.textColor = WORDDARKCOLOR;
        data.shadowColor = [UIColor clearColor];
        [_right1 addSubview:data];
    }
    UILabel *line0 = [[UILabel alloc]initWithFrame:CGRectMake(30, 120, FRAMEOFRIGHTVIEW.size.width-60, 1)];
    line0.backgroundColor = wordColor;
    [_right1 addSubview:line0];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 300, line0.frame.size.width, 1)];
    line1.backgroundColor = wordColor;
    [_right1 addSubview:line1];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 440, line1.frame.size.width, 1)];
    line2.backgroundColor = wordColor;
    [_right1 addSubview:line2];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-117, 490, 234, 57);
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-chushengjilu" ofSex:self.sex] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-chushengjilu2" ofSex:self.sex] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-chushengjilu2" ofSex:self.sex] forState:UIControlStateHighlighted];
    button.tag = 1110;
    [button addTarget:self action:@selector(babyRecord:) forControlEvents:UIControlEventTouchUpInside];
    [_right1 addSubview:button];
    
}
-(void)parentsMessages{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-100, 59, 200, 36)];
    label.text = @"父母信息";
    label.textColor = wordColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont yaHeiFontOfSize:30];
    [_right2 addSubview:label];
    NSArray *textArr = @[@"爸爸",@"联系电话",@"学历",@"身高",@"邮箱",@"妈妈",@"联系电话",@"学历",@"身高",@"邮箱"];
    for (int i=0; i<5; i++) {
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(93, 135+38*i, 200, 22)];
        text.text = textArr[i];
        text.font = [UIFont yaHeiFontOfSize:20];
        text.textColor = WORDDARKCOLOR;
        text.shadowColor = [UIColor clearColor];
        [_right2 addSubview:text];
        if (i>0) {
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(text.frame.origin.x+175, text.frame.origin.y, text.frame.size.width, text.frame.size.height)];
            field.tag = 200+i-1;
            field.delegate = self;
            field.enabled = NO;
            [field setLeftViewOfBlankforWidth:8];
            [self setInputAccessoryViewByElsa:field];
            [field setBackgroundColor:[UIColor clearColor]];
            if (i == 3) {
                 field.textColor = WORDDARKCOLOR;
            }else{
                field.textColor = wordColor;

            }
            field.font = [UIFont yaHeiFontOfSize:17];
            field.text = _parentsDataArr[i-1];
            [_right2 addSubview:field];
            
        }
    }
    for (int i=0; i<5; i++) {
        UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(93, 350+38*i, 200, 22)];
        text.text = textArr[i+5];
        text.font = [UIFont yaHeiFontOfSize:20];
        text.textColor = WORDDARKCOLOR;
        text.shadowColor = [UIColor clearColor];
        [_right2 addSubview:text];
        
        if (i>0) {
            UITextField *field = [[UITextField alloc]initWithFrame:CGRectMake(text.frame.origin.x+175, text.frame.origin.y, text.frame.size.width, text.frame.size.height)];
            field.tag = 200+i+3;
            field.delegate = self;
            field.enabled = NO;
            [self setInputAccessoryViewByElsa:field];
            [field setBackgroundColor:[UIColor clearColor]];
            if (i == 3) {
                field.textColor = WORDDARKCOLOR;
            }else{
                field.textColor = wordColor;
                
            }
            field.font = [UIFont yaHeiFontOfSize:17];
            field.text = _parentsDataArr[i+3];
            [_right2 addSubview:field];
            
        }
    }
    UILabel *line0 = [[UILabel alloc]initWithFrame:CGRectMake(30, 115, FRAMEOFRIGHTVIEW.size.width-60, 1)];
    line0.backgroundColor = wordColor;
    [_right2 addSubview:line0];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 330, line0.frame.size.width, 1)];
    line1.backgroundColor = wordColor;
    [_right2 addSubview:line1];
    
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(30, 550, line1.frame.size.width, 1)];
    line2.backgroundColor = wordColor;
    [_right2 addSubview:line2];
    
    _right1ChangeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _right1ChangeBtn.frame = CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-117, 582, 234, 57);
    [_right1ChangeBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-xiugaifumu" ofSex:self.sex] forState:UIControlStateNormal];
    [_right1ChangeBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai" ofSex:self.sex] forState:UIControlStateSelected];
    [_right1ChangeBtn setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai2" ofSex:self.sex] forState:UIControlStateHighlighted];
    [_right1ChangeBtn addTarget:self action:@selector(changeParentsMessage:) forControlEvents:UIControlEventTouchUpInside];
    [_right2 addSubview:_right1ChangeBtn];
}

#pragma mark - parents相关
-(void)changeParentsMessage:(UIButton *)button{
    button.selected = !button.selected;
    BOOL bo;
    UIColor *right;
    if (button.selected == YES) {
        bo = YES;
        right = [UIColor lightTextColor];
        
    }else{
        bo = NO;
        right = [UIColor clearColor];
        
    }
    for (int i=0; i<8; i++) {
        UITextField *field = (UITextField *)[_right2 viewWithTag:200+i];
        if (i==2||i==6) {
            continue;
        }
        field.enabled = bo;
        field.backgroundColor = right;
    }
    if (button.selected == NO) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"] forKey:@"sPwd"];
        UITextField *dadPhone = (UITextField *)[_right2 viewWithTag:200];
        UITextField *dadEducation = (UITextField *)[_right2 viewWithTag:201];
        UITextField *dadEmail = (UITextField *)[_right2 viewWithTag:203];
        UITextField *mumPhone = (UITextField *)[_right2 viewWithTag:204];
        UITextField *mumEducation = (UITextField *)[_right2 viewWithTag:205];
        UITextField *mumEmail = (UITextField *)[_right2 viewWithTag:207];
        [dic setObject:dadPhone.text forKey:@"dadPhone"];
        [dic setObject:dadEducation.text forKey:@"dadEducation"];
        [dic setObject:dadEmail.text forKey:@"dadEmail"];
        [dic setObject:mumPhone.text forKey:@"mumPhone"];
        [dic setObject:mumEducation.text forKey:@"mumEducation"];
        [dic setObject:mumEmail.text forKey:@"mumEmail"];
//        NSLog(@"dic = %@",dic);
        [NetRequestManage setParentWithDictionary:dic successBlocks:^(NSData *data, NetRequestManage *loadUser) {
            NSLog(@"修改父母信息成功！");
            
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"xiugaifumuxingxinstr = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"errorId = %d",[[dic objectForKey:@"errorId"] intValue]);
            
            if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                [self overRun];
            }
            _isChangeParents = YES;
            
            [_parentsDataArr removeAllObjects];
            for (int i=0; i<8; i++) {
                UITextField *fie = (UITextField *)[_right2 viewWithTag:200+i];
                [_parentsDataArr addObject:fie.text];
            }
            
            
            
            
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"error = %@",error.description);
        }];
    }
}
-(void)babysitterMessages{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-100, 114, 200, 36)];
    label.text = @"照养人信息";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = wordColor;
    label.font = [UIFont yaHeiFontOfSize:30];
    [_right3 addSubview:label];
    
    UILabel *line0 = [[UILabel alloc]initWithFrame:CGRectMake(30, 193, FRAMEOFRIGHTVIEW.size.width-60, 1)];
    line0.backgroundColor = wordColor;
    [_right3 addSubview:line0];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 374, line0.frame.size.width, 1)];
    line1.backgroundColor = wordColor;
    [_right3 addSubview:line1];
    
    
    NSArray *arr = @[@"与宝宝关系",@"姓名",@"性别",@"联系电话"];
    for (int i=0; i<4; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(83, 210+40*i, 200, 22)];
        label.text = arr[i];
        label.font = [UIFont yaHeiFontOfSize:20];
        label.textColor = WORDDARKCOLOR;
        label.shadowColor = [UIColor clearColor];
        [_right3 addSubview:label];
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(label.frame.origin.x+177, label.frame.origin.y, label.frame.size.width, label.frame.size.height)];
        textField.text = _babysitterDataArr[i];
        textField.font = [UIFont yaHeiFontOfSize:17];
        textField.tag = 210+i;
        [textField setLeftViewOfBlankforWidth:8];
        [self setInputAccessoryViewByElsa:textField];
        textField.textColor = wordColor;
        textField.delegate = self;
        textField.enabled = NO;
        [_right3 addSubview:textField];
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-117, 500, 234, 57);
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-zhaoyangren" ofSex:self.sex] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai" ofSex:self.sex] forState:UIControlStateSelected];
    [button setBackgroundImage:[UIImage imageNamed:@"xinxi-querenxiugai2" ofSex:self.sex] forState:UIControlStateHighlighted];
    button.tag = 12344;
    [button addTarget:self action:@selector(changeBabySitterMessage:) forControlEvents:UIControlEventTouchUpInside];
    button.selected = NO;
    [_right3 addSubview:button];
    
    
}

#pragma mark - babysitting相关
-(void)changeBabySitterMessage:(UIButton *)button{
    button.selected = !button.selected;
    BOOL bo;
    UIColor *right;
    if (button.selected == YES) {
        bo = YES;
        right = [UIColor lightTextColor];
        
    }else{
        bo = NO;
        right = [UIColor clearColor];
        
    }
    for (int i=0; i<4; i++) {
        UITextField *field = (UITextField *)[_right3 viewWithTag:210+i];
        field.enabled = bo;
        field.backgroundColor = right;
    }
    
    if (button.selected == NO) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"] forKey:@"userId"];
        [dic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"password"] forKey:@"sPwd"];
        UITextField *carer = (UITextField *)[_right3 viewWithTag:210];
        UITextField *carerName = (UITextField *)[_right3 viewWithTag:211];
        UITextField *carerSex = (UITextField *)[_right3 viewWithTag:212];
        UITextField *carerPhone = (UITextField *)[_right3 viewWithTag:213];
        
        [dic setObject:carerName.text forKey:@"carerName"];
        [dic setObject:carer.text forKey:@"carer"];
        [dic setObject:carerSex.text forKey:@"carerSex"];
        [dic setObject:carerPhone.text forKey:@"carerPhone"];
        NSLog(@"dic = %@",dic);
        [NetRequestManage setCarerWithDictionary:dic successBlocks:^(NSData *data, NetRequestManage *loadUser) {
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"照养人信息 = %@",str);
            NSLog(@"修改照养人信息成功！");
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                [self overRun];
            }
            [_babysitterDataArr removeAllObjects];
            [_babysitterDataArr addObjectsFromArray:[dic allValues]];
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"error = %@",error.description);
        }];
    }
    
}




-(void)buyServe{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(FRAMEOFRIGHTVIEW.size.width/2-100, 128, 200, 36)];
    label.text = @"已购服务";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = wordColor;
    label.font = [UIFont yaHeiFontOfSize:30];
    [_right4 addSubview:label];
    
    UILabel *line0 = [[UILabel alloc]initWithFrame:CGRectMake(30, 200, FRAMEOFRIGHTVIEW.size.width-60, 1)];
    line0.backgroundColor = wordColor;
    [_right4 addSubview:line0];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(30, 350, line0.frame.size.width, 1)];
    line1.backgroundColor = wordColor;
    [_right4 addSubview:line1];
    NSArray *arr = @[@"体检已用次数和总次数",@"已转诊/绿色通道次数和总次数",@"合约到期时间"];
    for (int i=0; i<3; i++) {
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(83, 226+36*i, 300                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            , 22)];
        lab.text = arr[i];
        lab.textColor = WORDDARKCOLOR;
        lab.shadowColor = [UIColor clearColor];
        lab.font = [UIFont yaHeiFontOfSize:20];
        [_right4 addSubview:lab];
        
        UILabel *text = [[UILabel alloc] initWithFrame:CGRectMake(lab.frame.origin.x+289,lab.frame.origin.y, lab.frame.size.width, lab.frame.size.height)];
        text.text = _buyServeDataArr[i];
        text.font = [UIFont yaHeiFontOfSize:17];
        text.textColor = wordColor;
        text.shadowColor = [UIColor clearColor];
        [_right4 addSubview:text];
    }
    
   
}
#pragma mark - 自定义 alertview 相关
-(void)alertViewWith:(NSString *)errorSts{
    UIView *ciew = [self.view.window viewWithTag:8888];
    ciew.hidden = NO;
    for (int i=0; i<[ciew.subviews count]; i++) {
        UIView *ve = ciew.subviews[i];
        [ve removeFromSuperview];
    }
    
    
    
    UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width - 400)/2, (self.view.frame.size.height - 150)/2, 400, 150)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 10;
    _alert.alpha = 1;
    
    
    UIImageView *header00 = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    header00.image = [UIImage imageNamed:@"jilu-error" ofSex:self.sex];
    [_alert addSubview:header00];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header00.frame.size.height+header00.frame.origin.y + 15, _alert.frame.size.width-20, 30)];
    
    labe.text = errorSts;
    labe.textColor = wordColor;
    labe.textAlignment = NSTextAlignmentCenter;
    labe.font = [UIFont yaHeiFontOfSize:17];
    labe.numberOfLines = 0;
    
    [_alert addSubview:labe];
    
    
    
    [ciew addSubview:_alert];
    
    
    
    //                [self.view.window updateConstraints];
    [self.view.window bringSubviewToFront:ciew];
}


#pragma mark - 头像相关




-(void)picClick:(UIButton *)btn{
   ImageViewController *pc = [[ImageViewController alloc]init];
    
    pc.delegate = self;
    pc.allowsEditing = YES;
    
    
    
    if (btn.tag == 110) {
        //拍照
        //设置资源类型 --> 先要检测要设置的资源类型是否可用
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [pc setSourceType:UIImagePickerControllerSourceTypeCamera];
            
            [self presentViewController:pc animated:YES completion:nil];
        }
        else{
            [self alertViewWith:@"相机不可用"];
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message: delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [av show];
            
        }
    }else{
        //相册选择
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [pc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            //设置允许编辑
            [self presentViewController:pc animated:YES completion:nil];
        }
        else{
            [self alertViewWith:@"无法访问相册"];
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"提示" message:@"无法访问相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [av show];
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate相关
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //选择完成 --> 判断选择完的资源是image还是media
    NSLog(@"%@",info);
    NSString *str = [info objectForKey:UIImagePickerControllerMediaType];
    if ([str isEqualToString:(NSString *)kUTTypeImage]) {
        //UIImagePickerControllerEditedImage:编辑后的照片
        //UIImagePickerControllerOriginalImage:原图
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSLog(@"imageSize = %@",NSStringFromCGSize(image.size));
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        
        [self uploadPhoto:data];
        [self saveImage:data];
        bigHeader.image = image;
        header.image = image;
        MenuView *menu = (MenuView *)[self.tabBarController.view viewWithTag:1000];
        [menu.headButton setBackgroundImage:image forState:UIControlStateNormal];
        [menu.headButton setBackgroundImage:image forState:UIControlStateSelected];
        [menu.headButton setBackgroundImage:image forState:UIControlStateHighlighted];
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
       
        
    }
    
    
}
#pragma mark - 存储图片

-(void)saveImage:(NSData *)data{
    NSString *path = NSHomeDirectory();
    
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    NSLog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *contents = [[NSBundle mainBundle] pathForResource:jpgImagePath ofType:@""];
    if(contents!=NULL){
        [manager removeItemAtPath:path error:nil];
    }
    [data writeToFile:jpgImagePath atomically:YES];
    
    
}

#pragma mark - 上传头像

-(void)uploadPhoto:(NSData *)imageData{
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LOCALSERVERROOT,UPLOADHEADIMG]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    [request setPostValue:userId forKey:@"userId"];
    [request setPostValue:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"] forKey:@"sesId"];
    
    //第一个参数：要上传的图片的二进制数据
    //第二个参数：文件名
    //第三个参数：图片 --> image/png
    //第四个参数：要上传的图片对应的参数名
    [request setData:imageData withFileName:@"headImg.jpg" andContentType:@"image/jpg" forKey:@"userHead"];
    //2.设置代理
    request.delegate = self;
    request.tag = 200;
    //3.设置请求方式 --> post
    [request setRequestMethod:@"POST"];
    //4.开始请求 --> 异步
    [request startAsynchronous];
    
    
    
}

#pragma mark - ASIDelegate相关
-(void)requestFinished:(ASIHTTPRequest *)request{
    if (request.responseData) {
        
        id  result = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil];
        if ([result isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)result;
            NSLog(@"result = %@",dict);
        }else{
            NSLog(@"格式不对！");
        }
    }else{
        NSLog(@"上传头像失败！");
    }
    
}
-(void)requestFailed:(ASIHTTPRequest *)request{
    //请求失败
    NSLog(@"error:%@",request.error);
}






#pragma mark - 宝宝信息相关
-(void)babyRecord:(UIButton *)button{
    button.selected = !button.selected;
    
    recordView.hidden = NO;
    
    [self.view bringSubviewToFront:recordView];
    
    
    

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
