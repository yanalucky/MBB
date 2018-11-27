//
//  UserHeaderViewController.m
//  BabyDemo
//
//  Created by 陈彦 on 16/3/29.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UserHeaderViewController.h"
#import "SelectHeaderViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "MainViewController.h"
#import "LoginUser.h"
#import "UIImageView+WebCache.h"
#import "ASIFormDataRequest.h"


@interface UserHeaderViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    
    UIImageView *imageHeader;
}

@end

@implementation UserHeaderViewController

-(void)viewWillAppear:(BOOL)animated{
//    [[SDImageCache sharedImageCache] clearDisk];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";

//    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
//    }
    
    
    
    [self createInterface];
}

-(void)createInterface{
    NSDictionary *userDic = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    NSLog(@"userDic = %@",userDic);
//    LoginUser *user = [[LoginUser alloc] initWithDictionary:userDic];
    imageHeader = [[UIImageView alloc] init];
//    imageHeader.image = [UIImage imageNamed:@"chouti_07"];
    [[SDImageCache sharedImageCache] clearDisk];
    
//    [imageHeader sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:user.headimg]]];
    NSString *path = NSHomeDirectory();
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    imageHeader.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
    
    
    imageHeader.backgroundColor = [UIColor magentaColor];
    imageHeader.layer.masksToBounds = YES;
    imageHeader.layer.cornerRadius = 90*Ratio;
    [self.view addSubview:imageHeader];
    [imageHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.equalTo(@(180*Ratio));
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(55*Ratio);
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button setTitle:@"拍照" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"shouye_tl_camera"] forState:UIControlStateNormal];
    button.tag = 1001;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 42*Ratio));
        make.left.equalTo(self.view).offset(55*Ratio);
        make.bottom.equalTo(self.view).offset(-167*Ratio);
    }];
    
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setTitle:@"相册" forState:UIControlStateNormal];
    [button1 setBackgroundImage:[UIImage imageNamed:@"shouye_tl_photo"] forState:UIControlStateNormal];

    button1.tag = 1002;
    [button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button1 addTarget:self action:@selector(cameraClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(70*Ratio, 42*Ratio));
        make.right.equalTo(self.view).offset(-55*Ratio);
        make.bottom.equalTo(self.view).offset(-167*Ratio);
    }];
}
-(void)cameraClick:(UIButton *)button{

    SelectHeaderViewController *select = [[SelectHeaderViewController alloc] init];
    
    if (button.tag == 1001) {
        //拍照
        //设置资源类型 --> 先要检测要设置的资源类型是否可用
        if ([UIImagePickerController  isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [select setSourceType:UIImagePickerControllerSourceTypeCamera];
            select.delegate = self;
            select.allowsEditing = YES;
            [self presentViewController:select animated:YES completion:nil];
            
        }
        else{
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相机不可用" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];
            

            
//            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"无法访问相机" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [av show];
            
        }
    }else{
        //相册选择
        if ([SelectHeaderViewController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            [select setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            //设置允许编辑
            select.delegate = self;
            
            select.allowsEditing = YES;
            
            
            [self presentViewController:select animated:YES completion:nil];
        }
        else{
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"相册不可用" message:nil preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alert addAction:action];
            
            [self presentViewController:alert animated:YES completion:nil];
//            UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"无法访问相册" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [av show];
        }
    }
}
#pragma mark - UIImagePickerControllerDelegate相关
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    //选择完成 --> 判断选择完的资源是image还是media
    NSLog(@"选择完成的info  = %@",info);
    NSString *str = [info objectForKey:UIImagePickerControllerMediaType];
    if ([str isEqualToString:(NSString *)kUTTypeImage]) {
        //UIImagePickerControllerEditedImage:编辑后的照片
        //UIImagePickerControllerOriginalImage:原图
        
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        NSLog(@"imageSize = %@",NSStringFromCGSize(image.size));
        imageHeader.image = image;
         UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        NSData *data = UIImageJPEGRepresentation(image, 0.25);
        [self uploadPhoto:data];
        [self saveImage:data];
//        UIImage *tempImg = [[UIImage alloc] initWithData:data];

        _myBlocks(image);
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
        
    }
    
    
}

-(void)changeHeaderBlock:(void (^)(UIImage *))headerBlock{
    _myBlocks = [headerBlock copy];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{

    [self dismissViewControllerAnimated:YES completion:nil];

}
#pragma mark - 存储图片

-(void)saveImage:(NSData *)data{
    
    
    
    NSString *path = NSHomeDirectory();
    
    
    NSString *jpgImagePath = [path stringByAppendingPathComponent:@"Documents/header.jpg"];
    NSLog(@"path = %@     jpgImagePath = %@",path,jpgImagePath);
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *contents = [[NSBundle mainBundle] pathForResource:jpgImagePath ofType:@"jpg"];
    
    
    if(contents){
        [manager removeItemAtPath:path error:nil];
    }
    [data writeToFile:jpgImagePath atomically:YES];
    
    
    
//    imageHeader.image = [[UIImage alloc] initWithContentsOfFile:jpgImagePath];
}
#pragma mark - 上传头像

-(void)uploadPhoto:(NSData *)imageData{
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,UPLOADUSERHEAD]];
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
            NSLog(@"uploadPhotoResult = %@",dict);
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
