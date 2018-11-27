//
//  RecordStarFirstRecordAge.h
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RecordStarFirstRecordAge : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *age;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
