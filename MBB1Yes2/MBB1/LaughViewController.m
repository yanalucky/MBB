//
//  LaughViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/10/26.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "LaughViewController.h"
#import "LoginViewController.h"
@interface LaughViewController ()

@end

@implementation LaughViewController
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"launthMov.mp4" ofType:nil];
    NSURL *localUrl = [NSURL fileURLWithPath:path];
    //很重要的一点是在头文件里已经把player变为属性了，@property（nonamaic,strong），如果不写为属性就会黑屏，目前不知道为什么
    _player =[[MPMoviePlayerController alloc] initWithContentURL:localUrl];
    [_player.view setFrame:self.view.bounds];  // player的尺寸
    
    _player.controlStyle = MPMovieControlStyleNone;
    
    [_player prepareToPlay];
    
    [self.view addSubview: self.player.view];
    _player.shouldAutoplay=YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:nil];
       // Do any additional setup after loading the view.
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
   
    if (self.player&&([[NSUserDefaults standardUserDefaults] objectForKey:@"ManyOfLogin"])) {
        [self.player stop];
        self.player = nil;
        LoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
        
        [self presentViewController:login animated:NO completion:nil];

       
        NSLog(@"remove player");
    }
}
-(void)moviePlayBackDidFinish:(NSNotification *)notification{
    [_player.view removeFromSuperview];
    [_player stop];
    _player = nil;
    [[NSUserDefaults standardUserDefaults] setObject:@"NOTFIRST" forKey:@"ManyOfLogin"];
    LoginViewController *login = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    [self presentViewController:login animated:NO completion:nil];
    
    NSLog(@"remove player");
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
