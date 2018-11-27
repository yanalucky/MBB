//
//  CYAlertView.m
//  MBB1
//
//  Created by 陈彦 on 15/11/10.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import "CYAlertView.h"
#import "AppDelegate.h"
#import "ErrorStatus.h"

@implementation CYAlertView{
    UILabel *_message;
    
    NSString *_statusStr;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:125/255.0 green:20/255.0 blue:120/255.0 alpha:0];
        
        _message = [[UILabel alloc] init];
        _message.layer.masksToBounds = YES;
        _message.layer.cornerRadius = 5*Ratio;
        _message.backgroundColor = MBColor(126, 127, 128, 1);
        _message.textColor = [UIColor whiteColor];
        _message.textAlignment = NSTextAlignmentCenter;
        _message.font = [UIFont yaHeiFontOfSize:10*Ratio];
        [self addSubview:_message];
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)showStatus:(NSString *)errorStatus{
    
    [self.window bringSubviewToFront:self];
    NSString *errorStr = [ErrorStatus errorStatus:errorStatus];
    
    _statusStr = errorStr;
    
    _message.text = errorStr;

    
}



-(void)layoutSubviews{
    
    NSMutableDictionary *attri = [[NSMutableDictionary alloc] init];
    attri[NSFontAttributeName] = [UIFont yaHeiFontOfSize:10*Ratio];
    CGRect rect = [_statusStr boundingRectWithSize:CGSizeMake(177*Ratio, 30*Ratio) options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil];
    [_message mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(30*Ratio);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(rect.size.width + (42*Ratio));
        make.bottom.equalTo(self).offset(-120*Ratio);
    }];
    

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (self.hidden == NO) {
        self.hidden = YES;
        [self.window sendSubviewToBack:self];
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
