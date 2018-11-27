//
//  PictureViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/10/13.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "PictureViewController.h"
#import "MyView.h"
@interface PictureViewController ()<UIScrollViewDelegate>

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInterface];
    // Do any additional setup after loading the view.
}

-(void)createInterface{
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    sc.scrollEnabled = YES;
    sc.showsHorizontalScrollIndicator=NO;
    sc.showsVerticalScrollIndicator=NO;
    sc.delegate = self;                                   //实现Scrollview的代理，需要在.h 文件中添加
    sc.bounces=NO;
    sc.bouncesZoom=NO;
    sc.minimumZoomScale=1;
    sc.maximumZoomScale=5;
    sc.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [sc addGestureRecognizer:tap];
//    sc.zoomScale = 10;
    sc.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:sc];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bg.tag = 111111;
    bg.image = [UIImage imageNamed:self.bgImageName ofSex:self.sex];
    
    MyView *myView = [[MyView alloc] initWithFrame:CGRectMake(1024*109/826, 768*118/584, 1024*593/826, 768*380/584)];
    myView.xDataArr = [self.xAndYDic objectForKey:@"x"];
    myView.yDataArr = [self.xAndYDic objectForKey:@"y"];
    [bg addSubview:myView];
    
    [sc addSubview:bg];
}
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    UIView *view = [scrollView viewWithTag:111111];
    return view;
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    [self dismissViewControllerAnimated:NO completion:nil];
 
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
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
