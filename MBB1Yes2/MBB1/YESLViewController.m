//
//  YESLViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "YESLViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "NetRequestManage.h"
#import "CYOverRunView.h"
@interface YESLViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    UIColor *wordColor;
    UIColor *bgColor;
    NSArray *_salon;
    NSMutableArray *_signedSalons;
    UICollectionView *_collectionView;
    UIPageControl *page;
    
    
    UILabel *_yuerTitle;
    UILabel *_yuerTime;
    UIImageView *_yuerImage;
    UIButton *_yuerbaoMing;
    UILabel *_yuerTextLabel;
    NSString *_tapCell;
    NSDictionary *_isJoinDic;
}

@end

@implementation YESLViewController

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
    [self.view sendSubviewToBack:_nextView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
        _dataArr = [[NSMutableArray alloc] init];
    /**
     *  假数据
     */
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        if (user.result) {
            if (user.result.salonList) {
                _salon = user.result.salonList;
                
            }
            if (user.result.userSalonList) {
                _signedSalons = [[NSMutableArray alloc] init];
                for (LoginUserSalonList *saloon in user.result.userSalonList) {
                    [_signedSalons addObject:saloon.salonid];

                }
            }
        }
        
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    for (int i=0; i<3; i++) {
        UIImage *image = [UIImage imageNamed:@"kefu-dakuang" ofSex:self.sex];
        [_dataArr addObject:image];
    }
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    [self createUI];

    // Do any additional setup after loading the view.
}
-(void)createUI{
    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    _mainView.backgroundColor = bgColor;
    [self.view addSubview:_mainView];
    UIImageView *bgCiew = [[UIImageView alloc] initWithFrame:CGRectMake(222-1, 98-1, 734+2, 353+2)];
    bgCiew.image = [UIImage imageNamed:@"shalong-kuang1" ofSex:self.sex];
    [_mainView addSubview:bgCiew];
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(222, 98, 734, 353)];
    sc.delegate = self;
    sc.tag = 2000000;
    for (int i=0; i<[_salon count]; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(734*i, 0, 734, 353)];
        if (_salon.count>0) {
            LoginUserSalonList *sal = _salon[i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:sal.salonimg]]];

        }
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapAction:)];
        [imageView addGestureRecognizer:tap];
        [sc addSubview:imageView];
    }
    sc.contentSize = CGSizeMake(734*_salon.count, 353);
    sc.pagingEnabled = YES;
    sc.bounces = NO;
    sc.showsHorizontalScrollIndicator = NO;
    [_mainView addSubview:sc];
    
    page = [[UIPageControl alloc] initWithFrame:CGRectMake(sc.frame.origin.x + (sc.frame.size.width/2)-75, sc.frame.size.height+10+sc.frame.origin.y, 150, 20)];
    page.numberOfPages = _salon.count;
    page.currentPage = 0;
    page.currentPageIndicatorTintColor = wordColor;
    page.userInteractionEnabled = YES;
    page.pageIndicatorTintColor = WORDDARKCOLOR;
    [page addTarget:self action:@selector(changePage:)forControlEvents:UIControlEventValueChanged];
    [_mainView addSubview:page];

    
    
    
    


    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(281, 497, 200, 26)];
    label.text = @"往期沙龙";
    label.font = [UIFont yaHeiFontOfSize:24];
    label.textColor = wordColor;
    [_mainView addSubview:label];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(240, 535, 705, 233) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.backgroundColor = bgColor;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [_mainView addSubview:_collectionView];
    [self createNextView];
    
}
-(void)imageTapAction:(UITapGestureRecognizer *)tap{
    if (_salon.count>0) {
        UIScrollView *ss = (UIScrollView *)[_mainView viewWithTag:2000000];
        int row = ss.contentOffset.x/734;
        
        LoginUserSalonList *sal = _salon[row];
        _yuerTitle.text = sal.salontopic;
        _yuerTime.text = sal.salonindex;
        _tapCell = sal.salonid;
        [_yuerImage sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:sal.salonimg]]];
        _yuerTextLabel.text = sal.salongdesc;
        if ([_yuerbaoMing.titleLabel.text isEqualToString:@"已报名"]) {
            
        }else{
            _yuerbaoMing.enabled = YES;
            [_yuerbaoMing setTitle:@"报名" forState:UIControlStateNormal];
            [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateNormal];
        }
       

        if (_signedSalons.count>0) {
            for (NSString *userSalon in _signedSalons) {
                if ([sal.salonid isEqualToString:userSalon]) {
                    
                    
                    [_yuerbaoMing setTitle:@"已报名" forState:UIControlStateDisabled];
                    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateDisabled];
                    _yuerbaoMing.enabled = NO;
                }
            }
        }
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        NSDate *date = [format dateFromString:sal.signupendtme];
        NSDate *nowDate = [[NSDate date] dateByAddingTimeInterval:60*60*8];
        if ([nowDate isEqualToDate:[nowDate laterDate:date]]) {
            
//            shalong-jiezhi@2x
            [_yuerbaoMing setTitle:@"" forState:UIControlStateDisabled];
            [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"shalong-jiezhi"] forState:UIControlStateDisabled];
            _yuerbaoMing.enabled = NO;
        }
    }
    
    [self.view bringSubviewToFront:_nextView];

}
-(void)createNextView{
    _nextView = [[UIView alloc] initWithFrame:self.view.bounds];
    _nextView.backgroundColor = [UIColor whiteColor];
    _nextView.alpha = 1;
    [self.view addSubview:_nextView];
    [self.view sendSubviewToBack:_nextView];
    
    
    _yuerTitle = [[UILabel alloc] initWithFrame:CGRectMake(220, 100, self.view.frame.size.width-270, 40)];
    _yuerTitle.font = [UIFont yaHeiFontOfSize:35];
    _yuerTitle.textColor = wordColor;
    _yuerTitle.textAlignment = NSTextAlignmentCenter;
    [_nextView addSubview:_yuerTitle];
    
    
    _yuerTime = [[UILabel alloc] initWithFrame:CGRectMake(_yuerTitle.frame.origin.x, _yuerTitle.frame.origin.y+_yuerTitle.frame.size.height+5, _yuerTitle.frame.size.width, 20)];
    _yuerTime.font = [UIFont yaHeiFontOfSize:17];
    _yuerTime.textColor = WORDDARKCOLOR;
    _yuerTime.textAlignment = NSTextAlignmentCenter;
    [_nextView addSubview:_yuerTime];
    
    
    UILabel *lin = [[UILabel alloc] initWithFrame:CGRectMake(_yuerTime.frame.origin.x, _yuerTime.frame.origin.y+_yuerTime.frame.size.height+10, _yuerTime.frame.size.width, 2)];
    lin.backgroundColor = wordColor;
    [_nextView addSubview:lin];
    
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(_yuerTime.frame.origin.x+20, _yuerTime.frame.origin.y+_yuerTime.frame.size.height+20, _yuerTime.frame.size.width-40, 400)];
    bgView.image = [UIImage imageNamed:@"shalong-kuang1" ofSex:self.sex];
    [_nextView addSubview:bgView];
    _yuerImage = [[UIImageView alloc] initWithFrame:CGRectMake(_yuerTime.frame.origin.x+20+1, _yuerTime.frame.origin.y+_yuerTime.frame.size.height+20+1, _yuerTime.frame.size.width-40-2, 400-2)];
    _yuerImage.image = [UIImage imageNamed:@"0-kefuditu"];
    [_nextView addSubview:_yuerImage];
    
    
    _yuerbaoMing = [UIButton buttonWithType:UIButtonTypeCustom];
    _yuerbaoMing.frame = CGRectMake(lin.frame.origin.x+(lin.frame.size.width/2)-(200/2), _yuerImage.frame.origin.y+_yuerImage.frame.size.height+20, 234, 57);
//    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateNormal];
//    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateDisabled];
//    
//    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateHighlighted];
//    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateSelected];
    _yuerbaoMing.enabled = YES;
    _yuerbaoMing.selected = NO;
//    [_yuerbaoMing setTitle:@"报名" forState:UIControlStateNormal];
    [_yuerbaoMing setTitleColor:wordColor forState:UIControlStateNormal];
    [_yuerbaoMing setTitleColor:wordColor forState:UIControlStateDisabled];
    
    _yuerbaoMing.titleLabel.font = [UIFont yaHeiFontOfSize:19];
//    [_yuerbaoMing setTitle:@"报名已截止" forState:UIControlStateDisabled];
    [_yuerbaoMing addTarget:self action:@selector(baoMingAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [_nextView addSubview:_yuerbaoMing];
    
    
    _yuerTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(lin.frame.origin.x, _yuerbaoMing.frame.origin.y+_yuerbaoMing.frame.size.height, lin.frame.size.width, 50)];
    _yuerTextLabel.font = [UIFont yaHeiFontOfSize:16];
    _yuerTextLabel.numberOfLines = 2;
    _yuerTextLabel.textColor = WORDDARKCOLOR;
    [_nextView addSubview:_yuerTextLabel];
    
    UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(190, 100, 38, 50);
    UIImageView *fanhuiImg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 18, 30)];
    fanhuiImg.image = [UIImage imageNamed:@"yangyu-left" ofSex:self.sex];
    [button addSubview:fanhuiImg];

    [button addTarget:self action:@selector(returnAction:) forControlEvents:UIControlEventTouchUpInside];
    [_nextView addSubview:button];
    
    
}
#pragma mark - 报名


-(void)baoMingAction:(UIButton *)button{
    if (_tapCell) {
        NSDictionary *dic = @{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"salonId":_tapCell};
        
        [NetRequestManage joinSalonWithDictionary:dic successBlocks:^(NSData *data, NetRequestManage *loadUser) {
            NSString *str = [[NSString alloc] initWithData:loadUser.resultData encoding:NSUTF8StringEncoding];
            NSLog(@"baoming str = %@",str);
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:loadUser.resultData options:NSJSONReadingMutableContainers error:nil];
            _isJoinDic = dic;
            if ([[dic objectForKey:@"errorId"] intValue] == -900) {
                [self overRun];
            }
            if ([[_isJoinDic objectForKey:@"result"] objectForKey:@"isJoinSalon"]) {
                [_signedSalons addObject:_tapCell];
                [_yuerbaoMing setTitle:@"已报名" forState:UIControlStateDisabled];
                [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateDisabled];
                _yuerbaoMing.enabled = NO;
            }
            
        } andFailedBlocks:^(NSError *error, NetRequestManage *loadUser) {
            NSLog(@"error = %@",error.description);
        }];
        

    }
    
}
-(void)returnAction:(UIButton *)button{
    [self.view sendSubviewToBack:_nextView];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    page.currentPage = scrollView.contentOffset.x/717;
}
-(void)changePage:(UIPageControl *)page0{
    UIScrollView *sc = (UIScrollView *)[_mainView viewWithTag:2000000];
    sc.contentOffset = CGPointMake(page0.currentPage*717, 0);
}

#pragma mark - collectionView相关


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    UIImageView *ve = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 333, 164)];
    ve.image = [UIImage imageNamed:@"shalong-kuang1" ofSex:self.sex];
    UIImageView *ve1 = [[UIImageView alloc] initWithFrame:CGRectMake(1, 1, 331, 162)];
    [ve addSubview:ve1];
    if (_salon.count>0) {
        LoginUserSalonList *sal = _salon[indexPath.row+1];
        [ve1 sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:sal.salonimg]]];
    }
    
//    [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:sal.salonimg]]]
    cell.backgroundView = ve;
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_salon count]-1;
}
//定义每个UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(333, 164);
}


//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"cell被点击!");
    
    if (_salon.count>0) {
        LoginUserSalonList *sal = _salon[indexPath.row+1];
        _yuerTitle.text = sal.salontopic;
        _yuerTime.text = sal.salonindex;
        _tapCell = sal.salonid;
        if ([_yuerbaoMing.titleLabel.text isEqualToString:@"已报名"]) {
            
        }else{
            _yuerbaoMing.enabled = YES;
            [_yuerbaoMing setTitle:@"报名" forState:UIControlStateNormal];
            [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateNormal];
        }
        if (_signedSalons.count>0) {
            for (NSString *userSalon in _signedSalons) {
                if ([userSalon isEqualToString:sal.salonid]) {
                    
                    [_yuerbaoMing setTitle:@"已报名" forState:UIControlStateDisabled];
                    [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"kefu-anniu2" ofSex:self.sex] forState:UIControlStateDisabled];

                    _yuerbaoMing.enabled = NO;
                    
                }
            }
        }
        
        NSDateFormatter *format = [[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        NSDate *date = [format dateFromString:sal.signupendtme];
        NSDate *nowDate = [[NSDate date] dateByAddingTimeInterval:60*60*8];
        if ([nowDate isEqualToDate:[nowDate laterDate:date]]) {
            
            [_yuerbaoMing setTitle:@"" forState:UIControlStateDisabled];
            [_yuerbaoMing setBackgroundImage:[UIImage imageNamed:@"shalong-jiezhi"] forState:UIControlStateDisabled];
            _yuerbaoMing.enabled = NO;
        }
        
        
        [_yuerImage sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:sal.salonimg]]];
        _yuerTextLabel.text = sal.salongdesc;
    }
    [self.view bringSubviewToFront:_nextView];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
