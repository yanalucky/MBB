//
//  FeedbackFeedbackList.h
//
//  Created by  豆蒙萌 on 15/10/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FeedbackFeedbackList : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *backtype;
@property (nonatomic, strong) NSString *isnew;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *backcontent;
@property (nonatomic, strong) NSString *backtime;
@property (nonatomic, strong) NSString *feedbackid;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
