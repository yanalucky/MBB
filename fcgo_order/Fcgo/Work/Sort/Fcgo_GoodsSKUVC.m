//
//  Fcgo_GoodsSKUVC.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/20.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_GoodsSKUVC.h"
#import "Fcgo_GoodsSKUView.h"


@interface Fcgo_GoodsSKUVC ()
@property (nonatomic,strong) UIControl         *touchControl;
@property (nonatomic,strong) Fcgo_GoodsSKUView *skuView;
@end

@implementation Fcgo_GoodsSKUVC

- (void)setInfoModel:(Fcgo_GoodsInfoModel *)infoModel
{
    _infoModel = infoModel;
    self.skuView.infoModel = infoModel;
}

- (void)setBestSKUModel:(Fcgo_BestSKUModel *)bestSKUModel
{
    _bestSKUModel = bestSKUModel;
    self.skuView.bestSKUModel = bestSKUModel;
}

- (void)setGoodsType:(NSString *)goodsType
{
    _goodsType = goodsType;
    self.skuView.goodsType = goodsType;
}

- (void)setAttrArray:(NSMutableArray *)attrArray
{
    _attrArray = attrArray;
    self.skuView.attrArray = attrArray;
}

- (void)setSaveAttrArray:(NSMutableArray *)saveAttrArray
{
    _saveAttrArray = saveAttrArray;
    self.skuView.saveAttrArray = saveAttrArray;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.touchControl];
    [self.view addSubview:self.skuView];
    
    
    WEAKSELF(weakSelf);
   
    self.skuView.selectAttrItemBlock = ^(NSString *properties_name,NSString *attr,BOOL isSelected,NSInteger count)
    {
        weakSelf.selectAttrItemBlock(properties_name,attr,isSelected,count);
    };
    
    self.skuView.selectCountBlock = ^(NSInteger count) {
        if (weakSelf.selectCountBlock) {
            weakSelf.selectCountBlock(count);
        }
        
    };
    
    
    self.skuView.confirmBlock = ^{
        [weakSelf confirm];
    };
    
    self.skuView.dismissBlock = ^{
         [weakSelf confirm];
    };
    self.skuView.lowerPriceBlock = ^{
        weakSelf.lowerPriceBlock();
    };
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    WEAKSELF(weakSelf)
    weakSelf.touchControl.hidden = 0;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.skuView.frame = CGRectMake(0, KScreenHeight-kAutoWidth6(440), kScreenWidth, kAutoWidth6(440));
    }completion:nil];
}

- (void)confirm
{
    WEAKSELF(weakSelf)
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.skuView.frame =  CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(440));
    }completion:^(BOOL finished) {
        weakSelf.touchControl.hidden = 1;
        [weakSelf.view removeFromSuperview];
        [weakSelf removeFromParentViewController];
    }];
}

- (UIControl *)touchControl
{
    if (!_touchControl) {
        UIControl *control = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
        control.backgroundColor = UIRGBColor(0, 0, 0, 0.55);
        [control addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        control.hidden = 1;
        _touchControl = control;
    }
    return _touchControl;
}

- (Fcgo_GoodsSKUView *)skuView
{
    if (!_skuView) {
        _skuView = [[Fcgo_GoodsSKUView alloc]initWithFrame:CGRectMake(0, KScreenHeight, kScreenWidth, kAutoWidth6(440))];
    }
    return _skuView;
}

@end
