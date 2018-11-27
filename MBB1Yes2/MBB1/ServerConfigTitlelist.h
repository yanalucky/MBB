//
//  ServerConfigTitlelist.h
//
//  Created by  豆蒙萌 on 15/9/21
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ServerConfigTitlelist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *titlelistIdentifier;
@property (nonatomic, strong) NSString *questionnaireid;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *titleorder;
@property (nonatomic, strong) NSString *titleid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
