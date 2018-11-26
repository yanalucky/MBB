//
//  Fcgo_AddressTableViewCell.h
//  Fcgo
//
//  Created by fcg on 2017/10/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_AddressTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImgView;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UIImageView *selectImgV;


-(void)makeCellWithAddress:(NSString *)address andIsSel:(BOOL)issel;
@end
