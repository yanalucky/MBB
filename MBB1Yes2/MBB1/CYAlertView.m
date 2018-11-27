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

@implementation CYAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        
        
        AppDelegate *delegate = [UIApplication sharedApplication].delegate;
       _sex = delegate.sex;
        if (_sex == ISBOY) {
            self.backgroundColor = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:0.5];
            
        }else{
            self.backgroundColor = [UIColor colorWithRed:25/255.0 green:190/255.0 blue:217/255.0 alpha:0.5];
        }
        
        
        self.userInteractionEnabled = YES;
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    self.hidden = YES;
    for (int i=0; i<[self.subviews count]; i++) {
        UIView *ve = self.subviews[i];
        [ve removeFromSuperview];
    }
    
 
    
    
}


/*
-(void)layoutSubviews{
    _alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.window.frame.size.width - _alertWidth)/2, (self.window.frame.size.height - _alertHeight)/2, _alertWidth, _alertHeight)];
    _alert.backgroundColor = [UIColor whiteColor];
    _alert.layer.masksToBounds = YES;
    _alert.layer.cornerRadius = 12;
    _alert.alpha = 1;
    
    
    UIImageView *header = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
    header.image = [UIImage imageNamed:@"jilu-error" ofSex:_sex];
    [_alert addSubview:header];
    
    
    UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header.frame.size.height+header.frame.origin.y + 15, _alert.frame.size.width-20, 30)];
    
    labe.text = [ErrorStatus errorStatus:self.errorStatus parmStr:nil];
    labe.textColor = _wordColor;
    labe.textAlignment = NSTextAlignmentCenter; 
    labe.font = [UIFont yaHeiFontOfSize:17];
    labe.numberOfLines = 0;
    
    [_alert addSubview:labe];
    
    
    
    [self addSubview:_alert];
    
    
    

    
    

}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
