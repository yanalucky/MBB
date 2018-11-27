//
//  NSString+Request.m
//  MBB1
//
//  Created by 陈彦 on 15/9/18.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "NSString+Request.h"

@implementation NSString (Request)

+(instancetype)stringWithParamStr:(NSString *)string addSesId:(NSString *)seID{
    NSString *str = [NSString stringWithFormat:@"paramStr=%@&sesId=%@",string,seID];
    return str;
}
+ (NSString*)dictionaryToJson:(NSDictionary *)dic{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
+(NSString *)urlStringOfImage:(NSString *)str{
    NSString *str1= [NSString stringWithFormat:@"%@%@",PREFIXOFIMAGE,str];
    return str1;
}
+(NSString *)urlStringOfPrefix:(NSString *)str{
    
    NSString *str1= [NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,str];
    return str1;
    
}



@end
