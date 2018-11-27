//
//  FeatureViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/5/24.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeatureViewController : UIViewController


@property (nonatomic , strong) NSMutableArray *featureDataArr;

@property (nonatomic , strong) NSMutableArray *oldFeatureDataArr;

@property(nonatomic , assign) BOOL isHiddenSubmit;

@property(nonatomic , assign) BOOL canChangeData;


-(void)selectFeatureBlock:(void(^)(NSString *featureString))featureBlock;

@end
