//
//  ErrorStatus.m
//  MBB1
//
//  Created by 陈彦 on 15/10/26.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "ErrorStatus.h"

@implementation ErrorStatus

+(NSString *)errorStatus:(NSString *)errorId parmStr:(NSString *)nextTime{
    int num = [errorId intValue];
    NSString *str;
    switch (num)
    {
        case 2:
            if (nextTime) {
                str = [NSString stringWithFormat:@"提交成功，请下次在%@提交，以保证评估准确性",nextTime];
            }else{
                str = @"";
            }
            
            break;
        case 1:
            str = @"提交成功，请在一周后查看评估及养育指导";
            break;
        case 0:
            str = @"提交成功，请在一周后查看评估及养育指导";
            break;
            //服务器
        case -1:
            str = @"服务器正在维护";
            break;
        case -2:
            str = @"服务器没有响应";
            break;
        case -3:
            str = @"服务器繁忙";
            break;
        case -4:
            str = @"服务器人数已满";
            break;
            //申请账号
        case -11:
            str = @"非法的角色名";
            break;
        case -12:
            str = @"角色名太短";
            break;
        case -13:
            str = @"角色名太长";
            break;
        case -14:
            str = @"非法的密码";
            break;
        case -15:
            str = @"密码太短";
            break;
        case -16:
            str = @"密码太长";
            break;
        case -17:
            str = @"注册初始化角色部位失败";
            break;
        case -18:
            str = @"账号已存在";
            break;
        case -19:
            str = @"账号已存在";
            break;
            //登陆
        case -20:
            str = @"密码错误";
            break;
        case -21:
            str = @"账号不存在";
            break;
        case -22:
            str = @"账号名为空";
            break;
        case -23:
            str = @"密码为空";
            break;
        case -24:
            str = @"账号禁用";
            break;
        case -25:
            str = @"账号合同已到期";
            break;
        case -26:
            str = @"账号合同未开始";
            break;
        case -900:
            str = @"登陆超时，角色需重新登录";
            break;
            //角色
        case -100:
            str = @"角色获得失败";
            break;
        case -101:
            str = @"角色获取当月在线记录数据错误";
            break;
        case -102:
            str = @"对不起，您已超过了规定的提交时间，请联系客服 400-876-6060";
            break;
        case -103:
            str = @"角色提交反馈失败";
            break;
        case -104:
            str = @"角色提交密码错误";
            break;
        case -105:
            str = @"角色提交绑定邮箱错误";
            break;
        case -106:
            str = @"角色修改父母信息错误";
            break;
        case -107:
            str = @"角色修改照养人信息错误";
            break;
        case -108:
            str = @"抱歉，提交日未到，不能提交。";
            break;
        case -109:
            str = @"角色头像上传失败";
            break;
        case -110:
            str = @"角色体检次数到达上限";
            break;
        case -111:
            str = @"角色治疗次数到达上限";
            break;
        case -112:
            str = @"角色沙龙次数到达上限";
            break;
            //客户端
        case -113:
            str = @"对不起，您的合同已到期，请联系客服 400-876-6060";
            break;
        case -114://套餐即将失效
            str = @"线上服务已结束，请联系客服 400-876-6060 续费";
            break;
        case -115://套餐已经失效
            str = @"线上服务已结束，请联系客服 400-876-6060 续费";
            break;
        case -200:
            str = @"客户端空参数";
            break;
        case -201:
            str = @"客户端参数格式错误";
            break;
        case -202:
            str = @"客户端参数数目错误";
            break;
            //其他
        case -300:
            str = @"未知错误";
            break;
        case -301:
            str = @"没有相应的缓存数据";
            break;
        case -302:
            str = @"非法操作";
            break;
        case -303:
            str = @"网络延迟";
            break;
        case -304:
            str = @"错误的数据结构";
            break;
            //数据库
        case -500:
            str = @"数据库插入数据失败";
            break;
        case -501:
            str = @"数据库获取在线月记录规则失败";
            break;
        default:
            break;
    }
    return str;
}


@end
