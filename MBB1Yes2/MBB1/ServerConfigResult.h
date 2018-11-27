//
//  ServerConfigResult.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *appConfigList;
@property (nonatomic, strong) NSArray *doctorList;
@property (nonatomic, strong) NSString *currentVersion;
@property (nonatomic, strong) NSArray *growthList;
@property (nonatomic, strong) NSString *lowestVersion;
@property (nonatomic, strong) NSArray *hospitalList;
@property (nonatomic, strong) NSArray *featureList;
@property (nonatomic, strong) NSArray *questionList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
