//
//  LoginViewController.h
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVAudioSession.h>
#import "SGdownloader.h"

@interface LoginViewController : UIViewController{

     SGdownloader * _download;
    NSFileManager *_fileManage;
    NSFileHandle *_handle;
}

@property (strong , nonatomic) MPMoviePlayerController *player;


@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *remberMe;
@property (weak, nonatomic) IBOutlet UILabel *updateDownload;
@property (weak, nonatomic) IBOutlet UIButton *mianze;

- (IBAction)loginBtnClick:(UIButton *)sender;
- (IBAction)rememberMe:(id)sender;
- (IBAction)forgetPassword:(id)sender;
- (IBAction)noDeclared:(id)sender;

@end
