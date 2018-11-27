//
//  JLUser.h
//
//  Created by  豆蒙萌 on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface JLUser : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *feedingtype;
@property (nonatomic, strong) NSString *hashypertension;
@property (nonatomic, strong) NSString *diseasescreening;
@property (nonatomic, strong) NSString *submitpwd;
@property (nonatomic, strong) NSString *hasdiabetes;
@property (nonatomic, strong) NSString *hasanemia;
@property (nonatomic, strong) NSString *bornreport;
@property (nonatomic, strong) NSString *sex;
//@property (nonatomic, strong) NSString *agreementtype;
@property (nonatomic, strong) NSString *nativeplace;
@property (nonatomic, strong) NSString *isstop;
@property (nonatomic, strong) NSString *borntype;
@property (nonatomic, strong) NSString *carerphone;
@property (nonatomic, strong) NSString *loginpwd;
@property (nonatomic, strong) NSString *mumage;
@property (nonatomic, strong) NSString *mumphone;
@property (nonatomic, strong) NSString *bornplace;
@property (nonatomic, strong) NSString *dadphone;
@property (nonatomic, strong) NSString *bornheight;
@property (nonatomic, strong) NSString *nationality;
@property (nonatomic, strong) NSString *parity;
@property (nonatomic, strong) NSString *mumheight;
@property (nonatomic, strong) NSString *mumemail;
@property (nonatomic, strong) NSString *enterreportversion;
@property (nonatomic, strong) NSString *dadage;
@property (nonatomic, strong) NSString *bcusedcount;
@property (nonatomic, strong) NSString *dademail;
@property (nonatomic, strong) NSString *linkmansex;
//@property (nonatomic, strong) NSString *agreementlimit;
@property (nonatomic, strong) NSString *dadeducation;
@property (nonatomic, strong) NSString *otherdesc;
@property (nonatomic, strong) NSString *bctotalcount;
@property (nonatomic, strong) NSString *carersex;
@property (nonatomic, strong) NSString *hasicp;
@property (nonatomic, strong) NSString *roleid;
@property (nonatomic, strong) NSString *deliverymethods;
@property (nonatomic, strong) NSString *mumweight;
@property (nonatomic, strong) NSString *hospitalid;
@property (nonatomic, strong) NSString *salontotalcount;
@property (nonatomic, strong) NSString *borntime;
@property (nonatomic, strong) NSString *agreement;
@property (nonatomic, strong) NSString *userid;
@property (nonatomic, strong) NSString *carer;
@property (nonatomic, strong) NSString *dadname;
@property (nonatomic, strong) NSString *bornweight;
@property (nonatomic, strong) NSString *treatusedcount;
@property (nonatomic, strong) NSString *careeducation;
@property (nonatomic, strong) NSString *hasotherdisease;
//@property (nonatomic, strong) NSString *agreementstartage;
@property (nonatomic, strong) NSString *truename;
@property (nonatomic, strong) NSString *carername;
@property (nonatomic, strong) NSString *birthday;
//@property (nonatomic, strong) NSString *agreementstart;
@property (nonatomic, strong) NSString *mumbearage;
@property (nonatomic, strong) NSString *carenativeplace;
@property (nonatomic, strong) NSString *hasfirstheart;
@property (nonatomic, strong) NSString *accountmobile;
@property (nonatomic, strong) NSString *dadheight;
@property (nonatomic, strong) NSString *linkmanemail;
@property (nonatomic, strong) NSString *filecode;
@property (nonatomic, strong) NSString *linkman;
@property (nonatomic, strong) NSString *enterreport;
@property (nonatomic, strong) NSString *mumeducation;
@property (nonatomic, strong) NSString *agreementversion;
@property (nonatomic, strong) NSString *treattotalcount;
@property (nonatomic, strong) NSString *salonusedcount;
@property (nonatomic, strong) NSString *accountemail;
@property (nonatomic, strong) NSString *mumname;
@property (nonatomic, strong) NSString *nation;
@property (nonatomic, strong) NSString *headimg;
@property (nonatomic, strong) NSString *dadweight;
@property (nonatomic, strong) NSString *linkmanname;
@property (nonatomic, strong) NSString *linkmanmobile;
@property (nonatomic, strong) NSString *emergencyphone;
@property (nonatomic, strong) NSString *bornreportversion;
@property (nonatomic, strong) NSString *hascold;
@property (nonatomic, strong) NSString *pregnancy;
@property (nonatomic, strong) NSString *doctorid;
@property (nonatomic, strong) NSString *gravidity;
@property (nonatomic, strong) NSString *headimgversion;
@property (nonatomic, strong) NSString *accountname;
@property (nonatomic, strong) NSString *haslowweight;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
