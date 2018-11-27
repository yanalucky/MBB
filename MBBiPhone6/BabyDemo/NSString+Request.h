//
//  NSString+Request.h
//  MBB1
//
//  Created by 陈彦 on 15/9/18.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Request)
+(instancetype)stringWithParamStr:(NSString *)string addSesId:(NSString *)seID;
+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+(NSString *)urlStringOfImage:(NSString *)str;
+(NSString *)urlStringOfPrefix:(NSString *)str;
@end
