//
//  Fcgo_UserTools.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/10.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_UserTools.h"

static NSString *const kFirstLaunchKey     = @"kFirstLaunchKey";
static NSString *const kUserLoginKey       = @"kUserLoginKey";
static NSString *const kServiceTel         = @"kServiceTel";
static NSString *const kUserDictKey        = @"kUserDictKey";
static NSString *const kDeviceDictKey      = @"kDeviceDictKey";

static NSString *const kSearchListArrayKey = @"kSearchListArrayKey";
//static NSString *const kAreaProvinceKey    = @"kAreaProvinceKey";
static NSString *const kAreaCityKey        = @"kAreaCityKey";
//static NSString *const kAreaDistrictKey    = @"kAreaDistrictKey";
static NSString *const kUserAddressDictKey = @"kUserAddressDictKey";
static NSString *const kUserHeaderImageUrl         = @"kUserHeaderImageUrl";
@implementation Fcgo_UserTools

//之所以实现@synthesize，是可以同时实现set get方法
@synthesize tel             = _tel;
@synthesize isFirstLaunch   = _isFirstLaunch;
@synthesize isLogin         = _isLogin;
@synthesize userDict        = _userDict;
@synthesize deviceDict      = _deviceDict;
@synthesize searchListArray = _searchListArray;

//@synthesize provinceArray     = _provinceArray;
@synthesize cityArray           = _cityArray;
//@synthesize districtArray     = _districtArray;
@synthesize userAddressDict     = _userAddressDict;
@synthesize userHeaderImageUrl  = _userHeaderImageUrl;

+ (Fcgo_UserTools *)shared
{
    static  Fcgo_UserTools  *_shareInstance = nil;
    static  dispatch_once_t  onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance=[[Fcgo_UserTools  alloc] init];
    });
    return _shareInstance;
}
- (void)clearUserInfomation
{
    //[OBJC_Defaults removeObjectForKey:kFirstLaunchKey];
    [OBJC_Defaults removeObjectForKey:kUserLoginKey];
    [OBJC_Defaults removeObjectForKey:kServiceTel];
    [OBJC_Defaults removeObjectForKey:kUserDictKey];
    [OBJC_Defaults removeObjectForKey:kDeviceDictKey];
    [OBJC_Defaults removeObjectForKey:kSearchListArrayKey];
//    [OBJC_Defaults removeObjectForKey:kAreaCityKey];
    [OBJC_Defaults removeObjectForKey:kUserAddressDictKey];
    [OBJC_Defaults removeObjectForKey:kUserHeaderImageUrl];
    
    //[[NSFileManager defaultManager] removeItemAtPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/adImagePath"] error:nil];
    
    
}

- (void)setTel:(NSString *)tel
{
    _tel= tel;
    [OBJC_Defaults  setObject:tel forKey:kServiceTel];
    [OBJC_Defaults  synchronize];
}

- (NSString *)tel
{
    _tel = [OBJC_Defaults objectForKey:kServiceTel];
    return _tel;
}

- (void)setIsFirstLaunch:(BOOL)isFirstLaunch
{
    _isFirstLaunch = isFirstLaunch;
    [OBJC_Defaults  setBool:isFirstLaunch forKey:kFirstLaunchKey];
    [OBJC_Defaults  synchronize];
}

- (BOOL)isFirstLaunch
{
    _isFirstLaunch = [OBJC_Defaults boolForKey:kFirstLaunchKey];
    return _isFirstLaunch;
}

- (void)setIsLogin:(BOOL)isLogin
{
    _isLogin = isLogin;
    [OBJC_Defaults  setBool:isLogin forKey:kUserLoginKey];
    [OBJC_Defaults  synchronize];
}

- (BOOL)isLogin
{
    _isLogin = [OBJC_Defaults boolForKey:kUserLoginKey];
    return _isLogin;
}

- (void)setUserDict:(NSMutableDictionary *)userDict
{
    _userDict = userDict;
    [OBJC_Defaults setObject:_userDict forKey:kUserDictKey];
    [OBJC_Defaults synchronize];
}

-(void)setDeviceDict:(NSMutableDictionary *)deviceDict{
    _deviceDict = deviceDict;
    [OBJC_Defaults setObject:_deviceDict forKey:kDeviceDictKey];
    [OBJC_Defaults synchronize];
}
- (NSMutableDictionary  *)userDict
{
    _userDict = [OBJC_Defaults objectForKey:kUserDictKey];
    return _userDict.mutableCopy;
}

-(NSMutableDictionary *)deviceDict{
    _deviceDict = [OBJC_Defaults objectForKey:kDeviceDictKey];
    return _deviceDict;
}

- (void)setUserAddressDict:(NSMutableDictionary *)userAddressDict
{
    _userAddressDict = userAddressDict;
    [OBJC_Defaults  setObject:userAddressDict forKey:kUserAddressDictKey];
    [OBJC_Defaults  synchronize];
}

- (NSMutableDictionary  *)userAddressDict
{
    _userAddressDict = [OBJC_Defaults objectForKey:kUserAddressDictKey];
    return _userAddressDict;
}

-(void)setSearchListArray:(NSMutableArray *)searchListArray
{
    _searchListArray = searchListArray;
    [OBJC_Defaults  setObject:searchListArray forKey:kSearchListArrayKey];
    [OBJC_Defaults  synchronize];
}

- (NSMutableArray *)searchListArray
{
    _searchListArray = [OBJC_Defaults objectForKey:kSearchListArrayKey];
    return _searchListArray;
}

//- (void)setProvinceArray:(NSMutableArray *)provinceArray
//{
//    _provinceArray=provinceArray;
//    [OBJC_Defaults  setObject:_provinceArray forKey:kAreaProvinceKey];
//    [OBJC_Defaults  synchronize];
//}

//- (NSMutableArray *)provinceArray
//{
//    _provinceArray=[OBJC_Defaults  objectForKey:kAreaProvinceKey];
//    return _provinceArray;
//}

- (void)setCityArray:(NSMutableArray *)cityArray
{
    _cityArray=cityArray;
    [OBJC_Defaults  setObject:_cityArray forKey:kAreaCityKey];
    [OBJC_Defaults  synchronize];
}

- (NSMutableArray *)cityArray
{
    _cityArray=[OBJC_Defaults  objectForKey:kAreaCityKey];
    return _cityArray;
}


- (void)setUserHeaderImageUrl:(NSString *)userHeaderImageUrl
{
    _userHeaderImageUrl= userHeaderImageUrl;
    [OBJC_Defaults  setObject:userHeaderImageUrl forKey:kUserHeaderImageUrl];
    [OBJC_Defaults  synchronize];
}

- (NSString *)userHeaderImageUrl
{
    _userHeaderImageUrl = [OBJC_Defaults objectForKey:kUserHeaderImageUrl];
    return _userHeaderImageUrl;
}


//
//- (void)setDistrictArray:(NSMutableArray *)districtArray
//{
//    _districtArray=districtArray;
//    [OBJC_Defaults setObject:districtArray forKey:kAreaDistrictKey];
//    [OBJC_Defaults synchronize];
//}
//
//- (NSMutableArray *)districtArray
//{
//    _districtArray=[OBJC_Defaults  objectForKey:kAreaDistrictKey];
//    return _districtArray;
//}
@end
