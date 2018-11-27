//
//  CYOverRunView.m
//  MBB1
//
//  Created by 陈彦 on 15/11/26.
//  Copyright © 2015年 elsa. All rights reserved.
//

#import "CYOverRunView.h"
#import "AppDelegate.h"
@implementation CYOverRunView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
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
        
//        self.backgroundColor = [UIColor redColor];
        self.userInteractionEnabled = YES;
        UIImageView *_alert = [[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - 400)/2, (self.frame.size.height - 150)/2, 400, 150)];
        _alert.backgroundColor = [UIColor whiteColor];
        _alert.layer.masksToBounds = YES;
        _alert.layer.cornerRadius = 10;
        _alert.alpha = 1;
        
        
        UIImageView *header00 = [[UIImageView alloc] initWithFrame:CGRectMake((_alert.frame.size.width - 50)/2, (_alert.frame.size.height-49)/2-30, 50, 49)];
        header00.image = [UIImage imageNamed:@"jilu-error" ofSex:self.sex];
        
        [_alert addSubview:header00];
        
        
        UILabel *labe = [[UILabel alloc] initWithFrame:CGRectMake(10, header00.frame.size.height+header00.frame.origin.y + 15, _alert.frame.size.width-20, 50)];
        
        labe.text = @"登录超时，请重新登录！";
        labe.textColor = BOY_WORDCOLOR;
        labe.textAlignment = NSTextAlignmentCenter;
        labe.font = [UIFont yaHeiFontOfSize:16];
        labe.numberOfLines = 2;
        
        [_alert addSubview:labe];
        
        
        
        [self addSubview:_alert];
        
        
    }
    return self;
}
-(void)createAlertView{
    
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    
    self.hidden = YES;
    if (self.clickBlocks) {
        self.clickBlocks();
    }
        
}

@end
