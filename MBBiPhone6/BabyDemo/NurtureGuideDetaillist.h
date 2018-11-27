//
//  NurtureGuideDetaillist.h
//
//  Created by   on 16/5/17
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface NurtureGuideDetaillist : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *imgidx;
@property (nonatomic, strong) NSString *imgurlversion;
@property (nonatomic, strong) NSString *detaillistIdentifier;
@property (nonatomic, strong) NSString *appraisaltitle;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *recordid;
@property (nonatomic, strong) NSString *nurturetype;
@property (nonatomic, strong) NSString *appraisalorder;
@property (nonatomic, strong) NSString *appraisalcontent;
@property (nonatomic, strong) NSString *appraisaltime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
