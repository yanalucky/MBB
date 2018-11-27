//
//  FeatureTableViewCell.m
//  BabyDemo
//
//  Created by 陈彦 on 16/5/24.
//  Copyright © 2016年 elsa. All rights reserved.
//

#import "FeatureTableViewCell.h"
#import "UIImageView+WebCache.h"
#import "DetailViewController.h"


@implementation FeatureTableViewCell{
    UILabel *_title;
    BOOL _isHaveImg;
    UIImageView *_imgView;
    UIImageView *_runImg;
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeCell];
    }
    return self;
}

-(void)makeCell{
    
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 94*Ratio)];
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320*Ratio, 94*Ratio)];
    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    
    _cellButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_cellButton setBackgroundColor:[UIColor whiteColor]];
    [_cellButton setImage:[UIImage imageNamed:@"jilu_fayu_small"] forState:UIControlStateNormal];
    [_cellButton setImage:[UIImage imageNamed:@"jilu_fayu_small_set"] forState:UIControlStateSelected];
    [_cellButton setImage:[UIImage imageNamed:@"jilu_fayu_small_set"] forState:UIControlStateDisabled];

//    _cellButton.selected = NO;
    _cellButton.imageEdgeInsets = UIEdgeInsetsMake(0, -180*Ratio, 0, 0);
    
    
    [self addSubview:_cellButton];
    
    _title = [[UILabel alloc] init];
    _title.numberOfLines = 0;
    _title.font = [UIFont yaHeiFontOfSize:13*Ratio];
    _title.textColor = MBColor(102, 103, 104, 1);
    
    [self addSubview:_title];
    
    _imgView = [[UIImageView alloc] init];
    
    [self addSubview:_imgView];
    
    _runImg = [[UIImageView alloc] init];
  
    _runImg.image = [UIImage imageNamed:@"jilu_bofang"];
    [self addSubview:_runImg];

    
}





-(void)makeCellWithTitle:(NSString *)title andHaveImg:(BOOL)isHave andImg:(NSString *)image  withIsSel:(BOOL)isSel{
    _title.text = title;
    _isHaveImg = isHave;
    [_imgView sd_setImageWithURL:[NSURL URLWithString:[NSString urlStringOfImage:image]]];
    
    _cellButton.selected = isSel;
    _cellButton.imageEdgeInsets = UIEdgeInsetsMake(0, (_isHaveImg == YES)?-180*Ratio:-275*Ratio, 0, 0);
    // 视频资源路径@"http://v1.mukewang.com/a45016f4-08d6-4277-abe6-bcfd5244c201/L.mp4"
//    playView = nil;
//    playView = [FMGVideoPlayView videoPlayView];
//    // 添加到当前控制器的view上
//    [self addSubview:playView];
//    [playView setUrlString:[NSString stringWithFormat:@"%@%@",CURRENTSERVER,image]];
    
    
  
}


-(void)layoutSubviews{
    
    [_title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(43*Ratio);
        make.top.equalTo(self).offset(18*Ratio);
        make.bottom.equalTo(self).offset(-18*Ratio);
        make.right.equalTo(self).offset((_isHaveImg == YES)?(-110*Ratio):(-13*Ratio));
    }];
    
    [_imgView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-13*Ratio);
        make.bottom.equalTo(self).offset(-13*Ratio);
        make.size.mas_equalTo(CGSizeMake((_isHaveImg == YES)?(92*Ratio):(0), 69*Ratio));
    }];
    [_runImg mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-13*Ratio);
        make.bottom.equalTo(self).offset(-13*Ratio);
        make.size.mas_equalTo(CGSizeMake((_isHaveImg == YES)?(92*Ratio):(0), 69*Ratio));
    }];
    [_cellButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-1*Ratio);
        make.right.equalTo(_imgView.mas_left);
        make.top.equalTo(self);
    }];
       
 
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    //上分割线，
    //    CGContextSetStrokeColorWithColor(context, [UIColor magentaColor].CGColor); CGContextStrokeRect(context, CGRectMake(5, -1, rect.size.width - 10, 1));
    //下分割线
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:253/255.0 green:236/255.0 blue:246/255.0 alpha:1].CGColor);
    CGContextStrokeRect(context, CGRectMake(10*Ratio, rect.size.height, rect.size.width - (20*Ratio), 1*Ratio));
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
