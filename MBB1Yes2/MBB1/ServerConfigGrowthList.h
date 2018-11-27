//
//  ServerConfigGrowthList.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigGrowthList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *observecontent;
@property (nonatomic, strong) NSString *observeupdatetime;
@property (nonatomic, strong) NSString *observeid;
@property (nonatomic, strong) NSString *observeorder;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
