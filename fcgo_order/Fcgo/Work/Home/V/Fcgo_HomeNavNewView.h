//
//  Fcgo_HomeNavNewView.h
//  Fcgo
//
//  Created by fcg on 2017/11/2.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ScanBlock)(void);
typedef void(^SearchBlock)(void);
typedef void(^ChooseAddressBlock)(NSString *address);

@interface Fcgo_HomeNavNewView : UIView

@property (nonatomic,assign) float       bgAlpha;

@property (nonatomic,copy)   ScanBlock             scanBlock;
@property (nonatomic,copy)   SearchBlock           searchBlock;
@property (nonatomic,copy)   ChooseAddressBlock    chooseAddressBlock;
- (instancetype)initWithFrame:(CGRect)frame
                       ofScan:(void(^)(void))scanBlock
                     ofSearch:(void(^)(void))searchBlock
                        ofChooseAdd:(void(^)(NSString *address))ChooseAddressBlock;

@end
