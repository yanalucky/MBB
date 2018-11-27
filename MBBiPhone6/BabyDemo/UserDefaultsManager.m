//
//  UserDefaultsManager.m
//  BabyDemo
//
//  Created by 陈彦 on 16/7/25.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager


+(void)clearUserInfomation{
    
    NSArray *keyArr = @[@"user",@"userId",@"sessionId",@"userRole",@"month",@"monthTime",@"featureDic",@"featureByAgeArr",@"HospitalListArr",@"hospitalDic",@"DoctorListArr",@"doctorDic",@"salonDic",@"growthDic",@"noticeTimeArr",@"historyTimeArr",@"showTime",@"FirstUser",@"firstRecordDic",@"needFillInRecord",@"needFillInFeature",@"isNewBabyUser"];
    for (int i=0; i<keyArr.count; i++) {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:keyArr[i]];
    }
}

@end
