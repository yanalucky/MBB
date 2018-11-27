//
//  LoginUser.m
//
//  Created by   on 16/6/13
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "LoginUser.h"


NSString *const kLoginUserFeedingtype = @"feedingtype";
NSString *const kLoginUserHashypertension = @"hashypertension";
NSString *const kLoginUserDiseasescreening = @"diseasescreening";
NSString *const kLoginUserSubmitpwd = @"submitpwd";
NSString *const kLoginUserHasdiabetes = @"hasdiabetes";
NSString *const kLoginUserHasanemia = @"hasanemia";
NSString *const kLoginUserBornreport = @"bornreport";
NSString *const kLoginUserSex = @"sex";
NSString *const kLoginUserNativeplace = @"nativeplace";
NSString *const kLoginUserCarerphone = @"carerphone";
NSString *const kLoginUserIsstop = @"isstop";
NSString *const kLoginUserBorntype = @"borntype";
NSString *const kLoginUserLoginpwd = @"loginpwd";
NSString *const kLoginUserMumage = @"mumage";
NSString *const kLoginUserMumphone = @"mumphone";
NSString *const kLoginUserBornplace = @"bornplace";
NSString *const kLoginUserDadphone = @"dadphone";
NSString *const kLoginUserBornheight = @"bornheight";
NSString *const kLoginUserNationality = @"nationality";
NSString *const kLoginUserParity = @"parity";
NSString *const kLoginUserMumheight = @"mumheight";
NSString *const kLoginUserMumemail = @"mumemail";
NSString *const kLoginUserEnterreportversion = @"enterreportversion";
NSString *const kLoginUserDadage = @"dadage";
NSString *const kLoginUserBcusedcount = @"bcusedcount";
NSString *const kLoginUserDademail = @"dademail";
NSString *const kLoginUserLinkmansex = @"linkmansex";
NSString *const kLoginUserDadeducation = @"dadeducation";
NSString *const kLoginUserOtherdesc = @"otherdesc";
NSString *const kLoginUserBreakmonths = @"breakmonths";
NSString *const kLoginUserCarersex = @"carersex";
NSString *const kLoginUserBctotalcount = @"bctotalcount";
NSString *const kLoginUserHasicp = @"hasicp";
NSString *const kLoginUserRoleid = @"roleid";
NSString *const kLoginUserDeliverymethods = @"deliverymethods";
NSString *const kLoginUserMumweight = @"mumweight";
NSString *const kLoginUserHospitalid = @"hospitalid";
NSString *const kLoginUserSalontotalcount = @"salontotalcount";
NSString *const kLoginUserBorntime = @"borntime";
NSString *const kLoginUserAgreement = @"agreement";
NSString *const kLoginUserUserid = @"userid";
NSString *const kLoginUserCarer = @"carer";
NSString *const kLoginUserDadname = @"dadname";
NSString *const kLoginUserBornweight = @"bornweight";
NSString *const kLoginUserTreatusedcount = @"treatusedcount";
NSString *const kLoginUserCareeducation = @"careeducation";
NSString *const kLoginUserHasotherdisease = @"hasotherdisease";
NSString *const kLoginUserTruename = @"truename";
NSString *const kLoginUserCarername = @"carername";
NSString *const kLoginUserBirthday = @"birthday";
NSString *const kLoginUserMumbearage = @"mumbearage";
NSString *const kLoginUserCarenativeplace = @"carenativeplace";
NSString *const kLoginUserHasfirstheart = @"hasfirstheart";
NSString *const kLoginUserAccountmobile = @"accountmobile";
NSString *const kLoginUserDadheight = @"dadheight";
NSString *const kLoginUserLinkmanemail = @"linkmanemail";
NSString *const kLoginUserFilecode = @"filecode";
NSString *const kLoginUserLinkman = @"linkman";
NSString *const kLoginUserEnterreport = @"enterreport";
NSString *const kLoginUserMumeducation = @"mumeducation";
NSString *const kLoginUserAgreementversion = @"agreementversion";
NSString *const kLoginUserTreattotalcount = @"treattotalcount";
NSString *const kLoginUserSalonusedcount = @"salonusedcount";
NSString *const kLoginUserAccountemail = @"accountemail";
NSString *const kLoginUserMumname = @"mumname";
NSString *const kLoginUserNation = @"nation";
NSString *const kLoginUserHeadimg = @"headimg";
NSString *const kLoginUserDadweight = @"dadweight";
NSString *const kLoginUserLinkmanname = @"linkmanname";
NSString *const kLoginUserLinkmanmobile = @"linkmanmobile";
NSString *const kLoginUserEmergencyphone = @"emergencyphone";
NSString *const kLoginUserBornreportversion = @"bornreportversion";
NSString *const kLoginUserHascold = @"hascold";
NSString *const kLoginUserPregnancy = @"pregnancy";
NSString *const kLoginUserDoctorid = @"doctorid";
NSString *const kLoginUserGravidity = @"gravidity";
NSString *const kLoginUserHeadimgversion = @"headimgversion";
NSString *const kLoginUserAccountname = @"accountname";
NSString *const kLoginUserHaslowweight = @"haslowweight";


@interface LoginUser ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation LoginUser

@synthesize feedingtype = _feedingtype;
@synthesize hashypertension = _hashypertension;
@synthesize diseasescreening = _diseasescreening;
@synthesize submitpwd = _submitpwd;
@synthesize hasdiabetes = _hasdiabetes;
@synthesize hasanemia = _hasanemia;
@synthesize bornreport = _bornreport;
@synthesize sex = _sex;
@synthesize nativeplace = _nativeplace;
@synthesize carerphone = _carerphone;
@synthesize isstop = _isstop;
@synthesize borntype = _borntype;
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
@synthesize dadeducation = _dadeducation;
@synthesize otherdesc = _otherdesc;
@synthesize breakmonths = _breakmonths;
@synthesize carersex = _carersex;
@synthesize bctotalcount = _bctotalcount;
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
@synthesize truename = _truename;
@synthesize carername = _carername;
@synthesize birthday = _birthday;
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
            self.feedingtype = [self objectOrNilForKey:kLoginUserFeedingtype fromDictionary:dict];
            self.hashypertension = [self objectOrNilForKey:kLoginUserHashypertension fromDictionary:dict];
            self.diseasescreening = [self objectOrNilForKey:kLoginUserDiseasescreening fromDictionary:dict];
            self.submitpwd = [self objectOrNilForKey:kLoginUserSubmitpwd fromDictionary:dict];
            self.hasdiabetes = [self objectOrNilForKey:kLoginUserHasdiabetes fromDictionary:dict];
            self.hasanemia = [self objectOrNilForKey:kLoginUserHasanemia fromDictionary:dict];
            self.bornreport = [self objectOrNilForKey:kLoginUserBornreport fromDictionary:dict];
            self.sex = [self objectOrNilForKey:kLoginUserSex fromDictionary:dict];
            self.nativeplace = [self objectOrNilForKey:kLoginUserNativeplace fromDictionary:dict];
            self.carerphone = [self objectOrNilForKey:kLoginUserCarerphone fromDictionary:dict];
            self.isstop = [self objectOrNilForKey:kLoginUserIsstop fromDictionary:dict];
            self.borntype = [self objectOrNilForKey:kLoginUserBorntype fromDictionary:dict];
            self.loginpwd = [self objectOrNilForKey:kLoginUserLoginpwd fromDictionary:dict];
            self.mumage = [self objectOrNilForKey:kLoginUserMumage fromDictionary:dict];
            self.mumphone = [self objectOrNilForKey:kLoginUserMumphone fromDictionary:dict];
            self.bornplace = [self objectOrNilForKey:kLoginUserBornplace fromDictionary:dict];
            self.dadphone = [self objectOrNilForKey:kLoginUserDadphone fromDictionary:dict];
            self.bornheight = [self objectOrNilForKey:kLoginUserBornheight fromDictionary:dict];
            self.nationality = [self objectOrNilForKey:kLoginUserNationality fromDictionary:dict];
            self.parity = [self objectOrNilForKey:kLoginUserParity fromDictionary:dict];
            self.mumheight = [self objectOrNilForKey:kLoginUserMumheight fromDictionary:dict];
            self.mumemail = [self objectOrNilForKey:kLoginUserMumemail fromDictionary:dict];
            self.enterreportversion = [self objectOrNilForKey:kLoginUserEnterreportversion fromDictionary:dict];
            self.dadage = [self objectOrNilForKey:kLoginUserDadage fromDictionary:dict];
            self.bcusedcount = [self objectOrNilForKey:kLoginUserBcusedcount fromDictionary:dict];
            self.dademail = [self objectOrNilForKey:kLoginUserDademail fromDictionary:dict];
            self.linkmansex = [self objectOrNilForKey:kLoginUserLinkmansex fromDictionary:dict];
            self.dadeducation = [self objectOrNilForKey:kLoginUserDadeducation fromDictionary:dict];
            self.otherdesc = [self objectOrNilForKey:kLoginUserOtherdesc fromDictionary:dict];
            self.breakmonths = [self objectOrNilForKey:kLoginUserBreakmonths fromDictionary:dict];
            self.carersex = [self objectOrNilForKey:kLoginUserCarersex fromDictionary:dict];
            self.bctotalcount = [self objectOrNilForKey:kLoginUserBctotalcount fromDictionary:dict];
            self.hasicp = [self objectOrNilForKey:kLoginUserHasicp fromDictionary:dict];
            self.roleid = [self objectOrNilForKey:kLoginUserRoleid fromDictionary:dict];
            self.deliverymethods = [self objectOrNilForKey:kLoginUserDeliverymethods fromDictionary:dict];
            self.mumweight = [self objectOrNilForKey:kLoginUserMumweight fromDictionary:dict];
            self.hospitalid = [self objectOrNilForKey:kLoginUserHospitalid fromDictionary:dict];
            self.salontotalcount = [self objectOrNilForKey:kLoginUserSalontotalcount fromDictionary:dict];
            self.borntime = [self objectOrNilForKey:kLoginUserBorntime fromDictionary:dict];
            self.agreement = [self objectOrNilForKey:kLoginUserAgreement fromDictionary:dict];
            self.userid = [self objectOrNilForKey:kLoginUserUserid fromDictionary:dict];
            self.carer = [self objectOrNilForKey:kLoginUserCarer fromDictionary:dict];
            self.dadname = [self objectOrNilForKey:kLoginUserDadname fromDictionary:dict];
            self.bornweight = [self objectOrNilForKey:kLoginUserBornweight fromDictionary:dict];
            self.treatusedcount = [self objectOrNilForKey:kLoginUserTreatusedcount fromDictionary:dict];
            self.careeducation = [self objectOrNilForKey:kLoginUserCareeducation fromDictionary:dict];
            self.hasotherdisease = [self objectOrNilForKey:kLoginUserHasotherdisease fromDictionary:dict];
            self.truename = [self objectOrNilForKey:kLoginUserTruename fromDictionary:dict];
            self.carername = [self objectOrNilForKey:kLoginUserCarername fromDictionary:dict];
            self.birthday = [self objectOrNilForKey:kLoginUserBirthday fromDictionary:dict];
            self.mumbearage = [self objectOrNilForKey:kLoginUserMumbearage fromDictionary:dict];
            self.carenativeplace = [self objectOrNilForKey:kLoginUserCarenativeplace fromDictionary:dict];
            self.hasfirstheart = [self objectOrNilForKey:kLoginUserHasfirstheart fromDictionary:dict];
            self.accountmobile = [self objectOrNilForKey:kLoginUserAccountmobile fromDictionary:dict];
            self.dadheight = [self objectOrNilForKey:kLoginUserDadheight fromDictionary:dict];
            self.linkmanemail = [self objectOrNilForKey:kLoginUserLinkmanemail fromDictionary:dict];
            self.filecode = [self objectOrNilForKey:kLoginUserFilecode fromDictionary:dict];
            self.linkman = [self objectOrNilForKey:kLoginUserLinkman fromDictionary:dict];
            self.enterreport = [self objectOrNilForKey:kLoginUserEnterreport fromDictionary:dict];
            self.mumeducation = [self objectOrNilForKey:kLoginUserMumeducation fromDictionary:dict];
            self.agreementversion = [self objectOrNilForKey:kLoginUserAgreementversion fromDictionary:dict];
            self.treattotalcount = [self objectOrNilForKey:kLoginUserTreattotalcount fromDictionary:dict];
            self.salonusedcount = [self objectOrNilForKey:kLoginUserSalonusedcount fromDictionary:dict];
            self.accountemail = [self objectOrNilForKey:kLoginUserAccountemail fromDictionary:dict];
            self.mumname = [self objectOrNilForKey:kLoginUserMumname fromDictionary:dict];
            self.nation = [self objectOrNilForKey:kLoginUserNation fromDictionary:dict];
            self.headimg = [self objectOrNilForKey:kLoginUserHeadimg fromDictionary:dict];
            self.dadweight = [self objectOrNilForKey:kLoginUserDadweight fromDictionary:dict];
            self.linkmanname = [self objectOrNilForKey:kLoginUserLinkmanname fromDictionary:dict];
            self.linkmanmobile = [self objectOrNilForKey:kLoginUserLinkmanmobile fromDictionary:dict];
            self.emergencyphone = [self objectOrNilForKey:kLoginUserEmergencyphone fromDictionary:dict];
            self.bornreportversion = [self objectOrNilForKey:kLoginUserBornreportversion fromDictionary:dict];
            self.hascold = [self objectOrNilForKey:kLoginUserHascold fromDictionary:dict];
            self.pregnancy = [self objectOrNilForKey:kLoginUserPregnancy fromDictionary:dict];
            self.doctorid = [self objectOrNilForKey:kLoginUserDoctorid fromDictionary:dict];
            self.gravidity = [self objectOrNilForKey:kLoginUserGravidity fromDictionary:dict];
            self.headimgversion = [self objectOrNilForKey:kLoginUserHeadimgversion fromDictionary:dict];
            self.accountname = [self objectOrNilForKey:kLoginUserAccountname fromDictionary:dict];
            self.haslowweight = [self objectOrNilForKey:kLoginUserHaslowweight fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.feedingtype forKey:kLoginUserFeedingtype];
    [mutableDict setValue:self.hashypertension forKey:kLoginUserHashypertension];
    [mutableDict setValue:self.diseasescreening forKey:kLoginUserDiseasescreening];
    [mutableDict setValue:self.submitpwd forKey:kLoginUserSubmitpwd];
    [mutableDict setValue:self.hasdiabetes forKey:kLoginUserHasdiabetes];
    [mutableDict setValue:self.hasanemia forKey:kLoginUserHasanemia];
    [mutableDict setValue:self.bornreport forKey:kLoginUserBornreport];
    [mutableDict setValue:self.sex forKey:kLoginUserSex];
    [mutableDict setValue:self.nativeplace forKey:kLoginUserNativeplace];
    [mutableDict setValue:self.carerphone forKey:kLoginUserCarerphone];
    [mutableDict setValue:self.isstop forKey:kLoginUserIsstop];
    [mutableDict setValue:self.borntype forKey:kLoginUserBorntype];
    [mutableDict setValue:self.loginpwd forKey:kLoginUserLoginpwd];
    [mutableDict setValue:self.mumage forKey:kLoginUserMumage];
    [mutableDict setValue:self.mumphone forKey:kLoginUserMumphone];
    [mutableDict setValue:self.bornplace forKey:kLoginUserBornplace];
    [mutableDict setValue:self.dadphone forKey:kLoginUserDadphone];
    [mutableDict setValue:self.bornheight forKey:kLoginUserBornheight];
    [mutableDict setValue:self.nationality forKey:kLoginUserNationality];
    [mutableDict setValue:self.parity forKey:kLoginUserParity];
    [mutableDict setValue:self.mumheight forKey:kLoginUserMumheight];
    [mutableDict setValue:self.mumemail forKey:kLoginUserMumemail];
    [mutableDict setValue:self.enterreportversion forKey:kLoginUserEnterreportversion];
    [mutableDict setValue:self.dadage forKey:kLoginUserDadage];
    [mutableDict setValue:self.bcusedcount forKey:kLoginUserBcusedcount];
    [mutableDict setValue:self.dademail forKey:kLoginUserDademail];
    [mutableDict setValue:self.linkmansex forKey:kLoginUserLinkmansex];
    [mutableDict setValue:self.dadeducation forKey:kLoginUserDadeducation];
    [mutableDict setValue:self.otherdesc forKey:kLoginUserOtherdesc];
    [mutableDict setValue:self.breakmonths forKey:kLoginUserBreakmonths];
    [mutableDict setValue:self.carersex forKey:kLoginUserCarersex];
    [mutableDict setValue:self.bctotalcount forKey:kLoginUserBctotalcount];
    [mutableDict setValue:self.hasicp forKey:kLoginUserHasicp];
    [mutableDict setValue:self.roleid forKey:kLoginUserRoleid];
    [mutableDict setValue:self.deliverymethods forKey:kLoginUserDeliverymethods];
    [mutableDict setValue:self.mumweight forKey:kLoginUserMumweight];
    [mutableDict setValue:self.hospitalid forKey:kLoginUserHospitalid];
    [mutableDict setValue:self.salontotalcount forKey:kLoginUserSalontotalcount];
    [mutableDict setValue:self.borntime forKey:kLoginUserBorntime];
    [mutableDict setValue:self.agreement forKey:kLoginUserAgreement];
    [mutableDict setValue:self.userid forKey:kLoginUserUserid];
    [mutableDict setValue:self.carer forKey:kLoginUserCarer];
    [mutableDict setValue:self.dadname forKey:kLoginUserDadname];
    [mutableDict setValue:self.bornweight forKey:kLoginUserBornweight];
    [mutableDict setValue:self.treatusedcount forKey:kLoginUserTreatusedcount];
    [mutableDict setValue:self.careeducation forKey:kLoginUserCareeducation];
    [mutableDict setValue:self.hasotherdisease forKey:kLoginUserHasotherdisease];
    [mutableDict setValue:self.truename forKey:kLoginUserTruename];
    [mutableDict setValue:self.carername forKey:kLoginUserCarername];
    [mutableDict setValue:self.birthday forKey:kLoginUserBirthday];
    [mutableDict setValue:self.mumbearage forKey:kLoginUserMumbearage];
    [mutableDict setValue:self.carenativeplace forKey:kLoginUserCarenativeplace];
    [mutableDict setValue:self.hasfirstheart forKey:kLoginUserHasfirstheart];
    [mutableDict setValue:self.accountmobile forKey:kLoginUserAccountmobile];
    [mutableDict setValue:self.dadheight forKey:kLoginUserDadheight];
    [mutableDict setValue:self.linkmanemail forKey:kLoginUserLinkmanemail];
    [mutableDict setValue:self.filecode forKey:kLoginUserFilecode];
    [mutableDict setValue:self.linkman forKey:kLoginUserLinkman];
    [mutableDict setValue:self.enterreport forKey:kLoginUserEnterreport];
    [mutableDict setValue:self.mumeducation forKey:kLoginUserMumeducation];
    [mutableDict setValue:self.agreementversion forKey:kLoginUserAgreementversion];
    [mutableDict setValue:self.treattotalcount forKey:kLoginUserTreattotalcount];
    [mutableDict setValue:self.salonusedcount forKey:kLoginUserSalonusedcount];
    [mutableDict setValue:self.accountemail forKey:kLoginUserAccountemail];
    [mutableDict setValue:self.mumname forKey:kLoginUserMumname];
    [mutableDict setValue:self.nation forKey:kLoginUserNation];
    [mutableDict setValue:self.headimg forKey:kLoginUserHeadimg];
    [mutableDict setValue:self.dadweight forKey:kLoginUserDadweight];
    [mutableDict setValue:self.linkmanname forKey:kLoginUserLinkmanname];
    [mutableDict setValue:self.linkmanmobile forKey:kLoginUserLinkmanmobile];
    [mutableDict setValue:self.emergencyphone forKey:kLoginUserEmergencyphone];
    [mutableDict setValue:self.bornreportversion forKey:kLoginUserBornreportversion];
    [mutableDict setValue:self.hascold forKey:kLoginUserHascold];
    [mutableDict setValue:self.pregnancy forKey:kLoginUserPregnancy];
    [mutableDict setValue:self.doctorid forKey:kLoginUserDoctorid];
    [mutableDict setValue:self.gravidity forKey:kLoginUserGravidity];
    [mutableDict setValue:self.headimgversion forKey:kLoginUserHeadimgversion];
    [mutableDict setValue:self.accountname forKey:kLoginUserAccountname];
    [mutableDict setValue:self.haslowweight forKey:kLoginUserHaslowweight];

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

    self.feedingtype = [aDecoder decodeObjectForKey:kLoginUserFeedingtype];
    self.hashypertension = [aDecoder decodeObjectForKey:kLoginUserHashypertension];
    self.diseasescreening = [aDecoder decodeObjectForKey:kLoginUserDiseasescreening];
    self.submitpwd = [aDecoder decodeObjectForKey:kLoginUserSubmitpwd];
    self.hasdiabetes = [aDecoder decodeObjectForKey:kLoginUserHasdiabetes];
    self.hasanemia = [aDecoder decodeObjectForKey:kLoginUserHasanemia];
    self.bornreport = [aDecoder decodeObjectForKey:kLoginUserBornreport];
    self.sex = [aDecoder decodeObjectForKey:kLoginUserSex];
    self.nativeplace = [aDecoder decodeObjectForKey:kLoginUserNativeplace];
    self.carerphone = [aDecoder decodeObjectForKey:kLoginUserCarerphone];
    self.isstop = [aDecoder decodeObjectForKey:kLoginUserIsstop];
    self.borntype = [aDecoder decodeObjectForKey:kLoginUserBorntype];
    self.loginpwd = [aDecoder decodeObjectForKey:kLoginUserLoginpwd];
    self.mumage = [aDecoder decodeObjectForKey:kLoginUserMumage];
    self.mumphone = [aDecoder decodeObjectForKey:kLoginUserMumphone];
    self.bornplace = [aDecoder decodeObjectForKey:kLoginUserBornplace];
    self.dadphone = [aDecoder decodeObjectForKey:kLoginUserDadphone];
    self.bornheight = [aDecoder decodeObjectForKey:kLoginUserBornheight];
    self.nationality = [aDecoder decodeObjectForKey:kLoginUserNationality];
    self.parity = [aDecoder decodeObjectForKey:kLoginUserParity];
    self.mumheight = [aDecoder decodeObjectForKey:kLoginUserMumheight];
    self.mumemail = [aDecoder decodeObjectForKey:kLoginUserMumemail];
    self.enterreportversion = [aDecoder decodeObjectForKey:kLoginUserEnterreportversion];
    self.dadage = [aDecoder decodeObjectForKey:kLoginUserDadage];
    self.bcusedcount = [aDecoder decodeObjectForKey:kLoginUserBcusedcount];
    self.dademail = [aDecoder decodeObjectForKey:kLoginUserDademail];
    self.linkmansex = [aDecoder decodeObjectForKey:kLoginUserLinkmansex];
    self.dadeducation = [aDecoder decodeObjectForKey:kLoginUserDadeducation];
    self.otherdesc = [aDecoder decodeObjectForKey:kLoginUserOtherdesc];
    self.breakmonths = [aDecoder decodeObjectForKey:kLoginUserBreakmonths];
    self.carersex = [aDecoder decodeObjectForKey:kLoginUserCarersex];
    self.bctotalcount = [aDecoder decodeObjectForKey:kLoginUserBctotalcount];
    self.hasicp = [aDecoder decodeObjectForKey:kLoginUserHasicp];
    self.roleid = [aDecoder decodeObjectForKey:kLoginUserRoleid];
    self.deliverymethods = [aDecoder decodeObjectForKey:kLoginUserDeliverymethods];
    self.mumweight = [aDecoder decodeObjectForKey:kLoginUserMumweight];
    self.hospitalid = [aDecoder decodeObjectForKey:kLoginUserHospitalid];
    self.salontotalcount = [aDecoder decodeObjectForKey:kLoginUserSalontotalcount];
    self.borntime = [aDecoder decodeObjectForKey:kLoginUserBorntime];
    self.agreement = [aDecoder decodeObjectForKey:kLoginUserAgreement];
    self.userid = [aDecoder decodeObjectForKey:kLoginUserUserid];
    self.carer = [aDecoder decodeObjectForKey:kLoginUserCarer];
    self.dadname = [aDecoder decodeObjectForKey:kLoginUserDadname];
    self.bornweight = [aDecoder decodeObjectForKey:kLoginUserBornweight];
    self.treatusedcount = [aDecoder decodeObjectForKey:kLoginUserTreatusedcount];
    self.careeducation = [aDecoder decodeObjectForKey:kLoginUserCareeducation];
    self.hasotherdisease = [aDecoder decodeObjectForKey:kLoginUserHasotherdisease];
    self.truename = [aDecoder decodeObjectForKey:kLoginUserTruename];
    self.carername = [aDecoder decodeObjectForKey:kLoginUserCarername];
    self.birthday = [aDecoder decodeObjectForKey:kLoginUserBirthday];
    self.mumbearage = [aDecoder decodeObjectForKey:kLoginUserMumbearage];
    self.carenativeplace = [aDecoder decodeObjectForKey:kLoginUserCarenativeplace];
    self.hasfirstheart = [aDecoder decodeObjectForKey:kLoginUserHasfirstheart];
    self.accountmobile = [aDecoder decodeObjectForKey:kLoginUserAccountmobile];
    self.dadheight = [aDecoder decodeObjectForKey:kLoginUserDadheight];
    self.linkmanemail = [aDecoder decodeObjectForKey:kLoginUserLinkmanemail];
    self.filecode = [aDecoder decodeObjectForKey:kLoginUserFilecode];
    self.linkman = [aDecoder decodeObjectForKey:kLoginUserLinkman];
    self.enterreport = [aDecoder decodeObjectForKey:kLoginUserEnterreport];
    self.mumeducation = [aDecoder decodeObjectForKey:kLoginUserMumeducation];
    self.agreementversion = [aDecoder decodeObjectForKey:kLoginUserAgreementversion];
    self.treattotalcount = [aDecoder decodeObjectForKey:kLoginUserTreattotalcount];
    self.salonusedcount = [aDecoder decodeObjectForKey:kLoginUserSalonusedcount];
    self.accountemail = [aDecoder decodeObjectForKey:kLoginUserAccountemail];
    self.mumname = [aDecoder decodeObjectForKey:kLoginUserMumname];
    self.nation = [aDecoder decodeObjectForKey:kLoginUserNation];
    self.headimg = [aDecoder decodeObjectForKey:kLoginUserHeadimg];
    self.dadweight = [aDecoder decodeObjectForKey:kLoginUserDadweight];
    self.linkmanname = [aDecoder decodeObjectForKey:kLoginUserLinkmanname];
    self.linkmanmobile = [aDecoder decodeObjectForKey:kLoginUserLinkmanmobile];
    self.emergencyphone = [aDecoder decodeObjectForKey:kLoginUserEmergencyphone];
    self.bornreportversion = [aDecoder decodeObjectForKey:kLoginUserBornreportversion];
    self.hascold = [aDecoder decodeObjectForKey:kLoginUserHascold];
    self.pregnancy = [aDecoder decodeObjectForKey:kLoginUserPregnancy];
    self.doctorid = [aDecoder decodeObjectForKey:kLoginUserDoctorid];
    self.gravidity = [aDecoder decodeObjectForKey:kLoginUserGravidity];
    self.headimgversion = [aDecoder decodeObjectForKey:kLoginUserHeadimgversion];
    self.accountname = [aDecoder decodeObjectForKey:kLoginUserAccountname];
    self.haslowweight = [aDecoder decodeObjectForKey:kLoginUserHaslowweight];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_feedingtype forKey:kLoginUserFeedingtype];
    [aCoder encodeObject:_hashypertension forKey:kLoginUserHashypertension];
    [aCoder encodeObject:_diseasescreening forKey:kLoginUserDiseasescreening];
    [aCoder encodeObject:_submitpwd forKey:kLoginUserSubmitpwd];
    [aCoder encodeObject:_hasdiabetes forKey:kLoginUserHasdiabetes];
    [aCoder encodeObject:_hasanemia forKey:kLoginUserHasanemia];
    [aCoder encodeObject:_bornreport forKey:kLoginUserBornreport];
    [aCoder encodeObject:_sex forKey:kLoginUserSex];
    [aCoder encodeObject:_nativeplace forKey:kLoginUserNativeplace];
    [aCoder encodeObject:_carerphone forKey:kLoginUserCarerphone];
    [aCoder encodeObject:_isstop forKey:kLoginUserIsstop];
    [aCoder encodeObject:_borntype forKey:kLoginUserBorntype];
    [aCoder encodeObject:_loginpwd forKey:kLoginUserLoginpwd];
    [aCoder encodeObject:_mumage forKey:kLoginUserMumage];
    [aCoder encodeObject:_mumphone forKey:kLoginUserMumphone];
    [aCoder encodeObject:_bornplace forKey:kLoginUserBornplace];
    [aCoder encodeObject:_dadphone forKey:kLoginUserDadphone];
    [aCoder encodeObject:_bornheight forKey:kLoginUserBornheight];
    [aCoder encodeObject:_nationality forKey:kLoginUserNationality];
    [aCoder encodeObject:_parity forKey:kLoginUserParity];
    [aCoder encodeObject:_mumheight forKey:kLoginUserMumheight];
    [aCoder encodeObject:_mumemail forKey:kLoginUserMumemail];
    [aCoder encodeObject:_enterreportversion forKey:kLoginUserEnterreportversion];
    [aCoder encodeObject:_dadage forKey:kLoginUserDadage];
    [aCoder encodeObject:_bcusedcount forKey:kLoginUserBcusedcount];
    [aCoder encodeObject:_dademail forKey:kLoginUserDademail];
    [aCoder encodeObject:_linkmansex forKey:kLoginUserLinkmansex];
    [aCoder encodeObject:_dadeducation forKey:kLoginUserDadeducation];
    [aCoder encodeObject:_otherdesc forKey:kLoginUserOtherdesc];
    [aCoder encodeObject:_breakmonths forKey:kLoginUserBreakmonths];
    [aCoder encodeObject:_carersex forKey:kLoginUserCarersex];
    [aCoder encodeObject:_bctotalcount forKey:kLoginUserBctotalcount];
    [aCoder encodeObject:_hasicp forKey:kLoginUserHasicp];
    [aCoder encodeObject:_roleid forKey:kLoginUserRoleid];
    [aCoder encodeObject:_deliverymethods forKey:kLoginUserDeliverymethods];
    [aCoder encodeObject:_mumweight forKey:kLoginUserMumweight];
    [aCoder encodeObject:_hospitalid forKey:kLoginUserHospitalid];
    [aCoder encodeObject:_salontotalcount forKey:kLoginUserSalontotalcount];
    [aCoder encodeObject:_borntime forKey:kLoginUserBorntime];
    [aCoder encodeObject:_agreement forKey:kLoginUserAgreement];
    [aCoder encodeObject:_userid forKey:kLoginUserUserid];
    [aCoder encodeObject:_carer forKey:kLoginUserCarer];
    [aCoder encodeObject:_dadname forKey:kLoginUserDadname];
    [aCoder encodeObject:_bornweight forKey:kLoginUserBornweight];
    [aCoder encodeObject:_treatusedcount forKey:kLoginUserTreatusedcount];
    [aCoder encodeObject:_careeducation forKey:kLoginUserCareeducation];
    [aCoder encodeObject:_hasotherdisease forKey:kLoginUserHasotherdisease];
    [aCoder encodeObject:_truename forKey:kLoginUserTruename];
    [aCoder encodeObject:_carername forKey:kLoginUserCarername];
    [aCoder encodeObject:_birthday forKey:kLoginUserBirthday];
    [aCoder encodeObject:_mumbearage forKey:kLoginUserMumbearage];
    [aCoder encodeObject:_carenativeplace forKey:kLoginUserCarenativeplace];
    [aCoder encodeObject:_hasfirstheart forKey:kLoginUserHasfirstheart];
    [aCoder encodeObject:_accountmobile forKey:kLoginUserAccountmobile];
    [aCoder encodeObject:_dadheight forKey:kLoginUserDadheight];
    [aCoder encodeObject:_linkmanemail forKey:kLoginUserLinkmanemail];
    [aCoder encodeObject:_filecode forKey:kLoginUserFilecode];
    [aCoder encodeObject:_linkman forKey:kLoginUserLinkman];
    [aCoder encodeObject:_enterreport forKey:kLoginUserEnterreport];
    [aCoder encodeObject:_mumeducation forKey:kLoginUserMumeducation];
    [aCoder encodeObject:_agreementversion forKey:kLoginUserAgreementversion];
    [aCoder encodeObject:_treattotalcount forKey:kLoginUserTreattotalcount];
    [aCoder encodeObject:_salonusedcount forKey:kLoginUserSalonusedcount];
    [aCoder encodeObject:_accountemail forKey:kLoginUserAccountemail];
    [aCoder encodeObject:_mumname forKey:kLoginUserMumname];
    [aCoder encodeObject:_nation forKey:kLoginUserNation];
    [aCoder encodeObject:_headimg forKey:kLoginUserHeadimg];
    [aCoder encodeObject:_dadweight forKey:kLoginUserDadweight];
    [aCoder encodeObject:_linkmanname forKey:kLoginUserLinkmanname];
    [aCoder encodeObject:_linkmanmobile forKey:kLoginUserLinkmanmobile];
    [aCoder encodeObject:_emergencyphone forKey:kLoginUserEmergencyphone];
    [aCoder encodeObject:_bornreportversion forKey:kLoginUserBornreportversion];
    [aCoder encodeObject:_hascold forKey:kLoginUserHascold];
    [aCoder encodeObject:_pregnancy forKey:kLoginUserPregnancy];
    [aCoder encodeObject:_doctorid forKey:kLoginUserDoctorid];
    [aCoder encodeObject:_gravidity forKey:kLoginUserGravidity];
    [aCoder encodeObject:_headimgversion forKey:kLoginUserHeadimgversion];
    [aCoder encodeObject:_accountname forKey:kLoginUserAccountname];
    [aCoder encodeObject:_haslowweight forKey:kLoginUserHaslowweight];
}

- (id)copyWithZone:(NSZone *)zone
{
    LoginUser *copy = [[LoginUser alloc] init];
    
    if (copy) {

        copy.feedingtype = [self.feedingtype copyWithZone:zone];
        copy.hashypertension = [self.hashypertension copyWithZone:zone];
        copy.diseasescreening = [self.diseasescreening copyWithZone:zone];
        copy.submitpwd = [self.submitpwd copyWithZone:zone];
        copy.hasdiabetes = [self.hasdiabetes copyWithZone:zone];
        copy.hasanemia = [self.hasanemia copyWithZone:zone];
        copy.bornreport = [self.bornreport copyWithZone:zone];
        copy.sex = [self.sex copyWithZone:zone];
        copy.nativeplace = [self.nativeplace copyWithZone:zone];
        copy.carerphone = [self.carerphone copyWithZone:zone];
        copy.isstop = [self.isstop copyWithZone:zone];
        copy.borntype = [self.borntype copyWithZone:zone];
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
        copy.dadeducation = [self.dadeducation copyWithZone:zone];
        copy.otherdesc = [self.otherdesc copyWithZone:zone];
        copy.breakmonths = [self.breakmonths copyWithZone:zone];
        copy.carersex = [self.carersex copyWithZone:zone];
        copy.bctotalcount = [self.bctotalcount copyWithZone:zone];
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
        copy.truename = [self.truename copyWithZone:zone];
        copy.carername = [self.carername copyWithZone:zone];
        copy.birthday = [self.birthday copyWithZone:zone];
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
