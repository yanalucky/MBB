//
//  LoginUserUser.m
//
//  Created by  豆蒙萌 on 15/9/23
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import "LoginUserUser.h"


NSString *const kLoginUserUserFeedingtype = @"feedingtype";
NSString *const kLoginUserUserHashypertension = @"hashypertension";
NSString *const kLoginUserUserDiseasescreening = @"diseasescreening";
NSString *const kLoginUserUserSubmitpwd = @"submitpwd";
NSString *const kLoginUserUserHasdiabetes = @"hasdiabetes";
NSString *const kLoginUserUserHasanemia = @"hasanemia";
NSString *const kLoginUserUserBornreport = @"bornreport";
NSString *const kLoginUserUserSex = @"sex";
//NSString *const kLoginUserUserAgreementtype = @"agreementtype";
NSString *const kLoginUserUserNativeplace = @"nativeplace";
NSString *const kLoginUserUserIsstop = @"isstop";
NSString *const kLoginUserUserBorntype = @"borntype";
NSString *const kLoginUserUserCarerphone = @"carerphone";
NSString *const kLoginUserUserLoginpwd = @"loginpwd";
NSString *const kLoginUserUserMumage = @"mumage";
NSString *const kLoginUserUserMumphone = @"mumphone";
NSString *const kLoginUserUserBornplace = @"bornplace";
NSString *const kLoginUserUserDadphone = @"dadphone";
NSString *const kLoginUserUserBornheight = @"bornheight";
NSString *const kLoginUserUserNationality = @"nationality";
NSString *const kLoginUserUserParity = @"parity";
NSString *const kLoginUserUserMumheight = @"mumheight";
NSString *const kLoginUserUserMumemail = @"mumemail";
NSString *const kLoginUserUserEnterreportversion = @"enterreportversion";
NSString *const kLoginUserUserDadage = @"dadage";
NSString *const kLoginUserUserBcusedcount = @"bcusedcount";
NSString *const kLoginUserUserDademail = @"dademail";
NSString *const kLoginUserUserLinkmansex = @"linkmansex";
//NSString *const kLoginUserUserAgreementlimit = @"agreementlimit";
NSString *const kLoginUserUserDadeducation = @"dadeducation";
NSString *const kLoginUserUserOtherdesc = @"otherdesc";
NSString *const kLoginUserUserBctotalcount = @"bctotalcount";
NSString *const kLoginUserUserCarersex = @"carersex";
NSString *const kLoginUserUserHasicp = @"hasicp";
NSString *const kLoginUserUserRoleid = @"roleid";
NSString *const kLoginUserUserDeliverymethods = @"deliverymethods";
NSString *const kLoginUserUserMumweight = @"mumweight";
NSString *const kLoginUserUserHospitalid = @"hospitalid";
NSString *const kLoginUserUserSalontotalcount = @"salontotalcount";
NSString *const kLoginUserUserAgreement = @"agreement";
NSString *const kLoginUserUserBorntime = @"borntime";
NSString *const kLoginUserUserUserid = @"userid";
NSString *const kLoginUserUserCarer = @"carer";
NSString *const kLoginUserUserDadname = @"dadname";
NSString *const kLoginUserUserBornweight = @"bornweight";
NSString *const kLoginUserUserTreatusedcount = @"treatusedcount";
NSString *const kLoginUserUserCareeducation = @"careeducation";
NSString *const kLoginUserUserHasotherdisease = @"hasotherdisease";
//NSString *const kLoginUserUserAgreementstartage = @"agreementstartage";
NSString *const kLoginUserUserTruename = @"truename";
NSString *const kLoginUserUserCarername = @"carername";
NSString *const kLoginUserUserBirthday = @"birthday";
//NSString *const kLoginUserUserAgreementstart = @"agreementstart";
NSString *const kLoginUserUserMumbearage = @"mumbearage";
NSString *const kLoginUserUserCarenativeplace = @"carenativeplace";
NSString *const kLoginUserUserLinkmanemail = @"linkmanemail";
NSString *const kLoginUserUserHasfirstheart = @"hasfirstheart";
NSString *const kLoginUserUserLinkman = @"linkman";
NSString *const kLoginUserUserFilecode = @"filecode";
NSString *const kLoginUserUserAccountmobile = @"accountmobile";
NSString *const kLoginUserUserDadheight = @"dadheight";
NSString *const kLoginUserUserAgreementversion = @"agreementversion";
NSString *const kLoginUserUserTreattotalcount = @"treattotalcount";
NSString *const kLoginUserUserMumeducation = @"mumeducation";
NSString *const kLoginUserUserHeadimg = @"headimg";
NSString *const kLoginUserUserPregnancy = @"pregnancy";
NSString *const kLoginUserUserAccountemail = @"accountemail";
NSString *const kLoginUserUserNation = @"nation";
NSString *const kLoginUserUserMumname = @"mumname";
NSString *const kLoginUserUserSalonusedcount = @"salonusedcount";
NSString *const kLoginUserUserEmergencyphone = @"emergencyphone";
NSString *const kLoginUserUserLinkmanmobile = @"linkmanmobile";
NSString *const kLoginUserUserLinkmanname = @"linkmanname";
NSString *const kLoginUserUserHascold = @"hascold";
NSString *const kLoginUserUserBornreportversion = @"bornreportversion";
NSString *const kLoginUserUserDadweight = @"dadweight";
NSString *const kLoginUserUserEnterreport = @"enterreport";
NSString *const kLoginUserUserGravidity = @"gravidity";
NSString *const kLoginUserUserDoctorid = @"doctorid";
NSString *const kLoginUserUserHeadimgversion = @"headimgversion";
NSString *const kLoginUserUserAccountname = @"accountname";
NSString *const kLoginUserUserHaslowweight = @"haslowweight";


@interface LoginUserUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUserUser

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
@synthesize agreement = _agreement;
@synthesize borntime = _borntime;
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
@synthesize linkmanemail = _linkmanemail;
@synthesize hasfirstheart = _hasfirstheart;
@synthesize linkman = _linkman;
@synthesize filecode = _filecode;
@synthesize accountmobile = _accountmobile;
@synthesize dadheight = _dadheight;
@synthesize agreementversion = _agreementversion;
@synthesize treattotalcount = _treattotalcount;
@synthesize mumeducation = _mumeducation;
@synthesize headimg = _headimg;
@synthesize pregnancy = _pregnancy;
@synthesize accountemail = _accountemail;
@synthesize nation = _nation;
@synthesize mumname = _mumname;
@synthesize salonusedcount = _salonusedcount;
@synthesize emergencyphone = _emergencyphone;
@synthesize linkmanmobile = _linkmanmobile;
@synthesize linkmanname = _linkmanname;
@synthesize hascold = _hascold;
@synthesize bornreportversion = _bornreportversion;
@synthesize dadweight = _dadweight;
@synthesize enterreport = _enterreport;
@synthesize gravidity = _gravidity;
@synthesize doctorid = _doctorid;
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
            self.feedingtype = [self objectOrNilForKey:kLoginUserUserFeedingtype fromDictionary:dict];
            self.hashypertension = [self objectOrNilForKey:kLoginUserUserHashypertension fromDictionary:dict];
            self.diseasescreening = [self objectOrNilForKey:kLoginUserUserDiseasescreening fromDictionary:dict];
            self.submitpwd = [self objectOrNilForKey:kLoginUserUserSubmitpwd fromDictionary:dict];
            self.hasdiabetes = [self objectOrNilForKey:kLoginUserUserHasdiabetes fromDictionary:dict];
            self.hasanemia = [self objectOrNilForKey:kLoginUserUserHasanemia fromDictionary:dict];
            self.bornreport = [self objectOrNilForKey:kLoginUserUserBornreport fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kLoginUserUserSex fromDictionary:dict];
//            self.agreementtype = [self objectOrNilForKey:kLoginUserUserAgreementtype fromDictionary:dict];
            self.nativeplace = [self objectOrNilForKey:kLoginUserUserNativeplace fromDictionary:dict];
            self.isstop = [self objectOrNilForKey:kLoginUserUserIsstop fromDictionary:dict];
            self.borntype = [self objectOrNilForKey:kLoginUserUserBorntype fromDictionary:dict];
            self.carerphone = [self objectOrNilForKey:kLoginUserUserCarerphone fromDictionary:dict];
            self.loginpwd = [self objectOrNilForKey:kLoginUserUserLoginpwd fromDictionary:dict];
            self.mumage = [self objectOrNilForKey:kLoginUserUserMumage fromDictionary:dict];
            self.mumphone = [self objectOrNilForKey:kLoginUserUserMumphone fromDictionary:dict];
            self.bornplace = [self objectOrNilForKey:kLoginUserUserBornplace fromDictionary:dict];
            self.dadphone = [self objectOrNilForKey:kLoginUserUserDadphone fromDictionary:dict];
            self.bornheight = [self objectOrNilForKey:kLoginUserUserBornheight fromDictionary:dict];
            self.nationality = [self objectOrNilForKey:kLoginUserUserNationality fromDictionary:dict];
            self.parity = [self objectOrNilForKey:kLoginUserUserParity fromDictionary:dict];
            self.mumheight = [self objectOrNilForKey:kLoginUserUserMumheight fromDictionary:dict];
            self.mumemail = [self objectOrNilForKey:kLoginUserUserMumemail fromDictionary:dict];
            self.enterreportversion = [self objectOrNilForKey:kLoginUserUserEnterreportversion fromDictionary:dict];
            self.dadage = [self objectOrNilForKey:kLoginUserUserDadage fromDictionary:dict];
            self.bcusedcount = [self objectOrNilForKey:kLoginUserUserBcusedcount fromDictionary:dict];
            self.dademail = [self objectOrNilForKey:kLoginUserUserDademail fromDictionary:dict];
            self.linkmansex = [self objectOrNilForKey:kLoginUserUserLinkmansex fromDictionary:dict];
//            self.agreementlimit = [self objectOrNilForKey:kLoginUserUserAgreementlimit fromDictionary:dict];
            self.dadeducation = [self objectOrNilForKey:kLoginUserUserDadeducation fromDictionary:dict];
            self.otherdesc = [self objectOrNilForKey:kLoginUserUserOtherdesc fromDictionary:dict];
            self.bctotalcount = [self objectOrNilForKey:kLoginUserUserBctotalcount fromDictionary:dict];
            self.carersex = [self objectOrNilForKey:kLoginUserUserCarersex fromDictionary:dict];
            self.hasicp = [self objectOrNilForKey:kLoginUserUserHasicp fromDictionary:dict];
            self.roleid = [self objectOrNilForKey:kLoginUserUserRoleid fromDictionary:dict];
            self.deliverymethods = [self objectOrNilForKey:kLoginUserUserDeliverymethods fromDictionary:dict];
            self.mumweight = [self objectOrNilForKey:kLoginUserUserMumweight fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kLoginUserUserHospitalid fromDictionary:dict];
            self.salontotalcount = [self objectOrNilForKey:kLoginUserUserSalontotalcount fromDictionary:dict];
            self.agreement = [self objectOrNilForKey:kLoginUserUserAgreement fromDictionary:dict];
            self.borntime = [self objectOrNilForKey:kLoginUserUserBorntime fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserUserUserid fromDictionary:dict];
            self.carer = [self objectOrNilForKey:kLoginUserUserCarer fromDictionary:dict];
            self.dadname = [self objectOrNilForKey:kLoginUserUserDadname fromDictionary:dict];
            self.bornweight = [self objectOrNilForKey:kLoginUserUserBornweight fromDictionary:dict];
            self.treatusedcount = [self objectOrNilForKey:kLoginUserUserTreatusedcount fromDictionary:dict];
            self.careeducation = [self objectOrNilForKey:kLoginUserUserCareeducation fromDictionary:dict];
            self.hasotherdisease = [self objectOrNilForKey:kLoginUserUserHasotherdisease fromDictionary:dict];
//            self.agreementstartage = [self objectOrNilForKey:kLoginUserUserAgreementstartage fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kLoginUserUserTruename fromDictionary:dict];
            self.carername = [self objectOrNilForKey:kLoginUserUserCarername fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kLoginUserUserBirthday fromDictionary:dict];
//            self.agreementstart = [self objectOrNilForKey:kLoginUserUserAgreementstart fromDictionary:dict];
            self.mumbearage = [self objectOrNilForKey:kLoginUserUserMumbearage fromDictionary:dict];
            self.carenativeplace = [self objectOrNilForKey:kLoginUserUserCarenativeplace fromDictionary:dict];
            self.linkmanemail = [self objectOrNilForKey:kLoginUserUserLinkmanemail fromDictionary:dict];
            self.hasfirstheart = [self objectOrNilForKey:kLoginUserUserHasfirstheart fromDictionary:dict];
            self.linkman = [self objectOrNilForKey:kLoginUserUserLinkman fromDictionary:dict];
            self.filecode = [self objectOrNilForKey:kLoginUserUserFilecode fromDictionary:dict];
            self.accountmobile = [self objectOrNilForKey:kLoginUserUserAccountmobile fromDictionary:dict];
            self.dadheight = [self objectOrNilForKey:kLoginUserUserDadheight fromDictionary:dict];
            self.agreementversion = [self objectOrNilForKey:kLoginUserUserAgreementversion fromDictionary:dict];
            self.treattotalcount = [self objectOrNilForKey:kLoginUserUserTreattotalcount fromDictionary:dict];
            self.mumeducation = [self objectOrNilForKey:kLoginUserUserMumeducation fromDictionary:dict];
            self.headimg = [self objectOrNilForKey:kLoginUserUserHeadimg fromDictionary:dict];
            self.pregnancy = [self objectOrNilForKey:kLoginUserUserPregnancy fromDictionary:dict];
            self.accountemail = [self objectOrNilForKey:kLoginUserUserAccountemail fromDictionary:dict];
            self.nation = [self objectOrNilForKey:kLoginUserUserNation fromDictionary:dict];
            self.mumname = [self objectOrNilForKey:kLoginUserUserMumname fromDictionary:dict];
            self.salonusedcount = [self objectOrNilForKey:kLoginUserUserSalonusedcount fromDictionary:dict];
            self.emergencyphone = [self objectOrNilForKey:kLoginUserUserEmergencyphone fromDictionary:dict];
            self.linkmanmobile = [self objectOrNilForKey:kLoginUserUserLinkmanmobile fromDictionary:dict];
            self.linkmanname = [self objectOrNilForKey:kLoginUserUserLinkmanname fromDictionary:dict];
            self.hascold = [self objectOrNilForKey:kLoginUserUserHascold fromDictionary:dict];
            self.bornreportversion = [self objectOrNilForKey:kLoginUserUserBornreportversion fromDictionary:dict];
            self.dadweight = [self objectOrNilForKey:kLoginUserUserDadweight fromDictionary:dict];
            self.enterreport = [self objectOrNilForKey:kLoginUserUserEnterreport fromDictionary:dict];
            self.gravidity = [self objectOrNilForKey:kLoginUserUserGravidity fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kLoginUserUserDoctorid fromDictionary:dict];
            self.headimgversion = [self objectOrNilForKey:kLoginUserUserHeadimgversion fromDictionary:dict];
            self.accountname = [self objectOrNilForKey:kLoginUserUserAccountname fromDictionary:dict];
            self.haslowweight = [self objectOrNilForKey:kLoginUserUserHaslowweight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feedingtype forKey:kLoginUserUserFeedingtype];
    [mutableDict setValue:self.hashypertension forKey:kLoginUserUserHashypertension];
    [mutableDict setValue:self.diseasescreening forKey:kLoginUserUserDiseasescreening];
    [mutableDict setValue:self.submitpwd forKey:kLoginUserUserSubmitpwd];
    [mutableDict setValue:self.hasdiabetes forKey:kLoginUserUserHasdiabetes];
    [mutableDict setValue:self.hasanemia forKey:kLoginUserUserHasanemia];
    [mutableDict setValue:self.bornreport forKey:kLoginUserUserBornreport];
    [mutableDict setValue:self.sex forKey:kLoginUserUserSex];
//    [mutableDict setValue:self.agreementtype forKey:kLoginUserUserAgreementtype];
    [mutableDict setValue:self.nativeplace forKey:kLoginUserUserNativeplace];
    [mutableDict setValue:self.isstop forKey:kLoginUserUserIsstop];
    [mutableDict setValue:self.borntype forKey:kLoginUserUserBorntype];
    [mutableDict setValue:self.carerphone forKey:kLoginUserUserCarerphone];
    [mutableDict setValue:self.loginpwd forKey:kLoginUserUserLoginpwd];
    [mutableDict setValue:self.mumage forKey:kLoginUserUserMumage];
    [mutableDict setValue:self.mumphone forKey:kLoginUserUserMumphone];
    [mutableDict setValue:self.bornplace forKey:kLoginUserUserBornplace];
    [mutableDict setValue:self.dadphone forKey:kLoginUserUserDadphone];
    [mutableDict setValue:self.bornheight forKey:kLoginUserUserBornheight];
    [mutableDict setValue:self.nationality forKey:kLoginUserUserNationality];
    [mutableDict setValue:self.parity forKey:kLoginUserUserParity];
    [mutableDict setValue:self.mumheight forKey:kLoginUserUserMumheight];
    [mutableDict setValue:self.mumemail forKey:kLoginUserUserMumemail];
    [mutableDict setValue:self.enterreportversion forKey:kLoginUserUserEnterreportversion];
    [mutableDict setValue:self.dadage forKey:kLoginUserUserDadage];
    [mutableDict setValue:self.bcusedcount forKey:kLoginUserUserBcusedcount];
    [mutableDict setValue:self.dademail forKey:kLoginUserUserDademail];
    [mutableDict setValue:self.linkmansex forKey:kLoginUserUserLinkmansex];
//    [mutableDict setValue:self.agreementlimit forKey:kLoginUserUserAgreementlimit];
    [mutableDict setValue:self.dadeducation forKey:kLoginUserUserDadeducation];
    [mutableDict setValue:self.otherdesc forKey:kLoginUserUserOtherdesc];
    [mutableDict setValue:self.bctotalcount forKey:kLoginUserUserBctotalcount];
    [mutableDict setValue:self.carersex forKey:kLoginUserUserCarersex];
    [mutableDict setValue:self.hasicp forKey:kLoginUserUserHasicp];
    [mutableDict setValue:self.roleid forKey:kLoginUserUserRoleid];
    [mutableDict setValue:self.deliverymethods forKey:kLoginUserUserDeliverymethods];
    [mutableDict setValue:self.mumweight forKey:kLoginUserUserMumweight];
    [mutableDict setValue:self.hospitalid forKey:kLoginUserUserHospitalid];
    [mutableDict setValue:self.salontotalcount forKey:kLoginUserUserSalontotalcount];
    [mutableDict setValue:self.agreement forKey:kLoginUserUserAgreement];
    [mutableDict setValue:self.borntime forKey:kLoginUserUserBorntime];
    [mutableDict setValue:self.userid forKey:kLoginUserUserUserid];
    [mutableDict setValue:self.carer forKey:kLoginUserUserCarer];
    [mutableDict setValue:self.dadname forKey:kLoginUserUserDadname];
    [mutableDict setValue:self.bornweight forKey:kLoginUserUserBornweight];
    [mutableDict setValue:self.treatusedcount forKey:kLoginUserUserTreatusedcount];
    [mutableDict setValue:self.careeducation forKey:kLoginUserUserCareeducation];
    [mutableDict setValue:self.hasotherdisease forKey:kLoginUserUserHasotherdisease];
//    [mutableDict setValue:self.agreementstartage forKey:kLoginUserUserAgreementstartage];
    [mutableDict setValue:self.truename forKey:kLoginUserUserTruename];
    [mutableDict setValue:self.carername forKey:kLoginUserUserCarername];
    [mutableDict setValue:self.birthday forKey:kLoginUserUserBirthday];
//    [mutableDict setValue:self.agreementstart forKey:kLoginUserUserAgreementstart];
    [mutableDict setValue:self.mumbearage forKey:kLoginUserUserMumbearage];
    [mutableDict setValue:self.carenativeplace forKey:kLoginUserUserCarenativeplace];
    [mutableDict setValue:self.linkmanemail forKey:kLoginUserUserLinkmanemail];
    [mutableDict setValue:self.hasfirstheart forKey:kLoginUserUserHasfirstheart];
    [mutableDict setValue:self.linkman forKey:kLoginUserUserLinkman];
    [mutableDict setValue:self.filecode forKey:kLoginUserUserFilecode];
    [mutableDict setValue:self.accountmobile forKey:kLoginUserUserAccountmobile];
    [mutableDict setValue:self.dadheight forKey:kLoginUserUserDadheight];
    [mutableDict setValue:self.agreementversion forKey:kLoginUserUserAgreementversion];
    [mutableDict setValue:self.treattotalcount forKey:kLoginUserUserTreattotalcount];
    [mutableDict setValue:self.mumeducation forKey:kLoginUserUserMumeducation];
    [mutableDict setValue:self.headimg forKey:kLoginUserUserHeadimg];
    [mutableDict setValue:self.pregnancy forKey:kLoginUserUserPregnancy];
    [mutableDict setValue:self.accountemail forKey:kLoginUserUserAccountemail];
    [mutableDict setValue:self.nation forKey:kLoginUserUserNation];
    [mutableDict setValue:self.mumname forKey:kLoginUserUserMumname];
    [mutableDict setValue:self.salonusedcount forKey:kLoginUserUserSalonusedcount];
    [mutableDict setValue:self.emergencyphone forKey:kLoginUserUserEmergencyphone];
    [mutableDict setValue:self.linkmanmobile forKey:kLoginUserUserLinkmanmobile];
    [mutableDict setValue:self.linkmanname forKey:kLoginUserUserLinkmanname];
    [mutableDict setValue:self.hascold forKey:kLoginUserUserHascold];
    [mutableDict setValue:self.bornreportversion forKey:kLoginUserUserBornreportversion];
    [mutableDict setValue:self.dadweight forKey:kLoginUserUserDadweight];
    [mutableDict setValue:self.enterreport forKey:kLoginUserUserEnterreport];
    [mutableDict setValue:self.gravidity forKey:kLoginUserUserGravidity];
    [mutableDict setValue:self.doctorid forKey:kLoginUserUserDoctorid];
    [mutableDict setValue:self.headimgversion forKey:kLoginUserUserHeadimgversion];
    [mutableDict setValue:self.accountname forKey:kLoginUserUserAccountname];
    [mutableDict setValue:self.haslowweight forKey:kLoginUserUserHaslowweight];

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

    self.feedingtype = [aDecoder decodeObjectForKey:kLoginUserUserFeedingtype];
    self.hashypertension = [aDecoder decodeObjectForKey:kLoginUserUserHashypertension];
    self.diseasescreening = [aDecoder decodeObjectForKey:kLoginUserUserDiseasescreening];
    self.submitpwd = [aDecoder decodeObjectForKey:kLoginUserUserSubmitpwd];
    self.hasdiabetes = [aDecoder decodeObjectForKey:kLoginUserUserHasdiabetes];
    self.hasanemia = [aDecoder decodeObjectForKey:kLoginUserUserHasanemia];
    self.bornreport = [aDecoder decodeObjectForKey:kLoginUserUserBornreport];
    self.sex = [aDecoder decodeObjectForKey:kLoginUserUserSex];
//    self.agreementtype = [aDecoder decodeObjectForKey:kLoginUserUserAgreementtype];
    self.nativeplace = [aDecoder decodeObjectForKey:kLoginUserUserNativeplace];
    self.isstop = [aDecoder decodeObjectForKey:kLoginUserUserIsstop];
    self.borntype = [aDecoder decodeObjectForKey:kLoginUserUserBorntype];
    self.carerphone = [aDecoder decodeObjectForKey:kLoginUserUserCarerphone];
    self.loginpwd = [aDecoder decodeObjectForKey:kLoginUserUserLoginpwd];
    self.mumage = [aDecoder decodeObjectForKey:kLoginUserUserMumage];
    self.mumphone = [aDecoder decodeObjectForKey:kLoginUserUserMumphone];
    self.bornplace = [aDecoder decodeObjectForKey:kLoginUserUserBornplace];
    self.dadphone = [aDecoder decodeObjectForKey:kLoginUserUserDadphone];
    self.bornheight = [aDecoder decodeObjectForKey:kLoginUserUserBornheight];
    self.nationality = [aDecoder decodeObjectForKey:kLoginUserUserNationality];
    self.parity = [aDecoder decodeObjectForKey:kLoginUserUserParity];
    self.mumheight = [aDecoder decodeObjectForKey:kLoginUserUserMumheight];
    self.mumemail = [aDecoder decodeObjectForKey:kLoginUserUserMumemail];
    self.enterreportversion = [aDecoder decodeObjectForKey:kLoginUserUserEnterreportversion];
    self.dadage = [aDecoder decodeObjectForKey:kLoginUserUserDadage];
    self.bcusedcount = [aDecoder decodeObjectForKey:kLoginUserUserBcusedcount];
    self.dademail = [aDecoder decodeObjectForKey:kLoginUserUserDademail];
    self.linkmansex = [aDecoder decodeObjectForKey:kLoginUserUserLinkmansex];
//    self.agreementlimit = [aDecoder decodeObjectForKey:kLoginUserUserAgreementlimit];
    self.dadeducation = [aDecoder decodeObjectForKey:kLoginUserUserDadeducation];
    self.otherdesc = [aDecoder decodeObjectForKey:kLoginUserUserOtherdesc];
    self.bctotalcount = [aDecoder decodeObjectForKey:kLoginUserUserBctotalcount];
    self.carersex = [aDecoder decodeObjectForKey:kLoginUserUserCarersex];
    self.hasicp = [aDecoder decodeObjectForKey:kLoginUserUserHasicp];
    self.roleid = [aDecoder decodeObjectForKey:kLoginUserUserRoleid];
    self.deliverymethods = [aDecoder decodeObjectForKey:kLoginUserUserDeliverymethods];
    self.mumweight = [aDecoder decodeObjectForKey:kLoginUserUserMumweight];
    self.hospitalid = [aDecoder decodeObjectForKey:kLoginUserUserHospitalid];
    self.salontotalcount = [aDecoder decodeObjectForKey:kLoginUserUserSalontotalcount];
    self.agreement = [aDecoder decodeObjectForKey:kLoginUserUserAgreement];
    self.borntime = [aDecoder decodeObjectForKey:kLoginUserUserBorntime];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserUserUserid];
    self.carer = [aDecoder decodeObjectForKey:kLoginUserUserCarer];
    self.dadname = [aDecoder decodeObjectForKey:kLoginUserUserDadname];
    self.bornweight = [aDecoder decodeObjectForKey:kLoginUserUserBornweight];
    self.treatusedcount = [aDecoder decodeObjectForKey:kLoginUserUserTreatusedcount];
    self.careeducation = [aDecoder decodeObjectForKey:kLoginUserUserCareeducation];
    self.hasotherdisease = [aDecoder decodeObjectForKey:kLoginUserUserHasotherdisease];
//    self.agreementstartage = [aDecoder decodeObjectForKey:kLoginUserUserAgreementstartage];
    self.truename = [aDecoder decodeObjectForKey:kLoginUserUserTruename];
    self.carername = [aDecoder decodeObjectForKey:kLoginUserUserCarername];
    self.birthday = [aDecoder decodeObjectForKey:kLoginUserUserBirthday];
//    self.agreementstart = [aDecoder decodeObjectForKey:kLoginUserUserAgreementstart];
    self.mumbearage = [aDecoder decodeObjectForKey:kLoginUserUserMumbearage];
    self.carenativeplace = [aDecoder decodeObjectForKey:kLoginUserUserCarenativeplace];
    self.linkmanemail = [aDecoder decodeObjectForKey:kLoginUserUserLinkmanemail];
    self.hasfirstheart = [aDecoder decodeObjectForKey:kLoginUserUserHasfirstheart];
    self.linkman = [aDecoder decodeObjectForKey:kLoginUserUserLinkman];
    self.filecode = [aDecoder decodeObjectForKey:kLoginUserUserFilecode];
    self.accountmobile = [aDecoder decodeObjectForKey:kLoginUserUserAccountmobile];
    self.dadheight = [aDecoder decodeObjectForKey:kLoginUserUserDadheight];
    self.agreementversion = [aDecoder decodeObjectForKey:kLoginUserUserAgreementversion];
    self.treattotalcount = [aDecoder decodeObjectForKey:kLoginUserUserTreattotalcount];
    self.mumeducation = [aDecoder decodeObjectForKey:kLoginUserUserMumeducation];
    self.headimg = [aDecoder decodeObjectForKey:kLoginUserUserHeadimg];
    self.pregnancy = [aDecoder decodeObjectForKey:kLoginUserUserPregnancy];
    self.accountemail = [aDecoder decodeObjectForKey:kLoginUserUserAccountemail];
    self.nation = [aDecoder decodeObjectForKey:kLoginUserUserNation];
    self.mumname = [aDecoder decodeObjectForKey:kLoginUserUserMumname];
    self.salonusedcount = [aDecoder decodeObjectForKey:kLoginUserUserSalonusedcount];
    self.emergencyphone = [aDecoder decodeObjectForKey:kLoginUserUserEmergencyphone];
    self.linkmanmobile = [aDecoder decodeObjectForKey:kLoginUserUserLinkmanmobile];
    self.linkmanname = [aDecoder decodeObjectForKey:kLoginUserUserLinkmanname];
    self.hascold = [aDecoder decodeObjectForKey:kLoginUserUserHascold];
    self.bornreportversion = [aDecoder decodeObjectForKey:kLoginUserUserBornreportversion];
    self.dadweight = [aDecoder decodeObjectForKey:kLoginUserUserDadweight];
    self.enterreport = [aDecoder decodeObjectForKey:kLoginUserUserEnterreport];
    self.gravidity = [aDecoder decodeObjectForKey:kLoginUserUserGravidity];
    self.doctorid = [aDecoder decodeObjectForKey:kLoginUserUserDoctorid];
    self.headimgversion = [aDecoder decodeObjectForKey:kLoginUserUserHeadimgversion];
    self.accountname = [aDecoder decodeObjectForKey:kLoginUserUserAccountname];
    self.haslowweight = [aDecoder decodeObjectForKey:kLoginUserUserHaslowweight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feedingtype forKey:kLoginUserUserFeedingtype];
    [aCoder encodeObject:_hashypertension forKey:kLoginUserUserHashypertension];
    [aCoder encodeObject:_diseasescreening forKey:kLoginUserUserDiseasescreening];
    [aCoder encodeObject:_submitpwd forKey:kLoginUserUserSubmitpwd];
    [aCoder encodeObject:_hasdiabetes forKey:kLoginUserUserHasdiabetes];
    [aCoder encodeObject:_hasanemia forKey:kLoginUserUserHasanemia];
    [aCoder encodeObject:_bornreport forKey:kLoginUserUserBornreport];
    [aCoder encodeObject:_sex forKey:kLoginUserUserSex];
//    [aCoder encodeObject:_agreementtype forKey:kLoginUserUserAgreementtype];
    [aCoder encodeObject:_nativeplace forKey:kLoginUserUserNativeplace];
    [aCoder encodeObject:_isstop forKey:kLoginUserUserIsstop];
    [aCoder encodeObject:_borntype forKey:kLoginUserUserBorntype];
    [aCoder encodeObject:_carerphone forKey:kLoginUserUserCarerphone];
    [aCoder encodeObject:_loginpwd forKey:kLoginUserUserLoginpwd];
    [aCoder encodeObject:_mumage forKey:kLoginUserUserMumage];
    [aCoder encodeObject:_mumphone forKey:kLoginUserUserMumphone];
    [aCoder encodeObject:_bornplace forKey:kLoginUserUserBornplace];
    [aCoder encodeObject:_dadphone forKey:kLoginUserUserDadphone];
    [aCoder encodeObject:_bornheight forKey:kLoginUserUserBornheight];
    [aCoder encodeObject:_nationality forKey:kLoginUserUserNationality];
    [aCoder encodeObject:_parity forKey:kLoginUserUserParity];
    [aCoder encodeObject:_mumheight forKey:kLoginUserUserMumheight];
    [aCoder encodeObject:_mumemail forKey:kLoginUserUserMumemail];
    [aCoder encodeObject:_enterreportversion forKey:kLoginUserUserEnterreportversion];
    [aCoder encodeObject:_dadage forKey:kLoginUserUserDadage];
    [aCoder encodeObject:_bcusedcount forKey:kLoginUserUserBcusedcount];
    [aCoder encodeObject:_dademail forKey:kLoginUserUserDademail];
    [aCoder encodeObject:_linkmansex forKey:kLoginUserUserLinkmansex];
//    [aCoder encodeObject:_agreementlimit forKey:kLoginUserUserAgreementlimit];
    [aCoder encodeObject:_dadeducation forKey:kLoginUserUserDadeducation];
    [aCoder encodeObject:_otherdesc forKey:kLoginUserUserOtherdesc];
    [aCoder encodeObject:_bctotalcount forKey:kLoginUserUserBctotalcount];
    [aCoder encodeObject:_carersex forKey:kLoginUserUserCarersex];
    [aCoder encodeObject:_hasicp forKey:kLoginUserUserHasicp];
    [aCoder encodeObject:_roleid forKey:kLoginUserUserRoleid];
    [aCoder encodeObject:_deliverymethods forKey:kLoginUserUserDeliverymethods];
    [aCoder encodeObject:_mumweight forKey:kLoginUserUserMumweight];
    [aCoder encodeObject:_hospitalid forKey:kLoginUserUserHospitalid];
    [aCoder encodeObject:_salontotalcount forKey:kLoginUserUserSalontotalcount];
    [aCoder encodeObject:_agreement forKey:kLoginUserUserAgreement];
    [aCoder encodeObject:_borntime forKey:kLoginUserUserBorntime];
    [aCoder encodeObject:_userid forKey:kLoginUserUserUserid];
    [aCoder encodeObject:_carer forKey:kLoginUserUserCarer];
    [aCoder encodeObject:_dadname forKey:kLoginUserUserDadname];
    [aCoder encodeObject:_bornweight forKey:kLoginUserUserBornweight];
    [aCoder encodeObject:_treatusedcount forKey:kLoginUserUserTreatusedcount];
    [aCoder encodeObject:_careeducation forKey:kLoginUserUserCareeducation];
    [aCoder encodeObject:_hasotherdisease forKey:kLoginUserUserHasotherdisease];
//    [aCoder encodeObject:_agreementstartage forKey:kLoginUserUserAgreementstartage];
    [aCoder encodeObject:_truename forKey:kLoginUserUserTruename];
    [aCoder encodeObject:_carername forKey:kLoginUserUserCarername];
    [aCoder encodeObject:_birthday forKey:kLoginUserUserBirthday];
//    [aCoder encodeObject:_agreementstart forKey:kLoginUserUserAgreementstart];
    [aCoder encodeObject:_mumbearage forKey:kLoginUserUserMumbearage];
    [aCoder encodeObject:_carenativeplace forKey:kLoginUserUserCarenativeplace];
    [aCoder encodeObject:_linkmanemail forKey:kLoginUserUserLinkmanemail];
    [aCoder encodeObject:_hasfirstheart forKey:kLoginUserUserHasfirstheart];
    [aCoder encodeObject:_linkman forKey:kLoginUserUserLinkman];
    [aCoder encodeObject:_filecode forKey:kLoginUserUserFilecode];
    [aCoder encodeObject:_accountmobile forKey:kLoginUserUserAccountmobile];
    [aCoder encodeObject:_dadheight forKey:kLoginUserUserDadheight];
    [aCoder encodeObject:_agreementversion forKey:kLoginUserUserAgreementversion];
    [aCoder encodeObject:_treattotalcount forKey:kLoginUserUserTreattotalcount];
    [aCoder encodeObject:_mumeducation forKey:kLoginUserUserMumeducation];
    [aCoder encodeObject:_headimg forKey:kLoginUserUserHeadimg];
    [aCoder encodeObject:_pregnancy forKey:kLoginUserUserPregnancy];
    [aCoder encodeObject:_accountemail forKey:kLoginUserUserAccountemail];
    [aCoder encodeObject:_nation forKey:kLoginUserUserNation];
    [aCoder encodeObject:_mumname forKey:kLoginUserUserMumname];
    [aCoder encodeObject:_salonusedcount forKey:kLoginUserUserSalonusedcount];
    [aCoder encodeObject:_emergencyphone forKey:kLoginUserUserEmergencyphone];
    [aCoder encodeObject:_linkmanmobile forKey:kLoginUserUserLinkmanmobile];
    [aCoder encodeObject:_linkmanname forKey:kLoginUserUserLinkmanname];
    [aCoder encodeObject:_hascold forKey:kLoginUserUserHascold];
    [aCoder encodeObject:_bornreportversion forKey:kLoginUserUserBornreportversion];
    [aCoder encodeObject:_dadweight forKey:kLoginUserUserDadweight];
    [aCoder encodeObject:_enterreport forKey:kLoginUserUserEnterreport];
    [aCoder encodeObject:_gravidity forKey:kLoginUserUserGravidity];
    [aCoder encodeObject:_doctorid forKey:kLoginUserUserDoctorid];
    [aCoder encodeObject:_headimgversion forKey:kLoginUserUserHeadimgversion];
    [aCoder encodeObject:_accountname forKey:kLoginUserUserAccountname];
    [aCoder encodeObject:_haslowweight forKey:kLoginUserUserHaslowweight];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUserUser *copy = [[LoginUserUser alloc] init];
    
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
        copy.agreement = [self.agreement copyWithZone:zone];
        copy.borntime = [self.borntime copyWithZone:zone];
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
        copy.linkmanemail = [self.linkmanemail copyWithZone:zone];
        copy.hasfirstheart = [self.hasfirstheart copyWithZone:zone];
        copy.linkman = [self.linkman copyWithZone:zone];
        copy.filecode = [self.filecode copyWithZone:zone];
        copy.accountmobile = [self.accountmobile copyWithZone:zone];
        copy.dadheight = [self.dadheight copyWithZone:zone];
        copy.agreementversion = [self.agreementversion copyWithZone:zone];
        copy.treattotalcount = [self.treattotalcount copyWithZone:zone];
        copy.mumeducation = [self.mumeducation copyWithZone:zone];
        copy.headimg = [self.headimg copyWithZone:zone];
        copy.pregnancy = [self.pregnancy copyWithZone:zone];
        copy.accountemail = [self.accountemail copyWithZone:zone];
        copy.nation = [self.nation copyWithZone:zone];
        copy.mumname = [self.mumname copyWithZone:zone];
        copy.salonusedcount = [self.salonusedcount copyWithZone:zone];
        copy.emergencyphone = [self.emergencyphone copyWithZone:zone];
        copy.linkmanmobile = [self.linkmanmobile copyWithZone:zone];
        copy.linkmanname = [self.linkmanname copyWithZone:zone];
        copy.hascold = [self.hascold copyWithZone:zone];
        copy.bornreportversion = [self.bornreportversion copyWithZone:zone];
        copy.dadweight = [self.dadweight copyWithZone:zone];
        copy.enterreport = [self.enterreport copyWithZone:zone];
        copy.gravidity = [self.gravidity copyWithZone:zone];
        copy.doctorid = [self.doctorid copyWithZone:zone];
        copy.headimgversion = [self.headimgversion copyWithZone:zone];
        copy.accountname = [self.accountname copyWithZone:zone];
        copy.haslowweight = [self.haslowweight copyWithZone:zone];
    }
    
    return copy;
}


@end
