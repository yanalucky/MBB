//
//  AppDelegate.h
//  BabyDemo
//
//  Created by 陈彦 on 16/2/26.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;



+(AppDelegate *)sharedInstance;


-(void)zhifubaoBackBlock:(void(^)(BOOL isSuccess)) backBlock;
@end

