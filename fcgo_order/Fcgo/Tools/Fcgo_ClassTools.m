//
//  Fcgo_ClassTools.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/8.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_ClassTools.h"

@implementation NSMutableDictionary(setObjectWithNullValidate)

- (BOOL)setObjectWithNullValidate:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey)
    {
        return NO;
    }
    [self setObject:anObject forKey:aKey];
    return YES;
}

@end

@implementation NSMutableArray (addObjectWithNullValidate)

- (BOOL)addObjectWithNullValidate:(id)object
{
    if (!object)
    {
        return NO;
    }
    if ([object isKindOfClass:[NSString class]])
    {
        NSString *str = (NSString*)object;
        if (str.length == 0)
        {
            return NO;
        }
    }
    [self addObject:object];
    return YES;
}

@end

@implementation NSString (substringWithByte)

- (int)getStringNum
{
    int strlength = 0;
    char* p = (char*)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

- (NSString *)subStringByByteWithIndex:(NSInteger)index
{
    NSInteger sum = 0;
    NSString *subStr = [[NSString alloc] init];
    for(int i = 0; i<[self length]; i++)
    {
        unichar strChar = [self characterAtIndex:i];
        if(strChar < 256)
        {
            sum += 1;
        }
        else
        {
            sum += 2;
        }
        if (sum >= index)
        {
            subStr = [self substringToIndex:i+1];
            return subStr;
        }
    }
    return subStr;
}

- (CGFloat)getWidthWithFont:(CGFloat)fonts isBold:(int)type
{
    CGRect rect;
    if (type == 2) {
        rect = [self boundingRectWithSize:CGSizeMake(1000, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fonts]} context:nil];
    }else if (type == 1){
        rect = [self boundingRectWithSize:CGSizeMake(1000, CGFLOAT_MAX) options: NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fonts]} context:nil];
    }
    return rect.size.width;
}

@end


@implementation UIColor (stringColor)

+ (UIColor *) colorWithString:(NSString *) stringColor
{
    return [self colorWithString:stringColor alpha:1];
}

+(UIColor *) colorWithString:(NSString *) stringColor alpha:(CGFloat )alpha;
{
    NSString *cString = [[stringColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    
    if ([cString length] < 6) return [UIColor blackColor];
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];
            if ([cString length] != 6) return [UIColor blackColor];
    
    // Separate into r, g, b substrings
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}
@end

@implementation UIImage (dataImage)

+(UIImage *) imageWithName:(NSString *)imageName ofType:(NSString *)type
{
    NSString *filePathReload = [[NSBundle mainBundle] pathForResource:imageName ofType:type];
    NSData   *imageData      = [NSData dataWithContentsOfFile:filePathReload];
    return [UIImage imageWithData:imageData];
}
@end
