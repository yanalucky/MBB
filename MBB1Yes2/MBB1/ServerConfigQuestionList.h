//
//  ServerConfigQuestionList.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigQuestionList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *questionListIdentifier;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *titlelist;
@property (nonatomic, strong) NSString *startmonth;
@property (nonatomic, strong) NSString *endmonth;
@property (nonatomic, strong) NSString *isuse;
@property (nonatomic, strong) NSString *id0;
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
