//
//  Fcgo_BrandCell.h
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Fcgo_SiftModel;
@class Fcgo_SiftSelectModel;

@protocol Fcgo_BrandCellDelegate <NSObject>
- (void)selected:(Fcgo_SiftSelectModel *)model indexPath:(NSIndexPath *)indexPath;
@end

@interface Fcgo_BrandCell : UITableViewCell
@property (assign, nonatomic) id<Fcgo_BrandCellDelegate> delegate;

- (void)setModel:(Fcgo_SiftModel *)model indexPath:(NSIndexPath *)indexPath width:(CGFloat)width;
@end
