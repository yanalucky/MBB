//
//  Fcgo_UploadPicVC.h
//  Fcgo
//
//  Created by fcg on 2017/10/28.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicVC.h"

@interface Fcgo_UploadPicVC : Fcgo_BasicVC
@property(nonatomic,strong) NSMutableArray   *collectionDataArray;

@property(nonatomic,strong) NSString *titleStr;
@property (nonatomic,copy) void(^uploadImgSuccessBLock)(NSMutableArray *imgArr);

@end
