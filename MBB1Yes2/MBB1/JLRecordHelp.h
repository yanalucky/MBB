//
//  JLRecordHelp.h
//
//  Created by  豆蒙萌 on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JLRecordHelp : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *headcircumference;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *recordHelpIdentifier;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *cacation;
@property (nonatomic, strong) NSString *chestcircumference;
@property (nonatomic, strong) NSString *milkamount;
@property (nonatomic, strong) NSString *showitem;
@property (nonatomic, strong) NSString *sleep;
@property (nonatomic, strong) NSString *urinate;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
