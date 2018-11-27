//
//  NoDeclaredViewController.m
//  MBB1
//
//  Created by 陈彦 on 15/9/6.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "NoDeclaredViewController.h"

@interface NoDeclaredViewController ()

@end

@implementation NoDeclaredViewController

- (void)viewDidLoad {
    [[NSUserDefaults standardUserDefaults] setObject:@"seenResponse" forKey:@"seenResponse"];
    [super viewDidLoad];
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
