//
//  ServerConfigFeatureList.h
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigFeatureList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *featureListIdentifier;
@property (nonatomic, strong) NSString *detaildesc;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, strong) NSString *featurename;
@property (nonatomic, strong) NSString *examplemovidx;
@property (nonatomic, strong) NSString *featureorder;
@property (nonatomic, strong) NSString *exampleimg;
@property (nonatomic, strong) NSString *exampleimgversion;
@property (nonatomic, strong) NSString *pointtag;
@property (nonatomic, strong) NSString *examplemov;
@property (nonatomic, strong) NSString *exampleidx;
@property (nonatomic, assign) double monthage;
@property (nonatomic, strong) NSString *examplemovversion;
@property (nonatomic, strong) NSString *typeid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
