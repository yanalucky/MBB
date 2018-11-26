//
//  Fcgo_SiftModel.h
//  Fcgo
//
//  Created by by_r on 2017/11/28.
//  Copyright © 2017年 Fcg. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Fcgo_SiftSelectModel;
@interface Fcgo_SiftModel : NSObject
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *type;
@property (nonatomic, strong) NSArray<Fcgo_SiftSelectModel *> *list;
@end

@interface Fcgo_SiftSelectModel : NSObject
@property (nonatomic, copy) NSString    *title;
@property (nonatomic, copy) NSString    *value;
@property (nonatomic, strong) NSNumber  *year;
@property (nonatomic, strong) NSNumber  *month;
@property (nonatomic, strong) NSNumber  *day;
@property (nonatomic, assign, getter=isSelected) BOOL  selected;
@end
