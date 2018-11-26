//
//  Fcgo_NoLogisticsDetailCell.m
//  Fcgo
//
//  Created by by_r on 2017/9/30.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_NoLogisticsDetailCell.h"

@interface Fcgo_NoLogisticsDetailCell()
@property (nonatomic, strong) UILabel   *tipLabel;
@property (nonatomic, strong) UILabel   *urlLabel;
@end

@implementation Fcgo_NoLogisticsDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self setupUI];
    }
    return self;
}

- (void)tapUrlLabel {
    if (self.expressUrl.length && [self.expressUrl hasPrefix:@"http://"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.expressUrl]];
    }
}

- (void)setName:(NSString *)name url:(NSString *)url {
    _expressUrl = url;
    self.urlLabel.text = [NSString stringWithFormat:@"%@: %@",name, url];
}

- (void)setupUI {
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = tipLogisticsStr;
    tipLabel.textColor = UIFontMainGrayColor;
    tipLabel.font = UIFontSize(14);
    tipLabel.numberOfLines = 0;
    [self.contentView addSubview:tipLabel];
    self.tipLabel = tipLabel;
    
    UILabel *urlLabel = [UILabel new];
    urlLabel.textColor = [UIColor blueColor];
    urlLabel.font = UIFontSize(14);
    urlLabel.numberOfLines = 0;
    urlLabel.userInteractionEnabled = YES;
    [self.contentView addSubview:urlLabel];
    self.urlLabel = urlLabel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapUrlLabel)];
    [urlLabel addGestureRecognizer:tap];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-20);
    }];
    [urlLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tipLabel);
        make.right.mas_equalTo(-20).priorityLow();
        make.top.mas_equalTo(tipLabel.mas_bottom).offset(10);
        make.bottom.mas_equalTo(-10);
    }];
}

+ (CGFloat)getHeightWithText:(NSString *)string {
    CGFloat height = [string boundingRectWithSize:CGSizeMake(kScreenWidth - 40, 1000) options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:UIFontSize(14)} context:nil].size.height;
    return height;
}

@end
