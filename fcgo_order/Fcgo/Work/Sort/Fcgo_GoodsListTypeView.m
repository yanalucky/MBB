//
//  Fcgo_GoodsListTypeView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/6.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsListTypeView.h"
#import "HXAlbumTitleButton.h"

@interface Fcgo_GoodsListTypeView ()

@property (nonatomic,strong) UIView        *line;

@end

@implementation Fcgo_GoodsListTypeView

- (instancetype)initWithFrame:(CGRect)frame
                         rate:(void (^)(void))rateBlock
                         sale:(void (^)(NSInteger type))saleBlock
                        price:(void (^)(NSInteger type))priceBlock
                         sift:(void (^)(void))siftBlock
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIFontWhiteColor;
        self.rateBlock = rateBlock;
        self.saleBlock = saleBlock;
        self.priceBlock = priceBlock;
        self.siftBlock = siftBlock;
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    
    UIButton *rateBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [rateBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    rateBtn.frame = CGRectMake(0, 0, kScreenWidth/4, self.mj_h);
    [rateBtn setTitle:@"全部" forState:UIControlStateNormal];
    [rateBtn addTarget:self action:@selector(rateClick) forControlEvents:UIControlEventTouchUpInside];
    rateBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:rateBtn];
    
    NSArray *titleArray = @[@[@"销量",@"down_icon_arrow"],
                            @[@"价格",@"down_icon_arrow"],
                            @[@"筛选",@"filter-on@2x"]];
    for (int i = 0; i < 3; i ++) {
        HXAlbumTitleButton *titleBtn = [HXAlbumTitleButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
        [titleBtn setImage:[UIImage imageNamed:titleArray[i][1]]   forState:UIControlStateNormal];
        titleBtn.frame = CGRectMake(kScreenWidth/4*(i+1), 0, kScreenWidth/4, self.mj_h);
        [titleBtn setTitle:titleArray[i][0] forState:UIControlStateNormal];
        [titleBtn addTarget:self action:@selector(touchClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.tag = 300+i;
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:titleBtn];
    }
    [self addSubview:self.line];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
        make.bottom.mas_offset(0);
    }];
}

- (void)rateClick
{
    if(self.rateBlock){
        self.rateBlock();
    }
    
}

- (void)touchClick:(HXAlbumTitleButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.tag == 300) {
        //销量
        if(self.saleBlock){
            self.saleBlock(btn.selected);
        }
        if (!btn.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            }];
        }
        if (btn.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(M_PI );
            }];
        }
        
        
        
    }
    else if (btn.tag == 301) {
        //价格
        if(self.priceBlock){
            self.priceBlock(btn.selected);
        }
        if (!btn.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
            }];
        }
        if (btn.selected) {
            [UIView animateWithDuration:0.25 animations:^{
                btn.imageView.transform = CGAffineTransformMakeRotation(M_PI );
            }];
        }
    }
    else if (btn.tag == 302) {
        //筛选
        if(self.siftBlock){
            self.siftBlock();
        }
        
    }
}

- (UIView *)line
{
    if (!_line) {
        _line = [[UIView alloc]init];
        _line.backgroundColor =  UIRGBColor(234, 234, 234, 1);
    }
    return _line;
}

@end
