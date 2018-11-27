//
//  RickyCell.h
//  TableViewNoDataDemo
//
//  Created by 王保霖 on 15/10/28.
//  Copyright © 2015年 Ricky. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RickyCell : UITableViewCell{

    UIButton *btn;
     BOOL _sex;
    NSString *_text;
    BOOL _isme;
}
-(void)makeCellWithStr:(NSString *)str andISCustome:(BOOL)iscustom andISGirl:(BOOL)isgirl;

@end
