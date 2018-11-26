//
//  Fcgo_AddStorePhotoCell.h
//  Fcgo
//
//  Created by huafanxiao on 2017/11/24.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Fcgo_AddStorePhotoCell : UITableViewCell

@property (nonatomic,copy) void(^imageBlock)(UIImage *image);
@property (weak, nonatomic) IBOutlet UILabel     *storePhotoLabel;

@end
