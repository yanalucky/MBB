//
//  ErrorStatus.m
//  MBB1
//
//  Created by 陈彦 on 15/10/26.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "ErrorStatus.h"

@implementation ErrorStatus

+(NSString *)errorStatus:(NSString *)errorId{
    int num = [errorId intValue];
    NSString *str;
    switch (num)
    {
            case 8:
            str = @"修改成功";
            break;
            
            case 7:
            str = @"数据不全";
            break;
            case 6:
            str = @"您需要查看协议";
            break;
            case 5:
            str = @"您这一天没有通知哦！";
            break;
            case 1:
            
            str = @"※ 提交成功，请在一周后查看评估报告";
            break;
            case 2:
//            str = [NSString stringWithFormat:@"※ 但为了让医生准确对萌宝作出生长发育评估，请您在%@再次提交萌宝的各项记录哦~",nextTime];
            break;
            case 3:
//            str = [NSString stringWithFormat:@"※ 为了让医生准确对萌宝作出生长发育评估，请您在%@准时提交萌宝的各项记录，不要再延迟提交哦~",nextTime];

            break;
            case 4:
            
            str = [NSString stringWithFormat:@"※ 提交成功，您的记录已在评估中，请耐心等待。"];
            
            break;

        case 0:
            str = @"";
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
        case -10:
            str = @"新密码与原密码相同！";
            break;
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
        case -27:
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
            str = @"对不起，您已超过了规定的提交时间，请联系客服 021-64335531";
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
            str = @"对不起，您的合同已到期，请联系客服 021-64335531";
            break;
        case -114://套餐即将失效
            str = @"您的线上提交次数已使用完，如果想继续使用服务请续费";
            break;
        case -115://套餐已经失效
            str = @"您的线上提交次数已使用完，如果想继续使用服务请续费";
            break;
        case -116:
            str = @"角色修改联系人信息错误";
            break;
        case -200:
            str = @"空参数";
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
        case -305:
            str = @"短信超上限";
            //数据库
        case -500:
            str = @"数据库插入数据失败";
            break;
        case -501:
            str = @"数据库获取在线月记录规则失败";
            break;
            
        case -50:
            str = @"输入的校验码与发送验证码不一致";
            break;
        case -51:
            str = @"校验码为空";
            break;
        case -52:
            str = @"未发送校验码";
            break;
        case -53:
            str = @"手机号格式有误";
            break;
        case -54:
            str = @"注册账号已存在";
        default:
            break;
    }
    return str;
}


@end
