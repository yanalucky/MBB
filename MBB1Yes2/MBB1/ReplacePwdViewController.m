//
//  ReplacePwdViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/10/26.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "ReplacePwdViewController.h"

@interface ReplacePwdViewController ()

@end

@implementation ReplacePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.messageLab.text = self.messagerStr;

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
    
    return UIInterfaceOrientationMaskLandscape;
}

-(BOOL)shouldAutorotate{
    return YES;
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
