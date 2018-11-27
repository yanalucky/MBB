//
//  OrderViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/6/2.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import <UIKit/UIKit.h>


//@interface Product : NSObject{
//@private
//    float     _price;
//    NSString *_subject;
//    NSString *_body;
//    NSString *_orderId;
//}
//
//@property (nonatomic, assign) float price;
//@property (nonatomic, copy) NSString *subject;
//@property (nonatomic, copy) NSString *body;
//@property (nonatomic, copy) NSString *orderId;
//
//@end

@interface OrderViewController : UIViewController


@property (nonatomic , strong) NSDictionary *doctorDic;
@property (nonatomic , strong) NSString *infoStr;


@end
