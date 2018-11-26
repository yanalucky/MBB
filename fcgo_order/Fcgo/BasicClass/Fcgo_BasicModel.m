//
//  Fcgo_BasicModel.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_BasicModel.h"
#import <objc/runtime.h>

@implementation Fcgo_BasicModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self enCoder:aCoder];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        [self deCoder:aDecoder];
    }
    return self;
}

#pragma mark -- default action
//runtime处理属性encoder
- (void)enCoder:(NSCoder *)aCoder
{
    @try
    {
        unsigned int outCount, i;
        objc_property_t *properties     = class_copyPropertyList([self class], &outCount);
        for (i=0; i<outCount; i++)
        {
            objc_property_t property    = properties[i];
            NSString * propertyName     = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
            
            id propertyValue            = [self valueForKey:propertyName];
            if(propertyValue)
            {
                const char * attributes = property_getAttributes(property);
                NSString * attributeString = [NSString stringWithUTF8String:attributes];
                NSArray * attributesArray = [attributeString componentsSeparatedByString:@","];
                if ([attributesArray containsObject:@"R"])
                {
                    
                }
                else
                {
                    [aCoder encodeObject:propertyValue forKey:propertyName];
                }
            }
        }
        free(properties);
    }
    @catch (NSException *exception)
    {
        NSAssert(0, exception.description);
    }
    @finally
    {
        
    }
}

//runtime处理属性decoder
- (void)deCoder:(NSCoder *)aDecoder
{
    @try
    {
        unsigned int outCount, i;
        objc_property_t *properties     = class_copyPropertyList([self class], &outCount);
        for (i=0; i<outCount; i++)
        {
            objc_property_t property    = properties[i];
            NSString * propertyName     = [[NSString alloc]initWithCString:property_getName(property)  encoding:NSUTF8StringEncoding];
            
            id decoderValue             = [aDecoder decodeObjectForKey:propertyName];
            if(decoderValue)
            {
                const char * attributes = property_getAttributes(property);
                NSString * attributeString = [NSString stringWithUTF8String:attributes];
                NSArray * attributesArray = [attributeString componentsSeparatedByString:@","];
                if ([attributesArray containsObject:@"R"])
                {
                    //只读属性暂不读取
                }
                else
                {
                    [self setValue:decoderValue forKey:propertyName];
                }
            }
        }
        free(properties);
    }
    @catch (NSException *exception)
    {
        NSAssert(0, exception.description);
    }
    @finally {
        
    }
}

@end
