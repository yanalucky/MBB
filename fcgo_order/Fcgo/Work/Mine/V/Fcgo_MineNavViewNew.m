//
//  Fcgo_MineNavViewNew.m
//  Fcgo
//
//  Created by by_r on 2017/10/19.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_MineNavViewNew.h"

@interface Fcgo_MineNavViewNew()
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIButton  *settingButton;
@property (nonatomic, strong) UIButton  *messageButton;
@end

@implementation Fcgo_MineNavViewNew

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIFontClearColor;
        [self setupUI];
    }
    return self;
}

- (void)btnAction:(UIButton *)sender {
    if (self.touchType) {
        self.touchType(sender.tag);
    }
}

- (void)setBgAlpha:(float)bgAlpha {
    self.titleLabel.hidden = (bgAlpha <= 0.7);
    NSString *settNamed = @"ico_white_setting", *msgNamed = @"icon_white_msg_home";
    if (bgAlpha > 0.7) {
        settNamed = @"icon_black_setting";
        msgNamed = @"icon_black_msg_home";
    }
    [self.settingButton setImage:[UIImage imageNamed:settNamed] forState:UIControlStateNormal];
    [self.messageButton setImage:[UIImage imageNamed:msgNamed] forState:UIControlStateNormal];
}

- (void)setTitleString:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - UI
- (void)setupUI {
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setImage:[UIImage imageNamed:@"ico_white_setting"] forState:UIControlStateNormal];
    settingButton.tag = kHeadTouchType_setting;
    [settingButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:settingButton];
    _settingButton = settingButton;
    
    UIButton *messageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageButton setImage:[UIImage imageNamed:@"icon_white_msg_home"] forState:UIControlStateNormal];
    messageButton.tag = kHeadTouchType_message;
    [messageButton addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:messageButton];
    _messageButton = messageButton;
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.font = [UIFont boldSystemFontOfSize:17];
    titleLabel.textColor = UIFontBlackColor;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.hidden = YES;
    titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
    
    _titleLabel.text =  @"昵称";//[Fcgo_UserTools shared].userDict[@"storeName"];
    
    
    // layout UI
    {
        [settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(12);
            make.top.mas_offset(kNavigationSubY(30));
        }];
        [messageButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-12);
            make.top.equalTo(settingButton);
        }];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(kNavigationSubY(20));
            make.centerX.mas_equalTo(self);
            make.height.mas_equalTo(44);
            make.left.mas_offset(70);//mas_equalTo(settingButton.mas_right).priorityLow();
            make.right.mas_offset(-70);//.mas_equalTo(messageButton.mas_left).priorityLow();
        }];
    }
}

@end
