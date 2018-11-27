//
//  FeedbackResult.h
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FeedbackResult : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSArray *feedbackList;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
