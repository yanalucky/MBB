//
//  LoginUserDetaillist.h
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserDetaillist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *imgidx;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *detaillistIdentifier;
@property (nonatomic, strong) NSString *appraisaltitle;
@property (nonatomic, strong) NSString *imgurlversion;
@property (nonatomic, strong) NSString *recordid;
@property (nonatomic, strong) NSString *nurturetype;
@property (nonatomic, strong) NSString *appraisalorder;
@property (nonatomic, strong) NSString *appraisalcontent;
@property (nonatomic, strong) NSString *appraisaltime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
