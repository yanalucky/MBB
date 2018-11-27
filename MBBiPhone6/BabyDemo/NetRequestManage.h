

#import <Foundation/Foundation.h>

@interface NetRequestManage : NSObject<NSURLConnectionDataDelegate>

@property(nonatomic,copy)void(^successedBlocks)(NSData *data,NetRequestManage *load);
@property(nonatomic,copy)void(^failedBlocks)(NSError *error,NetRequestManage *load);



@property(nonatomic,strong)NSMutableData *resultData;




+(void)vesionUpdateSuccessBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;
+(void)LoginRequestAccountName:(NSString *)name andAccountPassword:(NSString *)password successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;

+(void)sendMessageWithPhone:(NSString *)phoneNumber successBlocks:(void (^)(NSData * data,NetRequestManage *sendMsg))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *sendMsg))failedBlock;
+(void)sendResetPasswordMessageWithPhone:(NSString *)phoneNumber successBlocks:(void (^)(NSData * data,NetRequestManage *sendMsg))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *sendMsg))failedBlock;


+(void)registerCheckWithAccountName:(NSString *)accountName andLoginPwd:(NSString *)pwd andCode:(NSString *)code andCheckCode:(NSString *)checkCode successBlocks:(void (^)(NSData * data,NetRequestManage *registerCheck))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *registerCheck))failedBlock;

+(void)loadRegisterSuccessBlocks:(void (^)(NSData * data,NetRequestManage *loadRegister))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *loadRegister))failedBlock;
+(void)babyUserRegisterWithAccountName:(NSString *)name andMenuId:(NSString *)menuid andHospitalId:(NSString *)hospitalid andDoctorId:(NSString *)doctorId andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData * data,NetRequestManage *babyUserRegister))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *babyUserRegister))failedBlock;
+(void)webUserRegisterWithAccountName:(NSString *)name andPwd:(NSString *)pwd andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData * data,NetRequestManage *webUserRegister))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *webUserRegister))failedBlock;



+(void)serverConfigRequestWithMonth:(NSString *)month SuccessBlocks:(void (^)(NSData *data, NetRequestManage *serverConfig))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *serverConfig))failedBlock;

+(void)webUserInitServerConfigureWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *webUserInitServerConfigure))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *webUserInitServerConfigure))failedBlock;

+(void)saveNewPwdWithAccountName:(NSString *)accountName andLoginPwd:(NSString *)pwd andCode:(NSString *)code andCheckCode:(NSString *)checkCode successBlocks:(void (^)(NSData * data,NetRequestManage *saveNewPwd))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *saveNewPwd))failedBlock;


+(void)loadHomeWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *loadHome))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *loadHome))failedBlock;


+(void)clickDateTimeWithChooseTime:(NSString *)time andUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *clickDateTime))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *clickDateTime))failedBlock;


+(void)clickHistoryRecordWithChooseTime:(NSString *)time andUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *clickHistoryRecord))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *clickHistoryRecord))failedBlock;


+(void)getRecordStarWithUserId:(NSString *)userId  successBlocks:(void (^)(NSData *data, NetRequestManage *recordStar))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *recordStar))failedBlock;

+(void)getNurtureGuideWithUserId:(NSString *)userId  successBlocks:(void (^)(NSData *data, NetRequestManage *nurtureGuide))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *nurtureGuide))failedBlock;

+(void)getOnlineAppraisalWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *onlineAppraisal))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *onlineAppraisal))failedBlock;



+(void)submitMonthRecordWithUserRole:(NSString *)userRole andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData * data,NetRequestManage *submitMonthRecord))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *submitMonthRecord))failedBlock;



+(void)getCurrentMenuWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *getCurrentMenu))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *getCurrentMenu))failedBlock;

+(void)getTheLastMenuWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *getTheLastMenu))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *getTheLastMenu))failedBlock;


+(void)saveUserWithUserId:(NSString *)userId andBabyInfoDic:(NSDictionary *)babyInfoDic successBlocks:(void (^)(NSData *data, NetRequestManage *saveUser))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *saveUser))failedBlock;
+(void)editLinkmanWithUserId:(NSString *)userId andLinkmanInfoDic:(NSDictionary *)linkmanInfoDic successBlocks:(void (^)(NSData *data, NetRequestManage *editLinkman))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *editLinkman))failedBlock;


+(void)editPwdWithUserId:(NSString *)userId andOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)pwd successBlocks:(void (^)(NSData *data, NetRequestManage *editPwd))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *editPwd))failedBlock;


+(void)saveBeforeRecordWithUserId:(NSString *)userId andUserRole:(NSString *)userRole andNeedInsertBeforeRecordArr:(NSArray *)needInsertBeforeRecord isBreakMonth:(BOOL)isBreakMonth successBlocks:(void (^)(NSData *data, NetRequestManage *saveBeforeRecord))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *saveBeforeRecord))failedBlock;


+(void)getBreakMonthsWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *data, NetRequestManage *getBreakMonths))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *getBreakMonths))failedBlock;

@end
