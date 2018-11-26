//
//  Fcgo_UserTools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Fcgo_UserTools : NSObject

@property (nonatomic,assign) BOOL                 isFirstLaunch;
@property (nonatomic,assign) BOOL                 isLogin;
@property (nonatomic,strong) NSString             *tel;
@property (nonatomic,strong) NSMutableDictionary  *userDict;

@property (nonatomic,strong) NSMutableArray       *searchListArray;//搜搜历史

//@property (nonatomic,strong) NSMutableArray       *provinceArray;//省份
@property (nonatomic,strong) NSMutableArray       *cityArray;//城市
//@property (nonatomic,strong) NSMutableArray       *districtArray;//地区

@property (nonatomic,strong) NSMutableDictionary  *userAddressDict;//用户地址

@property (nonatomic,strong) NSMutableDictionary  *deviceDict;

@property (nonatomic,strong) NSString  *userHeaderImageUrl;

+ (Fcgo_UserTools *)shared;

-(void)clearUserInfomation;

@end
