//
//  Fcgo_BrandListModel.h
//  Fcgo
//
//  Created by huafanxiao on 2017/6/18.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_BrandListModel : NSObject

@property (nonatomic, copy) NSString    *createTime;
@property (nonatomic, copy) NSString    *first;
@property (nonatomic, copy) NSString    *logo;
@property (nonatomic, copy) NSString    *logoBrackground;
@property (nonatomic, copy) NSString    *name;
@property (nonatomic, copy) NSString    *updateTime;
@property (nonatomic, strong) NSNumber  *commentNum;
@property (nonatomic, strong) NSNumber  *ID;
@property (nonatomic, strong) NSNumber  *open;
@property (nonatomic, strong) NSNumber  *saleNum;

@end
