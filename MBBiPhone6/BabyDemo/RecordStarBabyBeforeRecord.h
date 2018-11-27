//
//  RecordStarBabyBeforeRecord.h
//
//  Created by   on 16/7/15
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface RecordStarBabyBeforeRecord : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *babyBeforeRecordIdentifier;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *weight;
@property (nonatomic, strong) NSString *height;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
