//
//  Fcgo_MineCellModel.h
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Fcgo_MineCellItemModel;
@interface Fcgo_MineCellModel : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) NSArray<Fcgo_MineCellItemModel *> *data;
@end

@interface Fcgo_MineCellItemModel: NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSInteger type;
@end
