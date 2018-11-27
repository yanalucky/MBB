//
//  NurtureGuideResult.h
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NurtureGuideResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *nurtureGuideList;
@property (nonatomic, strong) NSString *firstRecordStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
