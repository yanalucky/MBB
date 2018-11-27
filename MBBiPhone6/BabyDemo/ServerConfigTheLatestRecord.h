//
//  ServerConfigTheLatestRecord.h
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigTheLatestRecord : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *recordstatus;
@property (nonatomic, strong) NSString *recordid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
