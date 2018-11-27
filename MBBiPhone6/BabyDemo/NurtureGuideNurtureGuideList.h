//
//  NurtureGuideNurtureGuideList.h
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NurtureGuideNurtureGuideList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *nurtureGuideListIdentifier;
@property (nonatomic, strong) NSString *nurtureorder;
@property (nonatomic, strong) NSArray *detaillist;
@property (nonatomic, strong) NSString *nurturename;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
