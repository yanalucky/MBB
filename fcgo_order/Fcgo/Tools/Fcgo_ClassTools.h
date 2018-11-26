//
//  Fcgo_ClassTools.h
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (setObjectWithNullValidate)

/** 取代setObject:forKey*/
- (BOOL)setObjectWithNullValidate:(id)anObject forKey:(id <NSCopying>)aKey;

@end

/** NSMutableArray扩展-防止数组被塞入nil而崩溃*/
@interface NSMutableArray (addObjectWithNullValidate)

/** 取代addObject:*/
- (BOOL)addObjectWithNullValidate:(id)object;

@end

@interface NSString (substringWithByte)

//计算字符串的字节数(汉字占两个)
- (int)getStringNum;
//从字符串中截取指定字节数
- (NSString *)subStringByByteWithIndex:(NSInteger)index;


- (CGFloat)getWidthWithFont:(CGFloat)fonts isBold:(int)type;

@end

@interface UIColor (stringColor)
/*十六进制的颜色转化*/
+(UIColor *) colorWithString:(NSString *) stringColor;
+(UIColor *) colorWithString:(NSString *) stringColor alpha:(CGFloat )alpha;

@end

@interface UIImage (dataImage)

+(UIImage *) imageWithName:(NSString *)imageName ofType:(NSString *)type;

@end



