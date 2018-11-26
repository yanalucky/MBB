//
//  Fcgo_LaunchAdTools.m
//  Fcgo
//
//  Created by by_r on 2017/9/25.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

/* 广告处理逻辑
 1.必须要有用户ID才可以请求，所以必须登录之后才弹
 2.根据请求到的地区，与用户信息中的地区比较，比较优先级：区>市>省>全国
 3.要求服务器更换图片之后，客户端要实时展示，所以在此不对缓存做其他处理
 4.点击图片，要根据信息进行跳转
 */


#import <FLAnimatedImage/FLAnimatedImage.h>
#import "Fcgo_LaunchAdTools.h"
#import "Fcgo_HomeAdModel.h"

/// 序列化路径、文件名
static NSString *const adPath       = @"Documents/adImagePath";

@interface Fcgo_LaunchAdTools()
@property (nonatomic, strong) UIView                *bgView;    ///< 底部背景
@property (nonatomic, strong) FLAnimatedImageView   *animatedImageView; ///< 动态、静态图展示
@property (nonatomic, strong) UILabel               *countLabel; ///< 倒计时标签
@property (nonatomic, strong) UIButton              *jumpButton; ///< 跳过按钮
@property (nonatomic, strong) dispatch_source_t     timer; ///< 定时器
@property (nonatomic, strong) Fcgo_HomeAdModel      *model; ///< 读取序列化对象
@property (nonatomic,strong) NSString              *jsonStr;
@end

@implementation Fcgo_LaunchAdTools
+ (instancetype)sharedInstance {
    static Fcgo_LaunchAdTools *shared = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shared = [[Fcgo_LaunchAdTools alloc] init];
    });
    return shared;
}

//- (UIViewController *)viewController {
//    return ((UINavigationController *)([UIApplication sharedApplication].keyWindow.rootViewController)).topViewController;
//}

- (void)show {
    Fcgo_HomeAdModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:adPath]];
    self.model = model;

    [self judgeForUI];
    [self downloadAdContent];
}

- (void)hidden {
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.bgView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.bgView removeFromSuperview];
        _bgView = nil;
        _animatedImageView = nil;
        _countLabel = nil;
        _jumpButton = nil;
        _timer = nil;
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    }];
}

/// 配置UI
- (void)setupUI {
    if (!_bgView) {
        [[self getCurrentVC].view addSubview:self.bgView];
        [self.bgView addSubview:self.animatedImageView];
        [self.bgView addSubview:self.countLabel];
        [self.bgView addSubview:self.jumpButton];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self.animatedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
        [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.right.mas_equalTo(-12);
        }];
        [self.jumpButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(60, 27.5));
            make.bottom.and.right.mas_equalTo(-12);
        }];
    }
    [self setValueForUI];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 执行动作
    [self countDownAction];
}

// 倒计时
- (void)countDownAction {
    __block int timeout = 4;
    [self setAttributedText:@(timeout).stringValue];
    // 获取全局队列
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    // 创建定时器
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, global);
    // 设置触发的间隔时间    1.0 时间间隔1s    0 误差0s
    dispatch_source_set_timer(_timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    WEAKSELF(weakSelf);
    // 设置定时器的触发事件
    dispatch_source_set_event_handler(_timer, ^{
        timeout --;
        if (timeout <= 0) {
            dispatch_async(dispatch_get_main_queue(), ^{
               [weakSelf jumpAction];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
               [weakSelf setAttributedText:@(timeout).stringValue];
            });
        }
    });
    dispatch_resume(_timer);
}

/// 跳过
- (void)jumpAction {
    // 关闭定时器
    dispatch_source_cancel(_timer);
    [self hidden];
}

// 点击广告图
- (void)tapAction {
    // TODO: tap event
    if (!self.animatedImageView.image && !self.animatedImageView.animatedImage) {
        return;
    }
    
    
   
    
    if (self.model && self.model.hrefMobile.length) {
        
        
        BOOL ret = [Fcgo_App_acrossTools app_acrossWithJsonString:self.model.hrefMobile webView:nil parentVC:[self getCurrentVC]];
        if (!ret) {
            [self jumpAction];
        }
    }
}


- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

/// 下载图片，存储数据
- (void)downloadAdContent {
    NSString *merId = [NSString stringWithFormat:@"%@",MerId];
    if (!merId.length) {
        return;
    }
    NSMutableDictionary   *paremtes = [NSMutableDictionary dictionary];
    [paremtes  setObjectWithNullValidate:merId forKey:@"id"];
    WEAKSELF(weakSelf);
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne, ADVERTMethod, @"merchantAdvertisement") parametersContentCommon:paremtes successBlock:^(BOOL success, id responseObject, NSString *msg) {
        NSDictionary *dataDic = nil;
        if (success) {
            if ([responseObject isKindOfClass:[NSArray class]]) {
                dataDic = [responseObject firstObject];
            }
            else {
                dataDic = responseObject[@"data"];//[@"data"];
            }
            NSString * pictureStr = dataDic[@"picurlMobile"];
            
            if (![pictureStr isKindOfClass:[NSNull class]] && pictureStr.length>0 && dataDic) {
                // 如果新网址和本地网址不一致，则更新缓存
//                if (![pictureStr isEqualToString:weakSelf.model.f_picurl_mobile]) {
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        NSData *imageData = nil;
                        // 通过缓存判断图片，可以避免图片过大，下载耗时而出现白屏
                        if ([pictureStr isEqualToString:weakSelf.model.picurlMobile]) {
                            imageData = weakSelf.model.picurl_data;
                        } else {
                            imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:pictureStr]];
                        }
                        
                        if (imageData.length) {
                            Fcgo_HomeAdModel *obj = [Fcgo_HomeAdModel yy_modelWithDictionary:dataDic];
                            obj.picurl_data = imageData;
                            obj.picurlMobile = pictureStr;
//                            if (!weakSelf.model) {
                                weakSelf.model = obj;
//                                dispatch_async(dispatch_get_main_queue(), ^{
////                                    if (!_bgView) {
////                                        [weakSelf judgeForUI];
////                                    } else {
//                                        [weakSelf setValueForUI];
////                                    }
//                                });
////                            }
                            
                            BOOL ret = [NSKeyedArchiver archiveRootObject:obj toFile:[NSHomeDirectory() stringByAppendingPathComponent:adPath]];
                        }
                    });
//                }
            }
        }
        if (!dataDic.count) {
            Fcgo_HomeAdModel *obj = [[Fcgo_HomeAdModel alloc] init];
            [NSKeyedArchiver archiveRootObject:obj toFile:[NSHomeDirectory() stringByAppendingPathComponent:adPath]];
        }
    } failureBlock:^(NSString *description) { }];
}
/// 判断
- (void)judgeForUI {
//    if (model && model.picurl_data.length) {
        // 暂时登录之后弹出
        if ([Fcgo_UserTools shared].isLogin == 1 && self.model) {
            
            ![self judgeArea] ?: [self setupUI];
        }
//    }
}
- (BOOL)judgeArea {
    NSDictionary *userDict = [Fcgo_UserTools shared].userDict;
    NSString *province = userDict[@"storeProvince"];
    NSString *city = userDict[@"storeCity"];
    NSString *area = userDict[@"storeArea"];
    if (area.length && self.model.areaId.length && ![area isEqualToString:self.model.areaId]) {
        return NO;
    }
    if (city.length && self.model.cityId.length && ![city isEqualToString:self.model.cityId]) {
        return NO;
    }
    if (province.length && self.model.provinceId.length && ![province isEqualToString:self.model.provinceId]) {
        return NO;
    }
    if (!self.model.picurl_data.length) {
        return NO;
    }
    return YES;
}
/// 赋值
- (void)setValueForUI {
//    if (![self judgeArea]) {
//        return;
//    }
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:self.model.picurl_data];
    // 判断：如果不是GIF，则判断为其他图片格式
    if (animatedImage) {
        self.animatedImageView.animatedImage = animatedImage;
    } else {
        UIImage *image = [UIImage imageWithData:self.model.picurl_data];
        self.animatedImageView.image = image;
    }
}

// 设置倒计时文本
- (void)setAttributedText:(NSString *)text {
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"剩余%@秒",text]];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:UIRGBColor(250, 109, 166, 1) range:NSMakeRange(2, 1)];
    self.countLabel.attributedText = attributeStr;
}

#pragma mark - lazy load
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = ({
            UIView *v = [[UIView alloc] init];
            v.backgroundColor = UIFontWhiteColor;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
            [v addGestureRecognizer:tap];
            v;
        });
    }
    return _bgView;
}

- (FLAnimatedImageView *)animatedImageView {
    if (!_animatedImageView) {
        _animatedImageView = ({
            FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            imageView;
        });
    }
    return _animatedImageView;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.textColor = UIRGBColor(85, 85, 85, 1);
            label.font = [UIFont systemFontOfSize:12];
            label;
        });
    }
    return _countLabel;
}

- (UIButton *)jumpButton {
    if (!_jumpButton) {
        _jumpButton = ({
            UIButton *jumpBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
            [jumpBtn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
            [jumpBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
            [jumpBtn setBackgroundColor:UIRGBColor(198, 198, 198, 1)];
            jumpBtn.layer.masksToBounds = YES;
            jumpBtn.layer.cornerRadius = 15;
            [jumpBtn addTarget:self action:@selector(jumpAction) forControlEvents:UIControlEventTouchUpInside];
            jumpBtn;
        });
    }
    return _jumpButton;
}
@end
