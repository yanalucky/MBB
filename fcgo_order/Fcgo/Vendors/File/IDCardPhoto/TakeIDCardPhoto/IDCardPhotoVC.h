//
//  IDCardPhotoVC.h
//  IDCardAndPhotoDemo
//
//  Created by huafanxiao on 2017/7/27.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IDCardPhotoVC : UIViewController

@property (nonatomic, assign) BOOL isHeaderFace;//是否是身份证正面
@property (nonatomic, strong) void(^whenFinsh)(UIImage *);

@end
