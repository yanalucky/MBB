//
//  JLFeatureList.h
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JLFeatureList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *featureListIdentifier;
@property (nonatomic, strong) NSString *detailid;
@property (nonatomic, strong) NSString *recordid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
