//
//  NetRequestManage.m
//  cjzkwMain
//
//  Created by 财经智库网mac on 15/9/10.
//  Copyright (c) 2015年 财经智库网. All rights reserved.
//

#import "NetRequestManage.h"

@implementation NetRequestManage
+(void)vesionUpdateSuccessBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,@"version.xml"]];
    
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSDictionary *doc = @{@"version":@"1.0.1"};
    
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    [request setHTTPMethod:@"POST"];
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}

//登录
+(void)LoginRequestAccountName:(NSString *)name andAccountPassword:(NSString *)password successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,LOGIN]];
    
    //第二步，创建请求
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *accountName = [NSString stringWithCString:"accountName"];
    NSString *accountPassword = [NSString stringWithCString:"loginPwd"];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:name,accountName,password,accountPassword, nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];

    [request setHTTPMethod:@"POST"];
    
   
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];

    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}
#pragma mark - serverConfig 信息

+(void)serverConfigRequestWithMonth:(NSString *)month SuccessBlocks:(void (^)(NSData *data, NetRequestManage *serverConfig))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *serverConfig))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,INITSERVERCONFIG]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *string = [NSString stringWithParamStr:month addSesId:nil];

    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

}
#pragma mark - 用户信息

+(void)loadUserWithUserId:(NSString *)userId successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,LOADUSER]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
/**
 *  记录页
 *
 *  @param userId       用户id
 *  @param successBlock
 *  @param failedBlock   
 */

+(void)jiluWithUserId:(NSString *)userId successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
//    TEXTSERVERROOT
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,JLDATA]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
/**
 *  提交报告
 *
 *  @param record       报告内容
 *  @param questions    问卷
 *  @param pwd          密码
 *  @param successBlock
 *  @param failedBlock
 */

+(void)reportWithUserId:(JLUserRecord *)record questionsArr:(NSArray *)questions password:(NSString *)pwd successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,SUBMITMONTHRECORD]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
   
    NSArray *keys = @[@"recordId",@"userId",@"height",@"weight",@"breastFeedingCount",@"breastFeedingMl",@"milkFeedingMl",@"daytimeSleep",@"nighttimeSleep",@"urinate",@"cacation",@"headCircumference",@"chestCircumference",@"other",@"feature",@"recordTime",@"age",@"recordStatus",@"featureList",@"questionId",@"qaList"];
    NSArray *objects = @[record.recordid,record.userid,record.height,record.weight,record.breastfeedingcount,record.breastfeedingml,record.milkfeedingml,record.daytimesleep,record.nighttimesleep,record.urinate,record.cacation,record.headcircumference,record.chestcircumference,record.other,record.feature,record.recordtime,record.age,record.recordstatus,record.featureList,record.questionid,questions];
    NSDictionary *doc0 = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSDictionary *doc = @{@"userRecord":doc0,@"sPwd":pwd};
    
    NSString *strDoc = [NSString dictionaryToJson:doc];
    

    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
/**
 *  修改父母信息
 *
 *  @param dic          父母信息
 *  @param successBlock
 *  @param failedBlock
 */
+(void)setParentWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,SETPARENT]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *strDoc = [NSString dictionaryToJson:dic];
    

    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
/**
 *  修改照养人信息
 *
 *  @param dic          信息
 *  @param successBlock
 *  @param failedBlock
 */
+(void)setCarerWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,SETCARER]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *strDoc = [NSString dictionaryToJson:dic];
    
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
+(void)joinSalonWithDictionary:(NSDictionary *)dic successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,JOINSALON]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *strDoc = [NSString dictionaryToJson:dic];
    
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}

/**
 *  修改密码
 *
 *  @param userId       用户Id
 *  @param oldPassword  旧密码
 *  @param newPassword  新密码
 *  @param successBlock
 *  @param failedBlock
 */
+(void)setPasswordWithUserId:(NSString *)userId oldPwd:(NSString *)oldPassword newPwd:(NSString *)newPassword successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,SETPWD]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = @{@"userId":userId,@"oldPwd":oldPassword,@"newPwd":newPassword};
    
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
/**
 *  重置密码
 *
 *  @param name         用户名
 *  @param email        邮箱
 *  @param successBlock
 *  @param failedBlock
 */
+(void)getPwdByAccountName:(NSString *)name andAccountEmail:(NSString *)email successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,GETPWD]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = @{@"accountName":name,@"email":email};
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}
+(void)getFeedbackSuccessBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,GETFEEDBACK]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    NSDictionary *dic =@{@"userId":[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"]};
    
    NSString *strDoc = [NSString dictionaryToJson:dic];
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}

+(void)submitFeedbackWithTextfield:(NSString *)str andPwd:(NSString *)pwd successBlocks:(void(^)(NSData *data,NetRequestManage *loadUser))successBlock andFailedBlocks:(void (^)(NSError *error,NetRequestManage *loadUser))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,SUBMITFEEDBACK]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    
    NSDictionary *dic =@{@"userId":userid,@"backContext":str,@"sPwd":pwd};
    
    NSString *strDoc = [NSString dictionaryToJson:dic];
    
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}




+(void)uploadHeadImgByUserId:(NSString *)userId andImageData:(NSData *)imageData successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    NSURLConnection *conn =[[NSURLConnection alloc]init];
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",TEXTSERVERROOT,UPLOADHEADIMG]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:@"userId",userId,@"userHead",imageData, nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    NSString *sesid;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]) {
        sesid = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    }else{
        sesid = @"";
    }
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sesid];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}






-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    
    if(self.failedBlocks){
        
        self.failedBlocks(error,self);
    }
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    
    self.resultData =[[NSMutableData alloc]init];
    
}


-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    
    [self.resultData appendData:data];
    
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
    
    if(self.successedBlocks){
        
        self.successedBlocks(self.resultData,self);
    }
}
@end
