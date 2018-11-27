//
//  UserHeaderViewController.h
//  BabyDemo
//
//  Created by 陈彦 on 16/3/29.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FatherViewController.h"

@interface UserHeaderViewController : FatherViewController{
    
    void(^_myBlocks)(UIImage *miv);
}

-(void)changeHeaderBlock:(void(^)(UIImage *miv)) headerBlock;
@end
