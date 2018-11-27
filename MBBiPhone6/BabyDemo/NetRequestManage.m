

#import "NetRequestManage.h"
#import "CYAlertView.h"


@implementation NetRequestManage
#pragma mark - 版本
+(void)vesionUpdateSuccessBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETVERSION]];
    
    //创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSString *string = [NSString stringWithParamStr:nil addSesId:nil];
    
    [request setHTTPMethod:@"POST"];
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}
#pragma mark - 注册验证码
+(void)sendMessageWithPhone:(NSString *)phoneNumber successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,SENDMESSAGE]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:phoneNumber addSesId:sessionId];
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    

    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    

}

#pragma mark - 修改密码——验证码
+(void)sendResetPasswordMessageWithPhone:(NSString *)phoneNumber successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,SENDRESETPWDMESSAGE]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:phoneNumber addSesId:sessionId];
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}
#pragma mark - 注册校验
+(void)registerCheckWithAccountName:(NSString *)accountName andLoginPwd:(NSString *)pwd andCode:(NSString *)code andCheckCode:(NSString *)checkCode successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,REGISTERCHECK]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:accountName,@"accountMobile",pwd,@"loginPwd",code,@"code",checkCode,@"checkCode", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

}


+(void)saveNewPwdWithAccountName:(NSString *)accountName andLoginPwd:(NSString *)pwd andCode:(NSString *)code andCheckCode:(NSString *)checkCode successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,SAVENEWPWD]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:accountName,@"accountMobile",pwd,@"loginPwd",code,@"code",checkCode,@"checkCode", nil];
    NSLog(@"saveNewPwdDoc = %@",doc);
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    
    [request setHTTPMethod:@"POST"];
    
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

    
    
}
#pragma mark - 注册初始化
+(void)loadRegisterSuccessBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,LOADREGISTER]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];

    [request setHTTPMethod:@"POST"];


    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

}
+(void)babyUserRegisterWithAccountName:(NSString *)name andMenuId:(NSString *)menuid andHospitalId:(NSString *)hospitalid andDoctorId:(NSString *)doctorId andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,BABYUSERREGISTER]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"accountMobile",menuid,@"menuid",hospitalid,@"hospitalid",doctorId,@"doctorid",dic,@"userRecord", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    [request setHTTPMethod:@"POST"];
    
    
    
   

    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

}

+(void)webUserRegisterWithAccountName:(NSString *)name andPwd:(NSString *)pwd andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,WEBUSERREGISTER]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"accountMobile",pwd,@"loginPwd",dic,@"userRecord", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

    
    
}


#pragma mark - 登录
+(void)LoginRequestAccountName:(NSString *)name andAccountPassword:(NSString *)password successBlocks:(void (^)(NSData * data,NetRequestManage *load))successBlock andfailedBlocks:(void (^)(NSError *error, NetRequestManage *load))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,LOGIN]];
    //第二步，创建请求
   NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *accountName = @"accountMobile";
    NSString *accountPassword = @"loginPwd";
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:name,accountName,password,accountPassword, nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:nil];

    [request setHTTPMethod:@"POST"];
    
   
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];

    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
}
#pragma mark - serverConfig 信息

+(void)serverConfigRequestWithMonth:(NSString *)month SuccessBlocks:(void (^)(NSData *data, NetRequestManage *serverConfig))successBlock andFailedBlocks:(void (^)(NSError *error, NetRequestManage *serverConfig))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,INITSERVERCONFIG]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:month,@"age",[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"],@"userId", nil];
    NSLog(@"doc = %@",doc);
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];

    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];

    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc]initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

}



+(void)webUserInitServerConfigureWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,WEBUSERINITSERVERCONFIGURE]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    

    
}
#pragma mark - 首页


+(void)loadHomeWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
   
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,LOADHOME]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器

    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }


    
}


#pragma mark - 日历点击事件
+(void)clickDateTimeWithChooseTime:(NSString *)time andUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,CLICKDATETIME]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
 
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:time,@"chooseTime",userId,@"userId", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];

    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

    
}


#pragma mark - 日历中历史消息记录

+(void)clickHistoryRecordWithChooseTime:(NSString *)time andUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,CLICKHISTORYRECORD]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:time,@"chooseTime",userId,@"userId", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    
    
}
#pragma mark - 记录
+(void)getRecordStarWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETRECORDSTAR]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

    
    
}
#pragma mark - 养育指导

+(void)getNurtureGuideWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETNURTUREGUIDE]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}
#pragma mark - 提交记录
+(void)submitMonthRecordWithUserRole:(NSString *)userRole andUserRecordDic:(NSDictionary *)dic successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andfailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,SUBMITMONTHRECORD]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:userRole,@"userRole",dic,@"userRecord", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:[[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"]];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

}

+(void)getOnlineAppraisalWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETONLINEAPPRAISAL]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
}




+(void)getCurrentMenuWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETCURRENTMEMU]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }

}
+(void)getTheLastMenuWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETTHELASTMENU]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    
    
}

+(void)saveUserWithUserId:(NSString *)userId andBabyInfoDic:(NSDictionary *)babyInfoDic successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,SAVEUSER]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:userId,@"userId",babyInfoDic,@"babyInfo", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];

    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

    
}
+(void)editLinkmanWithUserId:(NSString *)userId andLinkmanInfoDic:(NSDictionary *)linkmanInfoDic successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,EDITLINKMAN]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:userId,@"userId",linkmanInfoDic,@"linkmanInfo", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    

}


+(void)editPwdWithUserId:(NSString *)userId andOldPwd:(NSString *)oldPwd andNewPwd:(NSString *)pwd successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,EDITPWD]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:userId,@"userId",oldPwd,@"oldPwd",pwd,@"newPwd", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    
    

    
}



+(void)saveBeforeRecordWithUserId:(NSString *)userId andUserRole:(NSString *)userRole andNeedInsertBeforeRecordArr:(NSArray *)needInsertBeforeRecord isBreakMonth:(BOOL)isBreakMonth successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,(isBreakMonth == YES)?SAVEBREAKMONTHRECORD:SAVEBEFORERECORD]];
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    NSDictionary *doc = [[NSDictionary alloc] initWithObjectsAndKeys:userId,@"userId",userRole,@"userRole",needInsertBeforeRecord,@"needInsertBeforeRecord", nil];
    NSString *strDoc = [NSString dictionaryToJson:doc];
    
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    NSString *string = [NSString stringWithParamStr:strDoc addSesId:sessionId];
    
    [request setHTTPMethod:@"POST"];
    
    
    //把拼接后的字符串转换为data，设置请求体
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
    
    if (conn) {
        manage.resultData = [NSMutableData data];
    }
    

}

+(void)getBreakMonthsWithUserId:(NSString *)userId successBlocks:(void (^)(NSData *, NetRequestManage *))successBlock andFailedBlocks:(void (^)(NSError *, NetRequestManage *))failedBlock{
    
    
    
    NetRequestManage *manage =[[NetRequestManage alloc]init];
    manage.successedBlocks = successBlock;
    manage.failedBlocks = failedBlock;
    
    //第一步，创建URL
    
    NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,GETBREAKMONTHS]];
    
    //第二步，创建请求
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    NSString *sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:@"sessionId"];
    
    
    NSString *string = [NSString stringWithParamStr:userId addSesId:sessionId];
    
    
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[string dataUsingEncoding:NSUTF8StringEncoding]];
    
    //把拼接后的字符串转换为data，设置请求体
    
    
    //第三步，连接服务器
    
    
    //第三步，连接服务器
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:manage];
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
