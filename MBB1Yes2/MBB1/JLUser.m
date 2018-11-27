//
//  JLUser.m
//
//  Created by  豆蒙萌 on 15/10/16
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "JLUser.h"


NSString *const kJLUserFeedingtype = @"feedingtype";
NSString *const kJLUserHashypertension = @"hashypertension";
NSString *const kJLUserDiseasescreening = @"diseasescreening";
NSString *const kJLUserSubmitpwd = @"submitpwd";
NSString *const kJLUserHasdiabetes = @"hasdiabetes";
NSString *const kJLUserHasanemia = @"hasanemia";
NSString *const kJLUserBornreport = @"bornreport";
NSString *const kJLUserSex = @"sex";
//NSString *const kJLUserAgreementtype = @"agreementtype";
NSString *const kJLUserNativeplace = @"nativeplace";
NSString *const kJLUserIsstop = @"isstop";
NSString *const kJLUserBorntype = @"borntype";
NSString *const kJLUserCarerphone = @"carerphone";
NSString *const kJLUserLoginpwd = @"loginpwd";
NSString *const kJLUserMumage = @"mumage";
NSString *const kJLUserMumphone = @"mumphone";
NSString *const kJLUserBornplace = @"bornplace";
NSString *const kJLUserDadphone = @"dadphone";
NSString *const kJLUserBornheight = @"bornheight";
NSString *const kJLUserNationality = @"nationality";
NSString *const kJLUserParity = @"parity";
NSString *const kJLUserMumheight = @"mumheight";
NSString *const kJLUserMumemail = @"mumemail";
NSString *const kJLUserEnterreportversion = @"enterreportversion";
NSString *const kJLUserDadage = @"dadage";
NSString *const kJLUserBcusedcount = @"bcusedcount";
NSString *const kJLUserDademail = @"dademail";
NSString *const kJLUserLinkmansex = @"linkmansex";
//NSString *const kJLUserAgreementlimit = @"agreementlimit";
NSString *const kJLUserDadeducation = @"dadeducation";
NSString *const kJLUserOtherdesc = @"otherdesc";
NSString *const kJLUserBctotalcount = @"bctotalcount";
NSString *const kJLUserCarersex = @"carersex";
NSString *const kJLUserHasicp = @"hasicp";
NSString *const kJLUserRoleid = @"roleid";
NSString *const kJLUserDeliverymethods = @"deliverymethods";
NSString *const kJLUserMumweight = @"mumweight";
NSString *const kJLUserHospitalid = @"hospitalid";
NSString *const kJLUserSalontotalcount = @"salontotalcount";
NSString *const kJLUserBorntime = @"borntime";
NSString *const kJLUserAgreement = @"agreement";
NSString *const kJLUserUserid = @"userid";
NSString *const kJLUserCarer = @"carer";
NSString *const kJLUserDadname = @"dadname";
NSString *const kJLUserBornweight = @"bornweight";
NSString *const kJLUserTreatusedcount = @"treatusedcount";
NSString *const kJLUserCareeducation = @"careeducation";
NSString *const kJLUserHasotherdisease = @"hasotherdisease";
//NSString *const kJLUserAgreementstartage = @"agreementstartage";
NSString *const kJLUserTruename = @"truename";
NSString *const kJLUserCarername = @"carername";
NSString *const kJLUserBirthday = @"birthday";
//NSString *const kJLUserAgreementstart = @"agreementstart";
NSString *const kJLUserMumbearage = @"mumbearage";
NSString *const kJLUserCarenativeplace = @"carenativeplace";
NSString *const kJLUserHasfirstheart = @"hasfirstheart";
NSString *const kJLUserAccountmobile = @"accountmobile";
NSString *const kJLUserDadheight = @"dadheight";
NSString *const kJLUserLinkmanemail = @"linkmanemail";
NSString *const kJLUserFilecode = @"filecode";
NSString *const kJLUserLinkman = @"linkman";
NSString *const kJLUserEnterreport = @"enterreport";
NSString *const kJLUserMumeducation = @"mumeducation";
NSString *const kJLUserAgreementversion = @"agreementversion";
NSString *const kJLUserTreattotalcount = @"treattotalcount";
NSString *const kJLUserSalonusedcount = @"salonusedcount";
NSString *const kJLUserAccountemail = @"accountemail";
NSString *const kJLUserMumname = @"mumname";
NSString *const kJLUserNation = @"nation";
NSString *const kJLUserHeadimg = @"headimg";
NSString *const kJLUserDadweight = @"dadweight";
NSString *const kJLUserLinkmanname = @"linkmanname";
NSString *const kJLUserLinkmanmobile = @"linkmanmobile";
NSString *const kJLUserEmergencyphone = @"emergencyphone";
NSString *const kJLUserBornreportversion = @"bornreportversion";
NSString *const kJLUserHascold = @"hascold";
NSString *const kJLUserPregnancy = @"pregnancy";
NSString *const kJLUserDoctorid = @"doctorid";
NSString *const kJLUserGravidity = @"gravidity";
NSString *const kJLUserHeadimgversion = @"headimgversion";
NSString *const kJLUserAccountname = @"accountname";
NSString *const kJLUserHaslowweight = @"haslowweight";


@interface JLUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation JLUser

@synthesize feedingtype = _feedingtype;
@synthesize hashypertension = _hashypertension;
@synthesize diseasescreening = _diseasescreening;
@synthesize submitpwd = _submitpwd;
@synthesize hasdiabetes = _hasdiabetes;
@synthesize hasanemia = _hasanemia;
@synthesize bornreport = _bornreport;
@synthesize sex = _sex;
//@synthesize agreementtype = _agreementtype;
@synthesize nativeplace = _nativeplace;
@synthesize isstop = _isstop;
@synthesize borntype = _borntype;
@synthesize carerphone = _carerphone;
@synthesize loginpwd = _loginpwd;
@synthesize mumage = _mumage;
@synthesize mumphone = _mumphone;
@synthesize bornplace = _bornplace;
@synthesize dadphone = _dadphone;
@synthesize bornheight = _bornheight;
@synthesize nationality = _nationality;
@synthesize parity = _parity;
@synthesize mumheight = _mumheight;
@synthesize mumemail = _mumemail;
@synthesize enterreportversion = _enterreportversion;
@synthesize dadage = _dadage;
@synthesize bcusedcount = _bcusedcount;
@synthesize dademail = _dademail;
@synthesize linkmansex = _linkmansex;
//@synthesize agreementlimit = _agreementlimit;
@synthesize dadeducation = _dadeducation;
@synthesize otherdesc = _otherdesc;
@synthesize bctotalcount = _bctotalcount;
@synthesize carersex = _carersex;
@synthesize hasicp = _hasicp;
@synthesize roleid = _roleid;
@synthesize deliverymethods = _deliverymethods;
@synthesize mumweight = _mumweight;
@synthesize hospitalid = _hospitalid;
@synthesize salontotalcount = _salontotalcount;
@synthesize borntime = _borntime;
@synthesize agreement = _agreement;
@synthesize userid = _userid;
@synthesize carer = _carer;
@synthesize dadname = _dadname;
@synthesize bornweight = _bornweight;
@synthesize treatusedcount = _treatusedcount;
@synthesize careeducation = _careeducation;
@synthesize hasotherdisease = _hasotherdisease;
//@synthesize agreementstartage = _agreementstartage;
@synthesize truename = _truename;
@synthesize carername = _carername;
@synthesize birthday = _birthday;
//@synthesize agreementstart = _agreementstart;
@synthesize mumbearage = _mumbearage;
@synthesize carenativeplace = _carenativeplace;
@synthesize hasfirstheart = _hasfirstheart;
@synthesize accountmobile = _accountmobile;
@synthesize dadheight = _dadheight;
@synthesize linkmanemail = _linkmanemail;
@synthesize filecode = _filecode;
@synthesize linkman = _linkman;
@synthesize enterreport = _enterreport;
@synthesize mumeducation = _mumeducation;
@synthesize agreementversion = _agreementversion;
@synthesize treattotalcount = _treattotalcount;
@synthesize salonusedcount = _salonusedcount;
@synthesize accountemail = _accountemail;
@synthesize mumname = _mumname;
@synthesize nation = _nation;
@synthesize headimg = _headimg;
@synthesize dadweight = _dadweight;
@synthesize linkmanname = _linkmanname;
@synthesize linkmanmobile = _linkmanmobile;
@synthesize emergencyphone = _emergencyphone;
@synthesize bornreportversion = _bornreportversion;
@synthesize hascold = _hascold;
@synthesize pregnancy = _pregnancy;
@synthesize doctorid = _doctorid;
@synthesize gravidity = _gravidity;
@synthesize headimgversion = _headimgversion;
@synthesize accountname = _accountname;
@synthesize haslowweight = _haslowweight;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.feedingtype = [self objectOrNilForKey:kJLUserFeedingtype fromDictionary:dict];
            self.hashypertension = [self objectOrNilForKey:kJLUserHashypertension fromDictionary:dict];
            self.diseasescreening = [self objectOrNilForKey:kJLUserDiseasescreening fromDictionary:dict];
            self.submitpwd = [self objectOrNilForKey:kJLUserSubmitpwd fromDictionary:dict];
            self.hasdiabetes = [self objectOrNilForKey:kJLUserHasdiabetes fromDictionary:dict];
            self.hasanemia = [self objectOrNilForKey:kJLUserHasanemia fromDictionary:dict];
            self.bornreport = [self objectOrNilForKey:kJLUserBornreport fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kJLUserSex fromDictionary:dict];
//            self.agreementtype = [self objectOrNilForKey:kJLUserAgreementtype fromDictionary:dict];
            self.nativeplace = [self objectOrNilForKey:kJLUserNativeplace fromDictionary:dict];
            self.isstop = [self objectOrNilForKey:kJLUserIsstop fromDictionary:dict];
            self.borntype = [self objectOrNilForKey:kJLUserBorntype fromDictionary:dict];
            self.carerphone = [self objectOrNilForKey:kJLUserCarerphone fromDictionary:dict];
            self.loginpwd = [self objectOrNilForKey:kJLUserLoginpwd fromDictionary:dict];
            self.mumage = [self objectOrNilForKey:kJLUserMumage fromDictionary:dict];
            self.mumphone = [self objectOrNilForKey:kJLUserMumphone fromDictionary:dict];
            self.bornplace = [self objectOrNilForKey:kJLUserBornplace fromDictionary:dict];
            self.dadphone = [self objectOrNilForKey:kJLUserDadphone fromDictionary:dict];
            self.bornheight = [self objectOrNilForKey:kJLUserBornheight fromDictionary:dict];
            self.nationality = [self objectOrNilForKey:kJLUserNationality fromDictionary:dict];
            self.parity = [self objectOrNilForKey:kJLUserParity fromDictionary:dict];
            self.mumheight = [self objectOrNilForKey:kJLUserMumheight fromDictionary:dict];
            self.mumemail = [self objectOrNilForKey:kJLUserMumemail fromDictionary:dict];
            self.enterreportversion = [self objectOrNilForKey:kJLUserEnterreportversion fromDictionary:dict];
            self.dadage = [self objectOrNilForKey:kJLUserDadage fromDictionary:dict];
            self.bcusedcount = [self objectOrNilForKey:kJLUserBcusedcount fromDictionary:dict];
            self.dademail = [self objectOrNilForKey:kJLUserDademail fromDictionary:dict];
            self.linkmansex = [self objectOrNilForKey:kJLUserLinkmansex fromDictionary:dict];
//            self.agreementlimit = [self objectOrNilForKey:kJLUserAgreementlimit fromDictionary:dict];
            self.dadeducation = [self objectOrNilForKey:kJLUserDadeducation fromDictionary:dict];
            self.otherdesc = [self objectOrNilForKey:kJLUserOtherdesc fromDictionary:dict];
            self.bctotalcount = [self objectOrNilForKey:kJLUserBctotalcount fromDictionary:dict];
            self.carersex = [self objectOrNilForKey:kJLUserCarersex fromDictionary:dict];
            self.hasicp = [self objectOrNilForKey:kJLUserHasicp fromDictionary:dict];
            self.roleid = [self objectOrNilForKey:kJLUserRoleid fromDictionary:dict];
            self.deliverymethods = [self objectOrNilForKey:kJLUserDeliverymethods fromDictionary:dict];
            self.mumweight = [self objectOrNilForKey:kJLUserMumweight fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kJLUserHospitalid fromDictionary:dict];
            self.salontotalcount = [self objectOrNilForKey:kJLUserSalontotalcount fromDictionary:dict];
            self.borntime = [self objectOrNilForKey:kJLUserBorntime fromDictionary:dict];
            self.agreement = [self objectOrNilForKey:kJLUserAgreement fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kJLUserUserid fromDictionary:dict];
            self.carer = [self objectOrNilForKey:kJLUserCarer fromDictionary:dict];
            self.dadname = [self objectOrNilForKey:kJLUserDadname fromDictionary:dict];
            self.bornweight = [self objectOrNilForKey:kJLUserBornweight fromDictionary:dict];
            self.treatusedcount = [self objectOrNilForKey:kJLUserTreatusedcount fromDictionary:dict];
            self.careeducation = [self objectOrNilForKey:kJLUserCareeducation fromDictionary:dict];
            self.hasotherdisease = [self objectOrNilForKey:kJLUserHasotherdisease fromDictionary:dict];
//            self.agreementstartage = [self objectOrNilForKey:kJLUserAgreementstartage fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kJLUserTruename fromDictionary:dict];
            self.carername = [self objectOrNilForKey:kJLUserCarername fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kJLUserBirthday fromDictionary:dict];
//            self.agreementstart = [self objectOrNilForKey:kJLUserAgreementstart fromDictionary:dict];
            self.mumbearage = [self objectOrNilForKey:kJLUserMumbearage fromDictionary:dict];
            self.carenativeplace = [self objectOrNilForKey:kJLUserCarenativeplace fromDictionary:dict];
            self.hasfirstheart = [self objectOrNilForKey:kJLUserHasfirstheart fromDictionary:dict];
            self.accountmobile = [self objectOrNilForKey:kJLUserAccountmobile fromDictionary:dict];
            self.dadheight = [self objectOrNilForKey:kJLUserDadheight fromDictionary:dict];
            self.linkmanemail = [self objectOrNilForKey:kJLUserLinkmanemail fromDictionary:dict];
            self.filecode = [self objectOrNilForKey:kJLUserFilecode fromDictionary:dict];
            self.linkman = [self objectOrNilForKey:kJLUserLinkman fromDictionary:dict];
            self.enterreport = [self objectOrNilForKey:kJLUserEnterreport fromDictionary:dict];
            self.mumeducation = [self objectOrNilForKey:kJLUserMumeducation fromDictionary:dict];
            self.agreementversion = [self objectOrNilForKey:kJLUserAgreementversion fromDictionary:dict];
            self.treattotalcount = [self objectOrNilForKey:kJLUserTreattotalcount fromDictionary:dict];
            self.salonusedcount = [self objectOrNilForKey:kJLUserSalonusedcount fromDictionary:dict];
            self.accountemail = [self objectOrNilForKey:kJLUserAccountemail fromDictionary:dict];
            self.mumname = [self objectOrNilForKey:kJLUserMumname fromDictionary:dict];
            self.nation = [self objectOrNilForKey:kJLUserNation fromDictionary:dict];
            self.headimg = [self objectOrNilForKey:kJLUserHeadimg fromDictionary:dict];
            self.dadweight = [self objectOrNilForKey:kJLUserDadweight fromDictionary:dict];
            self.linkmanname = [self objectOrNilForKey:kJLUserLinkmanname fromDictionary:dict];
            self.linkmanmobile = [self objectOrNilForKey:kJLUserLinkmanmobile fromDictionary:dict];
            self.emergencyphone = [self objectOrNilForKey:kJLUserEmergencyphone fromDictionary:dict];
            self.bornreportversion = [self objectOrNilForKey:kJLUserBornreportversion fromDictionary:dict];
            self.hascold = [self objectOrNilForKey:kJLUserHascold fromDictionary:dict];
            self.pregnancy = [self objectOrNilForKey:kJLUserPregnancy fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kJLUserDoctorid fromDictionary:dict];
            self.gravidity = [self objectOrNilForKey:kJLUserGravidity fromDictionary:dict];
            self.headimgversion = [self objectOrNilForKey:kJLUserHeadimgversion fromDictionary:dict];
            self.accountname = [self objectOrNilForKey:kJLUserAccountname fromDictionary:dict];
            self.haslowweight = [self objectOrNilForKey:kJLUserHaslowweight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feedingtype forKey:kJLUserFeedingtype];
    [mutableDict setValue:self.hashypertension forKey:kJLUserHashypertension];
    [mutableDict setValue:self.diseasescreening forKey:kJLUserDiseasescreening];
    [mutableDict setValue:self.submitpwd forKey:kJLUserSubmitpwd];
    [mutableDict setValue:self.hasdiabetes forKey:kJLUserHasdiabetes];
    [mutableDict setValue:self.hasanemia forKey:kJLUserHasanemia];
    [mutableDict setValue:self.bornreport forKey:kJLUserBornreport];
    [mutableDict setValue:self.sex forKey:kJLUserSex];
//    [mutableDict setValue:self.agreementtype forKey:kJLUserAgreementtype];
    [mutableDict setValue:self.nativeplace forKey:kJLUserNativeplace];
    [mutableDict setValue:self.isstop forKey:kJLUserIsstop];
    [mutableDict setValue:self.borntype forKey:kJLUserBorntype];
    [mutableDict setValue:self.carerphone forKey:kJLUserCarerphone];
    [mutableDict setValue:self.loginpwd forKey:kJLUserLoginpwd];
    [mutableDict setValue:self.mumage forKey:kJLUserMumage];
    [mutableDict setValue:self.mumphone forKey:kJLUserMumphone];
    [mutableDict setValue:self.bornplace forKey:kJLUserBornplace];
    [mutableDict setValue:self.dadphone forKey:kJLUserDadphone];
    [mutableDict setValue:self.bornheight forKey:kJLUserBornheight];
    [mutableDict setValue:self.nationality forKey:kJLUserNationality];
    [mutableDict setValue:self.parity forKey:kJLUserParity];
    [mutableDict setValue:self.mumheight forKey:kJLUserMumheight];
    [mutableDict setValue:self.mumemail forKey:kJLUserMumemail];
    [mutableDict setValue:self.enterreportversion forKey:kJLUserEnterreportversion];
    [mutableDict setValue:self.dadage forKey:kJLUserDadage];
    [mutableDict setValue:self.bcusedcount forKey:kJLUserBcusedcount];
    [mutableDict setValue:self.dademail forKey:kJLUserDademail];
    [mutableDict setValue:self.linkmansex forKey:kJLUserLinkmansex];
//    [mutableDict setValue:self.agreementlimit forKey:kJLUserAgreementlimit];
    [mutableDict setValue:self.dadeducation forKey:kJLUserDadeducation];
    [mutableDict setValue:self.otherdesc forKey:kJLUserOtherdesc];
    [mutableDict setValue:self.bctotalcount forKey:kJLUserBctotalcount];
    [mutableDict setValue:self.carersex forKey:kJLUserCarersex];
    [mutableDict setValue:self.hasicp forKey:kJLUserHasicp];
    [mutableDict setValue:self.roleid forKey:kJLUserRoleid];
    [mutableDict setValue:self.deliverymethods forKey:kJLUserDeliverymethods];
    [mutableDict setValue:self.mumweight forKey:kJLUserMumweight];
    [mutableDict setValue:self.hospitalid forKey:kJLUserHospitalid];
    [mutableDict setValue:self.salontotalcount forKey:kJLUserSalontotalcount];
    [mutableDict setValue:self.borntime forKey:kJLUserBorntime];
    [mutableDict setValue:self.agreement forKey:kJLUserAgreement];
    [mutableDict setValue:self.userid forKey:kJLUserUserid];
    [mutableDict setValue:self.carer forKey:kJLUserCarer];
    [mutableDict setValue:self.dadname forKey:kJLUserDadname];
    [mutableDict setValue:self.bornweight forKey:kJLUserBornweight];
    [mutableDict setValue:self.treatusedcount forKey:kJLUserTreatusedcount];
    [mutableDict setValue:self.careeducation forKey:kJLUserCareeducation];
    [mutableDict setValue:self.hasotherdisease forKey:kJLUserHasotherdisease];
//    [mutableDict setValue:self.agreementstartage forKey:kJLUserAgreementstartage];
    [mutableDict setValue:self.truename forKey:kJLUserTruename];
    [mutableDict setValue:self.carername forKey:kJLUserCarername];
    [mutableDict setValue:self.birthday forKey:kJLUserBirthday];
//    [mutableDict setValue:self.agreementstart forKey:kJLUserAgreementstart];
    [mutableDict setValue:self.mumbearage forKey:kJLUserMumbearage];
    [mutableDict setValue:self.carenativeplace forKey:kJLUserCarenativeplace];
    [mutableDict setValue:self.hasfirstheart forKey:kJLUserHasfirstheart];
    [mutableDict setValue:self.accountmobile forKey:kJLUserAccountmobile];
    [mutableDict setValue:self.dadheight forKey:kJLUserDadheight];
    [mutableDict setValue:self.linkmanemail forKey:kJLUserLinkmanemail];
    [mutableDict setValue:self.filecode forKey:kJLUserFilecode];
    [mutableDict setValue:self.linkman forKey:kJLUserLinkman];
    [mutableDict setValue:self.enterreport forKey:kJLUserEnterreport];
    [mutableDict setValue:self.mumeducation forKey:kJLUserMumeducation];
    [mutableDict setValue:self.agreementversion forKey:kJLUserAgreementversion];
    [mutableDict setValue:self.treattotalcount forKey:kJLUserTreattotalcount];
    [mutableDict setValue:self.salonusedcount forKey:kJLUserSalonusedcount];
    [mutableDict setValue:self.accountemail forKey:kJLUserAccountemail];
    [mutableDict setValue:self.mumname forKey:kJLUserMumname];
    [mutableDict setValue:self.nation forKey:kJLUserNation];
    [mutableDict setValue:self.headimg forKey:kJLUserHeadimg];
    [mutableDict setValue:self.dadweight forKey:kJLUserDadweight];
    [mutableDict setValue:self.linkmanname forKey:kJLUserLinkmanname];
    [mutableDict setValue:self.linkmanmobile forKey:kJLUserLinkmanmobile];
    [mutableDict setValue:self.emergencyphone forKey:kJLUserEmergencyphone];
    [mutableDict setValue:self.bornreportversion forKey:kJLUserBornreportversion];
    [mutableDict setValue:self.hascold forKey:kJLUserHascold];
    [mutableDict setValue:self.pregnancy forKey:kJLUserPregnancy];
    [mutableDict setValue:self.doctorid forKey:kJLUserDoctorid];
    [mutableDict setValue:self.gravidity forKey:kJLUserGravidity];
    [mutableDict setValue:self.headimgversion forKey:kJLUserHeadimgversion];
    [mutableDict setValue:self.accountname forKey:kJLUserAccountname];
    [mutableDict setValue:self.haslowweight forKey:kJLUserHaslowweight];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.feedingtype = [aDecoder decodeObjectForKey:kJLUserFeedingtype];
    self.hashypertension = [aDecoder decodeObjectForKey:kJLUserHashypertension];
    self.diseasescreening = [aDecoder decodeObjectForKey:kJLUserDiseasescreening];
    self.submitpwd = [aDecoder decodeObjectForKey:kJLUserSubmitpwd];
    self.hasdiabetes = [aDecoder decodeObjectForKey:kJLUserHasdiabetes];
    self.hasanemia = [aDecoder decodeObjectForKey:kJLUserHasanemia];
    self.bornreport = [aDecoder decodeObjectForKey:kJLUserBornreport];
    self.sex = [aDecoder decodeObjectForKey:kJLUserSex];
//    self.agreementtype = [aDecoder decodeObjectForKey:kJLUserAgreementtype];
    self.nativeplace = [aDecoder decodeObjectForKey:kJLUserNativeplace];
    self.isstop = [aDecoder decodeObjectForKey:kJLUserIsstop];
    self.borntype = [aDecoder decodeObjectForKey:kJLUserBorntype];
    self.carerphone = [aDecoder decodeObjectForKey:kJLUserCarerphone];
    self.loginpwd = [aDecoder decodeObjectForKey:kJLUserLoginpwd];
    self.mumage = [aDecoder decodeObjectForKey:kJLUserMumage];
    self.mumphone = [aDecoder decodeObjectForKey:kJLUserMumphone];
    self.bornplace = [aDecoder decodeObjectForKey:kJLUserBornplace];
    self.dadphone = [aDecoder decodeObjectForKey:kJLUserDadphone];
    self.bornheight = [aDecoder decodeObjectForKey:kJLUserBornheight];
    self.nationality = [aDecoder decodeObjectForKey:kJLUserNationality];
    self.parity = [aDecoder decodeObjectForKey:kJLUserParity];
    self.mumheight = [aDecoder decodeObjectForKey:kJLUserMumheight];
    self.mumemail = [aDecoder decodeObjectForKey:kJLUserMumemail];
    self.enterreportversion = [aDecoder decodeObjectForKey:kJLUserEnterreportversion];
    self.dadage = [aDecoder decodeObjectForKey:kJLUserDadage];
    self.bcusedcount = [aDecoder decodeObjectForKey:kJLUserBcusedcount];
    self.dademail = [aDecoder decodeObjectForKey:kJLUserDademail];
    self.linkmansex = [aDecoder decodeObjectForKey:kJLUserLinkmansex];
//    self.agreementlimit = [aDecoder decodeObjectForKey:kJLUserAgreementlimit];
    self.dadeducation = [aDecoder decodeObjectForKey:kJLUserDadeducation];
    self.otherdesc = [aDecoder decodeObjectForKey:kJLUserOtherdesc];
    self.bctotalcount = [aDecoder decodeObjectForKey:kJLUserBctotalcount];
    self.carersex = [aDecoder decodeObjectForKey:kJLUserCarersex];
    self.hasicp = [aDecoder decodeObjectForKey:kJLUserHasicp];
    self.roleid = [aDecoder decodeObjectForKey:kJLUserRoleid];
    self.deliverymethods = [aDecoder decodeObjectForKey:kJLUserDeliverymethods];
    self.mumweight = [aDecoder decodeObjectForKey:kJLUserMumweight];
    self.hospitalid = [aDecoder decodeObjectForKey:kJLUserHospitalid];
    self.salontotalcount = [aDecoder decodeObjectForKey:kJLUserSalontotalcount];
    self.borntime = [aDecoder decodeObjectForKey:kJLUserBorntime];
    self.agreement = [aDecoder decodeObjectForKey:kJLUserAgreement];
    self.userid = [aDecoder decodeObjectForKey:kJLUserUserid];
    self.carer = [aDecoder decodeObjectForKey:kJLUserCarer];
    self.dadname = [aDecoder decodeObjectForKey:kJLUserDadname];
    self.bornweight = [aDecoder decodeObjectForKey:kJLUserBornweight];
    self.treatusedcount = [aDecoder decodeObjectForKey:kJLUserTreatusedcount];
    self.careeducation = [aDecoder decodeObjectForKey:kJLUserCareeducation];
    self.hasotherdisease = [aDecoder decodeObjectForKey:kJLUserHasotherdisease];
//    self.agreementstartage = [aDecoder decodeObjectForKey:kJLUserAgreementstartage];
    self.truename = [aDecoder decodeObjectForKey:kJLUserTruename];
    self.carername = [aDecoder decodeObjectForKey:kJLUserCarername];
    self.birthday = [aDecoder decodeObjectForKey:kJLUserBirthday];
//    self.agreementstart = [aDecoder decodeObjectForKey:kJLUserAgreementstart];
    self.mumbearage = [aDecoder decodeObjectForKey:kJLUserMumbearage];
    self.carenativeplace = [aDecoder decodeObjectForKey:kJLUserCarenativeplace];
    self.hasfirstheart = [aDecoder decodeObjectForKey:kJLUserHasfirstheart];
    self.accountmobile = [aDecoder decodeObjectForKey:kJLUserAccountmobile];
    self.dadheight = [aDecoder decodeObjectForKey:kJLUserDadheight];
    self.linkmanemail = [aDecoder decodeObjectForKey:kJLUserLinkmanemail];
    self.filecode = [aDecoder decodeObjectForKey:kJLUserFilecode];
    self.linkman = [aDecoder decodeObjectForKey:kJLUserLinkman];
    self.enterreport = [aDecoder decodeObjectForKey:kJLUserEnterreport];
    self.mumeducation = [aDecoder decodeObjectForKey:kJLUserMumeducation];
    self.agreementversion = [aDecoder decodeObjectForKey:kJLUserAgreementversion];
    self.treattotalcount = [aDecoder decodeObjectForKey:kJLUserTreattotalcount];
    self.salonusedcount = [aDecoder decodeObjectForKey:kJLUserSalonusedcount];
    self.accountemail = [aDecoder decodeObjectForKey:kJLUserAccountemail];
    self.mumname = [aDecoder decodeObjectForKey:kJLUserMumname];
    self.nation = [aDecoder decodeObjectForKey:kJLUserNation];
    self.headimg = [aDecoder decodeObjectForKey:kJLUserHeadimg];
    self.dadweight = [aDecoder decodeObjectForKey:kJLUserDadweight];
    self.linkmanname = [aDecoder decodeObjectForKey:kJLUserLinkmanname];
    self.linkmanmobile = [aDecoder decodeObjectForKey:kJLUserLinkmanmobile];
    self.emergencyphone = [aDecoder decodeObjectForKey:kJLUserEmergencyphone];
    self.bornreportversion = [aDecoder decodeObjectForKey:kJLUserBornreportversion];
    self.hascold = [aDecoder decodeObjectForKey:kJLUserHascold];
    self.pregnancy = [aDecoder decodeObjectForKey:kJLUserPregnancy];
    self.doctorid = [aDecoder decodeObjectForKey:kJLUserDoctorid];
    self.gravidity = [aDecoder decodeObjectForKey:kJLUserGravidity];
    self.headimgversion = [aDecoder decodeObjectForKey:kJLUserHeadimgversion];
    self.accountname = [aDecoder decodeObjectForKey:kJLUserAccountname];
    self.haslowweight = [aDecoder decodeObjectForKey:kJLUserHaslowweight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feedingtype forKey:kJLUserFeedingtype];
    [aCoder encodeObject:_hashypertension forKey:kJLUserHashypertension];
    [aCoder encodeObject:_diseasescreening forKey:kJLUserDiseasescreening];
    [aCoder encodeObject:_submitpwd forKey:kJLUserSubmitpwd];
    [aCoder encodeObject:_hasdiabetes forKey:kJLUserHasdiabetes];
    [aCoder encodeObject:_hasanemia forKey:kJLUserHasanemia];
    [aCoder encodeObject:_bornreport forKey:kJLUserBornreport];
    [aCoder encodeObject:_sex forKey:kJLUserSex];
//    [aCoder encodeObject:_agreementtype forKey:kJLUserAgreementtype];
    [aCoder encodeObject:_nativeplace forKey:kJLUserNativeplace];
    [aCoder encodeObject:_isstop forKey:kJLUserIsstop];
    [aCoder encodeObject:_borntype forKey:kJLUserBorntype];
    [aCoder encodeObject:_carerphone forKey:kJLUserCarerphone];
    [aCoder encodeObject:_loginpwd forKey:kJLUserLoginpwd];
    [aCoder encodeObject:_mumage forKey:kJLUserMumage];
    [aCoder encodeObject:_mumphone forKey:kJLUserMumphone];
    [aCoder encodeObject:_bornplace forKey:kJLUserBornplace];
    [aCoder encodeObject:_dadphone forKey:kJLUserDadphone];
    [aCoder encodeObject:_bornheight forKey:kJLUserBornheight];
    [aCoder encodeObject:_nationality forKey:kJLUserNationality];
    [aCoder encodeObject:_parity forKey:kJLUserParity];
    [aCoder encodeObject:_mumheight forKey:kJLUserMumheight];
    [aCoder encodeObject:_mumemail forKey:kJLUserMumemail];
    [aCoder encodeObject:_enterreportversion forKey:kJLUserEnterreportversion];
    [aCoder encodeObject:_dadage forKey:kJLUserDadage];
    [aCoder encodeObject:_bcusedcount forKey:kJLUserBcusedcount];
    [aCoder encodeObject:_dademail forKey:kJLUserDademail];
    [aCoder encodeObject:_linkmansex forKey:kJLUserLinkmansex];
//    [aCoder encodeObject:_agreementlimit forKey:kJLUserAgreementlimit];
    [aCoder encodeObject:_dadeducation forKey:kJLUserDadeducation];
    [aCoder encodeObject:_otherdesc forKey:kJLUserOtherdesc];
    [aCoder encodeObject:_bctotalcount forKey:kJLUserBctotalcount];
    [aCoder encodeObject:_carersex forKey:kJLUserCarersex];
    [aCoder encodeObject:_hasicp forKey:kJLUserHasicp];
    [aCoder encodeObject:_roleid forKey:kJLUserRoleid];
    [aCoder encodeObject:_deliverymethods forKey:kJLUserDeliverymethods];
    [aCoder encodeObject:_mumweight forKey:kJLUserMumweight];
    [aCoder encodeObject:_hospitalid forKey:kJLUserHospitalid];
    [aCoder encodeObject:_salontotalcount forKey:kJLUserSalontotalcount];
    [aCoder encodeObject:_borntime forKey:kJLUserBorntime];
    [aCoder encodeObject:_agreement forKey:kJLUserAgreement];
    [aCoder encodeObject:_userid forKey:kJLUserUserid];
    [aCoder encodeObject:_carer forKey:kJLUserCarer];
    [aCoder encodeObject:_dadname forKey:kJLUserDadname];
    [aCoder encodeObject:_bornweight forKey:kJLUserBornweight];
    [aCoder encodeObject:_treatusedcount forKey:kJLUserTreatusedcount];
    [aCoder encodeObject:_careeducation forKey:kJLUserCareeducation];
    [aCoder encodeObject:_hasotherdisease forKey:kJLUserHasotherdisease];
//    [aCoder encodeObject:_agreementstartage forKey:kJLUserAgreementstartage];
    [aCoder encodeObject:_truename forKey:kJLUserTruename];
    [aCoder encodeObject:_carername forKey:kJLUserCarername];
    [aCoder encodeObject:_birthday forKey:kJLUserBirthday];
//    [aCoder encodeObject:_agreementstart forKey:kJLUserAgreementstart];
    [aCoder encodeObject:_mumbearage forKey:kJLUserMumbearage];
    [aCoder encodeObject:_carenativeplace forKey:kJLUserCarenativeplace];
    [aCoder encodeObject:_hasfirstheart forKey:kJLUserHasfirstheart];
    [aCoder encodeObject:_accountmobile forKey:kJLUserAccountmobile];
    [aCoder encodeObject:_dadheight forKey:kJLUserDadheight];
    [aCoder encodeObject:_linkmanemail forKey:kJLUserLinkmanemail];
    [aCoder encodeObject:_filecode forKey:kJLUserFilecode];
    [aCoder encodeObject:_linkman forKey:kJLUserLinkman];
    [aCoder encodeObject:_enterreport forKey:kJLUserEnterreport];
    [aCoder encodeObject:_mumeducation forKey:kJLUserMumeducation];
    [aCoder encodeObject:_agreementversion forKey:kJLUserAgreementversion];
    [aCoder encodeObject:_treattotalcount forKey:kJLUserTreattotalcount];
    [aCoder encodeObject:_salonusedcount forKey:kJLUserSalonusedcount];
    [aCoder encodeObject:_accountemail forKey:kJLUserAccountemail];
    [aCoder encodeObject:_mumname forKey:kJLUserMumname];
    [aCoder encodeObject:_nation forKey:kJLUserNation];
    [aCoder encodeObject:_headimg forKey:kJLUserHeadimg];
    [aCoder encodeObject:_dadweight forKey:kJLUserDadweight];
    [aCoder encodeObject:_linkmanname forKey:kJLUserLinkmanname];
    [aCoder encodeObject:_linkmanmobile forKey:kJLUserLinkmanmobile];
    [aCoder encodeObject:_emergencyphone forKey:kJLUserEmergencyphone];
    [aCoder encodeObject:_bornreportversion forKey:kJLUserBornreportversion];
    [aCoder encodeObject:_hascold forKey:kJLUserHascold];
    [aCoder encodeObject:_pregnancy forKey:kJLUserPregnancy];
    [aCoder encodeObject:_doctorid forKey:kJLUserDoctorid];
    [aCoder encodeObject:_gravidity forKey:kJLUserGravidity];
    [aCoder encodeObject:_headimgversion forKey:kJLUserHeadimgversion];
    [aCoder encodeObject:_accountname forKey:kJLUserAccountname];
    [aCoder encodeObject:_haslowweight forKey:kJLUserHaslowweight];
}

- (id)copyWithZone:(NSZone *)zone
{
    JLUser *copy = [[JLUser alloc] init];
    
    if (copy) {

        copy.feedingtype = [self.feedingtype copyWithZone:zone];
        copy.hashypertension = [self.hashypertension copyWithZone:zone];
        copy.diseasescreening = [self.diseasescreening copyWithZone:zone];
        copy.submitpwd = [self.submitpwd copyWithZone:zone];
        copy.hasdiabetes = [self.hasdiabetes copyWithZone:zone];
        copy.hasanemia = [self.hasanemia copyWithZone:zone];
        copy.bornreport = [self.bornreport copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
//        copy.agreementtype = [self.agreementtype copyWithZone:zone];
        copy.nativeplace = [self.nativeplace copyWithZone:zone];
        copy.isstop = [self.isstop copyWithZone:zone];
        copy.borntype = [self.borntype copyWithZone:zone];
        copy.carerphone = [self.carerphone copyWithZone:zone];
        copy.loginpwd = [self.loginpwd copyWithZone:zone];
        copy.mumage = [self.mumage copyWithZone:zone];
        copy.mumphone = [self.mumphone copyWithZone:zone];
        copy.bornplace = [self.bornplace copyWithZone:zone];
        copy.dadphone = [self.dadphone copyWithZone:zone];
        copy.bornheight = [self.bornheight copyWithZone:zone];
        copy.nationality = [self.nationality copyWithZone:zone];
        copy.parity = [self.parity copyWithZone:zone];
        copy.mumheight = [self.mumheight copyWithZone:zone];
        copy.mumemail = [self.mumemail copyWithZone:zone];
        copy.enterreportversion = [self.enterreportversion copyWithZone:zone];
        copy.dadage = [self.dadage copyWithZone:zone];
        copy.bcusedcount = [self.bcusedcount copyWithZone:zone];
        copy.dademail = [self.dademail copyWithZone:zone];
        copy.linkmansex = [self.linkmansex copyWithZone:zone];
//        copy.agreementlimit = [self.agreementlimit copyWithZone:zone];
        copy.dadeducation = [self.dadeducation copyWithZone:zone];
        copy.otherdesc = [self.otherdesc copyWithZone:zone];
        copy.bctotalcount = [self.bctotalcount copyWithZone:zone];
        copy.carersex = [self.carersex copyWithZone:zone];
        copy.hasicp = [self.hasicp copyWithZone:zone];
        copy.roleid = [self.roleid copyWithZone:zone];
        copy.deliverymethods = [self.deliverymethods copyWithZone:zone];
        copy.mumweight = [self.mumweight copyWithZone:zone];
        copy.hospitalid = [self.hospitalid copyWithZone:zone];
        copy.salontotalcount = [self.salontotalcount copyWithZone:zone];
        copy.borntime = [self.borntime copyWithZone:zone];
        copy.agreement = [self.agreement copyWithZone:zone];
        copy.userid = [self.userid copyWithZone:zone];
        copy.carer = [self.carer copyWithZone:zone];
        copy.dadname = [self.dadname copyWithZone:zone];
        copy.bornweight = [self.bornweight copyWithZone:zone];
        copy.treatusedcount = [self.treatusedcount copyWithZone:zone];
        copy.careeducation = [self.careeducation copyWithZone:zone];
        copy.hasotherdisease = [self.hasotherdisease copyWithZone:zone];
//        copy.agreementstartage = [self.agreementstartage copyWithZone:zone];
        copy.truename = [self.truename copyWithZone:zone];
        copy.carername = [self.carername copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
//        copy.agreementstart = [self.agreementstart copyWithZone:zone];
        copy.mumbearage = [self.mumbearage copyWithZone:zone];
        copy.carenativeplace = [self.carenativeplace copyWithZone:zone];
        copy.hasfirstheart = [self.hasfirstheart copyWithZone:zone];
        copy.accountmobile = [self.accountmobile copyWithZone:zone];
        copy.dadheight = [self.dadheight copyWithZone:zone];
        copy.linkmanemail = [self.linkmanemail copyWithZone:zone];
        copy.filecode = [self.filecode copyWithZone:zone];
        copy.linkman = [self.linkman copyWithZone:zone];
        copy.enterreport = [self.enterreport copyWithZone:zone];
        copy.mumeducation = [self.mumeducation copyWithZone:zone];
        copy.agreementversion = [self.agreementversion copyWithZone:zone];
        copy.treattotalcount = [self.treattotalcount copyWithZone:zone];
        copy.salonusedcount = [self.salonusedcount copyWithZone:zone];
        copy.accountemail = [self.accountemail copyWithZone:zone];
        copy.mumname = [self.mumname copyWithZone:zone];
        copy.nation = [self.nation copyWithZone:zone];
        copy.headimg = [self.headimg copyWithZone:zone];
        copy.dadweight = [self.dadweight copyWithZone:zone];
        copy.linkmanname = [self.linkmanname copyWithZone:zone];
        copy.linkmanmobile = [self.linkmanmobile copyWithZone:zone];
        copy.emergencyphone = [self.emergencyphone copyWithZone:zone];
        copy.bornreportversion = [self.bornreportversion copyWithZone:zone];
        copy.hascold = [self.hascold copyWithZone:zone];
        copy.pregnancy = [self.pregnancy copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
        copy.gravidity = [self.gravidity copyWithZone:zone];
        copy.headimgversion = [self.headimgversion copyWithZone:zone];
        copy.accountname = [self.accountname copyWithZone:zone];
        copy.haslowweight = [self.haslowweight copyWithZone:zone];
    }
    
    return copy;
}


@end
