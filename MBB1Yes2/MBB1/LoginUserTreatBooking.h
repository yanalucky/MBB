//
//  LoginUserTreatBooking.h
//
//  Created by  豆蒙萌 on 15/10/14
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface LoginUserTreatBooking : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *bookingtime;
@property (nonatomic, strong) NSString *contactperson;
@property (nonatomic, strong) NSString *contactmobile;
@property (nonatomic, strong) NSString *treatbookingid;
@property (nonatomic, strong) NSString *doctorid;
@property (nonatomic, strong) NSString *hospitalid;
@property (nonatomic, strong) NSString *istreat;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
