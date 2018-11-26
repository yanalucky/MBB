//
//  Fcgo_UpdateAnimationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/15.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_UpdateAnimationView.h"

#define Show_Width 260
@interface Fcgo_UpdateAnimationView()

@property (nonatomic,strong) UIView       *showView;
@property (nonatomic,strong) UIImageView  *topImg;
@property (nonatomic,strong) UIImageView  *bottomImg;
@property (nonatomic,strong) UILabel      *textLabel;
@property (nonatomic,strong) UIButton     *confirmBtn;
@property (nonatomic,strong) UIButton     *dismissBtn;
@property (nonatomic,copy) NSString * versionName;
@end

@implementation Fcgo_UpdateAnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self addSubview:self.showView];
    [self.showView addSubview:self.topImg];
    [self.showView addSubview:self.textLabel];
    [self.showView addSubview:self.bottomImg];
    [self.showView addSubview:self.confirmBtn];
    [self addSubview:self.dismissBtn];
}

+ (void)showWithTextString:(NSString *)textString versions:(NSString *)versionsString  isMustUpdate:(BOOL)isUpdate
{
    
    
    Fcgo_UpdateAnimationView *updateAnimationView = [[Fcgo_UpdateAnimationView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
    updateAnimationView.dismissBtn.hidden = isUpdate;
   
    updateAnimationView.versionName = versionsString;
    
    [updateAnimationView.confirmBtn setTitle:[NSString stringWithFormat:@"更新 v%@",versionsString] forState:UIControlStateNormal];
    
    NSArray *partArray = [textString componentsSeparatedByString:@"|"];
    NSMutableString *newStr = [NSMutableString new];
    for (int i = 0; i < partArray.count; i ++) {
        NSString *subStr = partArray[i];
        if (i == 0) {
            [newStr setString:subStr];
        }else{
            [newStr appendString:[NSString stringWithFormat:@"\n%@",subStr]];
        }
    }
    NSAttributedString *string = [updateAnimationView exchangeString:newStr];
    CGFloat height1 = [updateAnimationView getLableTextHeight:string width:Show_Width - 24];
    
    updateAnimationView.showView.bounds = CGRectMake(0, 0, Show_Width, (Show_Width*179/499)+(Show_Width*170/499)+40+height1);
    if (updateAnimationView.dismissBtn.hidden) {
        updateAnimationView.showView.center = CGPointMake(updateAnimationView.mj_w/2, updateAnimationView.mj_h/2);
    }
    else
    {
        updateAnimationView.showView.center = CGPointMake(updateAnimationView.mj_w/2, updateAnimationView.mj_h/2 - 31);
    }
    
    updateAnimationView.topImg.frame = CGRectMake(0, 0, updateAnimationView.showView.mj_w, Show_Width*179/499);
    //    CGFloat height = 0;
    //    NSMutableString *newStr = [NSMutableString new];
    //    for (int i = 0; i < partArray.count; i ++) {
    //        NSString *subStr = partArray[i];
    //        if (i == 0) {
    //            [newStr setString:subStr];
    //        }else{
    //            [newStr appendString:[NSString stringWithFormat:@"\n%@",subStr]];
    //        }
    //        NSAttributedString *string = [self exchangeString:subStr];
    //        CGFloat height1 = [self getLableTextHeight:string width:WIDTH(270)-35];
    //        height  = height+ height1 + 4;
    //    }
    //
    //    NSAttributedString *string = [self exchangeString:newStr];
    
    updateAnimationView.textLabel.attributedText = string;
    updateAnimationView.textLabel.frame = CGRectMake(12, updateAnimationView.topImg.mj_h + 20, updateAnimationView.showView.mj_w - 24, height1);
    
    updateAnimationView.bottomImg.frame = CGRectMake(0, updateAnimationView.textLabel.mj_h + updateAnimationView.textLabel.mj_y + 20, updateAnimationView.showView.mj_w,Show_Width*170/499);
    
    updateAnimationView.confirmBtn.frame = CGRectMake(updateAnimationView.bottomImg.mj_w/2 - 50, updateAnimationView.bottomImg.mj_h/2 + updateAnimationView.bottomImg.mj_y - 15 , 100, 30);
    updateAnimationView.dismissBtn.frame = CGRectMake(updateAnimationView.mj_w/2-16, updateAnimationView.showView.mj_h + updateAnimationView.showView.mj_y + 30, 32, 32);
    [updateAnimationView show];
    
}

- (void)show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    self.dismissBtn.alpha = 0;
    self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001f, 0.001f);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.15 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1f, 1.1f);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            __strong typeof(weakSelf)strongSelf = weakSelf;
            strongSelf.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, 1.f);
            if (!strongSelf.dismissBtn.hidden) {
                 strongSelf.dismissBtn.alpha = 1;
            }
           
        } completion:^(BOOL finished) {
             ;
        }];
    }];
}

//确认升级
- (void)confirm
{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E5%A4%87%E8%B4%A7%E9%80%9A/id1216582803?mt=8"]];
}

- (void)dismiss
{
    if(self.versionName)
    {
        [OBJC_Defaults setObject:self.versionName forKey:@"version"];
        [OBJC_Defaults synchronize];
    }
    self.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.f, 1.f);
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.2 animations:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8f, 0.8f);
        strongSelf.dismissBtn.transform = CGAffineTransformMakeRotation(M_PI);
    }completion:^(BOOL finished) {
     [weakSelf removeFromSuperview];
    }];
}

- (NSAttributedString *)exchangeString:(NSString *)string
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;// 字体的行间距
    paragraphStyle.paragraphSpacing = 5;
    
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16]//,NSFontAttributeName:
//                                     [UIFont preferredFontForTextStyle:@"Thin"],
//                                 NSParagraphStyleAttributeName:paragraphStyle
                                 };
    NSAttributedString *attributedText = [[NSAttributedString alloc] initWithString:string attributes:attributes];
    return attributedText;
}

- (CGFloat)getLableTextHeight:(NSAttributedString *)attributedString width:(CGFloat)width
{
    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    return rect.size.height;
}

- (UIView *)showView
{
    if (!_showView) {
        UIView *showView = [[UIView alloc]init];
        showView.backgroundColor = UIFontWhiteColor;
        showView.layer.cornerRadius = 10;
        showView.layer.masksToBounds = YES;
        _showView = showView;
    }
    return _showView;
}

- (UILabel *)textLabel
{
    if (!_textLabel) {
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.textColor = UIRGBColor(45, 45, 45, 1);
        textLabel.font = [UIFont systemFontOfSize:16];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.numberOfLines = 0;
        _textLabel = textLabel;
    }
    return _textLabel;
}

- (UIImageView *)topImg
{
    if (!_topImg) {
        UIImageView *topImg = [[UIImageView alloc]init];
        topImg.image = [UIImage imageNamed:@"top_update"];
        _topImg = topImg;
    }
    return _topImg;
}

- (UIImageView *)bottomImg
{
    if (!_bottomImg) {
        UIImageView *bottomImg = [[UIImageView alloc]init];
        bottomImg.image = [UIImage imageNamed:@"bottom_update"];
        _bottomImg = bottomImg;
    }
    return _bottomImg;
}

- (UIButton  *)dismissBtn
{
    if (!_dismissBtn) {
        _dismissBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [_dismissBtn setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
       [_dismissBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dismissBtn;
}

- (UIButton  *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        [btn setBackgroundColor:UIFontClearColor];
        btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        btn.layer.cornerRadius = 15;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = UIFontWhiteColor.CGColor;
        btn.layer.masksToBounds = YES;
        [btn setTitleColor:UIFontWhiteColor forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}


@end

