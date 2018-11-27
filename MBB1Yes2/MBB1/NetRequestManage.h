//
//  NetRequestManage.h
//  cjzkwMain
//
//  Created by 财经智库网mac on 15/9/10.
//  Copyright (c) 2015年 财经智库网. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetRequestManage : NSObject<NSURLConnectionDataDelegate>


@property(nonatomic,copy)void(^successedBlocks)(NSData *data,NetRequestManage *load);
@property(nonatomic,copy)void(^failedBlocks)(NSError *error,NetRequestManage *load);
@property(nonatomic,strong)NSMutableData *resultData;




+(void)vesionUpdateSuccessBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;
+(void)LoginRequestAccountName:(NSString *)name andAccountPassword:(NSString *)password successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;

+(void)serverConfigRequestWithMonth:(NSString *)month SuccessBlocks:(void (^)(NSData *data, NetRequestManage *serverConfig))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *serverConfig))failedBlock;
+(void)loadUserWithUserId:(NSString *)userId successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;

+(void)jiluWithUserId:(NSString *)userId successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;


+(void)reportWithUserId:(JLUserRecord *)record questionsArr:(NSArray *)questions password:(NSString *)pwd successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;
+(void)setPasswordWithUserId:(NSString *)userId oldPwd:(NSString *)oldPassword newPwd:(NSString *)newPassword successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;

+(void)setParentWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;

+(void)setCarerWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;

+(void)getPwdByAccountName:(NSString *)name andAccountEmail:(NSString *)email successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;
+(void)joinSalonWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;
+(void)getFeedbackSuccessBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;
+(void)submitFeedbackWithTextfield:(NSString *)str andPwd:(NSString *)pwd successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock;
+(void)uploadHeadImgByUserId:(NSString *)userId andImageData:(NSData *)imageData successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock;

@end
