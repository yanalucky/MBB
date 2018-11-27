//
//  ServerConfigHistoryRecordList.h
//
//  Created by   on 16/6/21
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigHistoryRecordList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *historyRecordListIdentifier;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *historytype;
@property (nonatomic, strong) NSString *historytime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
