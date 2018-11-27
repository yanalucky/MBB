//
//  OnlineAppraisalResult.h
//
//  Created by   on 16/7/18
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface OnlineAppraisalResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *onlineAppraisal;
@property (nonatomic, strong) NSArray *imgdata;
@property (nonatomic, strong) NSString *firstRecordStatus;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
