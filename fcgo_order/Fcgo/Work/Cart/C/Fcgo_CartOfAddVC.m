//
//  Fcgo_CartOfAddVC.m
//  Fcgo
//
//  Created by fcg on 2017/10/16.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_CartOfAddVC.h"
#import "Fcgo_CartVC.h"
#import "Fcgo_AddressView.h"
#import "HXAlbumTitleButton.h"

@interface Fcgo_CartOfAddVC ()

@property (nonatomic,strong)  Fcgo_CartVC *vc;
@property(nonatomic , strong) HXAlbumTitleButton *titleBtn;
@property(nonatomic , strong) UIImageView *addImg;
@property (nonatomic,strong)  Fcgo_AddressView *addressView;
@property (nonatomic,strong)  NSMutableArray   *addressListArray;
@property (nonatomic,strong)  Fcgo_AddressModel*selectedAddressModel;

@end

@implementation Fcgo_CartOfAddVC
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadRequestAddress];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _vc = [[Fcgo_CartVC alloc] init];
    _vc.haveNavBar = YES;
    _vc.isNotTabbar = self.isNotTabbar;
    WEAKSELF(weakSelf)
    _vc.refreshBlock = ^{
        [weakSelf loadRequestAddress];
    };
    [self.view addSubview:_vc.view];
    if (!self.isNotTabbar) {
        [_vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.top.equalTo(self.view).offset(kNavigationSubY(64));
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(- kTabBarHeight - kTabBarBottomMargin);
        }];
    }
    else{
        [_vc.view mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(self.view);
            make.top.equalTo(self.view).offset(kNavigationSubY(64));
            make.centerX.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(- kTabBarBottomMargin);
        }];
    }
    
    
    
    [self addChildViewController:_vc];
    [self setNavView];
    [self setAddressView];
}
#pragma mark 地址选择

-(void)setAddressView
{
    WEAKSELF(weakSelf)
    _addressView = [[Fcgo_AddressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight) title:@"选择地区" isCanAddAddress:NO successBlock:^(Fcgo_AddressModel *model) {
        weakSelf.isSelected = NO;
        weakSelf.selectedAddressModel = model;
        [weakSelf.view layoutIfNeeded];
        if(!self.isNotTabbar)
        {
            weakSelf.tabBarController.tabBar.hidden = NO;
        }
        
        
    } cancelBlock:^{
        weakSelf.isSelected = NO;
        if(!self.isNotTabbar)
        {
            weakSelf.tabBarController.tabBar.hidden = NO;
        }
    }];
    [self.view addSubview:_addressView];
    _addressView.hidden = YES;
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo(weakSelf.view);
        make.center.equalTo(weakSelf.view);
    }];
    
}

- (void)loadRequestAddress
{
    WEAKSELF(weakSelf)
    NSMutableDictionary  *muatble = [NSMutableDictionary dictionary];
    [Fcgo_NetworkManager postRequest:NSFormatHeardMeThodUrl(ServiceLocalTypeOne,ADDRESSMETHOD, @"storeAddressList") parametersContentCommon:muatble successBlock:^(BOOL success, id responseObject, NSString *msg) {
        if (success) {
            [weakSelf.addressListArray removeAllObjects];
            weakSelf.selectedAddressModel = nil;
            NSArray  *listArray = responseObject[@"data"];
            if (!listArray || listArray.count<=0) {
                [WSProgressHUD showImage:nil status:@"获取地址错误"];
                return ;
            }
            for (int i = 0; i < listArray.count; i++) {
                NSMutableDictionary *dic = listArray[i];
                Fcgo_AddressModel *model = [Fcgo_AddressModel yy_modelWithDictionary:dic];
                [weakSelf.addressListArray addObject:model];
                if ([[dic objectForKey:@"deFault"] intValue] == 1) {
                    if (!weakSelf.selectedAddressModel) {
                        weakSelf.selectedAddressModel = model;
                    }
                }
            }
            if (!weakSelf.selectedAddressModel) {
                weakSelf.selectedAddressModel = weakSelf.addressListArray[0];
            }
            weakSelf.addressView.dataArray = weakSelf.addressListArray;
        }
        
    } failureBlock:^(NSString *description) {
        
    }];
}

- (void)setSelectedAddressModel:(Fcgo_AddressModel *)selectedAddressModel
{
    _selectedAddressModel = selectedAddressModel;
    if (!selectedAddressModel) {
        return;
    }
    _vc.selectedAddressModel = selectedAddressModel;
    [_vc postRequestCartList];
    [self.titleBtn setTitle:[NSString stringWithFormat:@"%@",selectedAddressModel.addressDetail]    forState:UIControlStateNormal];
    [self.titleBtn setTitle:[NSString stringWithFormat:@"%@",selectedAddressModel.addressDetail]   forState:UIControlStateSelected];
    [self.titleBtn layoutIfNeeded];
}

#pragma mark 设置导航栏

-(void)setNavView
{
    WEAKSELF(weakSelf)
    HXAlbumTitleButton *titleBtn = [HXAlbumTitleButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitleColor:UIFontMainGrayColor forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"down_icon_arrow"]   forState:UIControlStateNormal];
    titleBtn.lineBreakMode = NSLineBreakByTruncatingMiddle;
    [titleBtn addTarget:self action:@selector(addressChoose:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationView addSubview:self.titleBtn = titleBtn];
    if(!self.isNotTabbar)
    {
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(27);
            make.centerX.mas_equalTo(self.navigationView.mas_centerX
                                    ).mas_offset(8);
            make.width.mas_lessThanOrEqualTo(kScreenWidth-60);
            make.height.mas_offset(30);
        }];
        UIImageView *addImg = [[UIImageView alloc] init];
        addImg.image = [UIImage imageNamed:@"icon_-red--position"];
        [self.navigationView addSubview:self.addImg = addImg];
        [addImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(titleBtn.mas_left).mas_offset(-5);
            make.size.mas_equalTo(CGSizeMake(16, 16));
            make.centerY.equalTo(titleBtn);
        }];
    }
    else{
        [self.navigationView setupBackBtnBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
        [self.navigationView setupTitleBoldFontLabelWithTitle:@"购物车"];
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(27);
            make.right.mas_offset(-10);
            make.height.mas_offset(30);
            make.width.mas_lessThanOrEqualTo(kScreenWidth/2-45);
        }];
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)showUIData:(BOOL)isShow
{
    [self showNoControl:!isShow titleString:@"网络错误,点击重新加载" imageString:@"ico_no-wifi"];
}

-(void)addressChoose:(HXAlbumTitleButton *)btn
{
    if (![Fcgo_Tools isNetworkConnected]) {
        [WSProgressHUD showImage:nil status:@"亲,没联网啊"];
        [self showUIData:NO];
        return;
    }
    btn.selected = !btn.selected;
    [UIView animateWithDuration:0.25 animations:^{
            btn.imageView.transform = CGAffineTransformMakeRotation(M_PI);
    }];
    [_addressView show];
    self.tabBarController.tabBar.hidden = YES;
}

- (void)setIsSelected:(BOOL)isSelected
{
    self.titleBtn.selected = isSelected;
    [UIView animateWithDuration:0.25 animations:^{
        self.titleBtn.imageView.transform = CGAffineTransformMakeRotation(M_PI * 2);
    }];
}

- (NSMutableArray *)addressListArray
{
    if (!_addressListArray) {
        _addressListArray = [[NSMutableArray alloc]init];
    }
    return _addressListArray;
}

@end
