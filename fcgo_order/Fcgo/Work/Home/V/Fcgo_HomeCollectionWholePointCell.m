//
//  Fcgo_HomeCollectionWholePointCell.m
//  Fcgo
//
//  Created by huafanxiao on 2017/6/1.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_HomeCollectionWholePointCell.h"
#import "Fcgo_HomeCollectionWholePointGoodsCell.h"
#import "Fcgo_HomeWholePointGoodsFooterView.h"
#import "Fcgo_WholePointGoodsModel.h"

@interface Fcgo_HomeCollectionWholePointCell()<UICollectionViewDelegate,UICollectionViewDataSource>
{
   
}

@property (strong, nonatomic) UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *saleImg;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *leftHourLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftHourColon;//小时后面的冒号
@property (weak, nonatomic) IBOutlet UILabel *leftMinLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftMinColon;
@property (weak, nonatomic) IBOutlet UILabel *leftSedLabel;//秒
@property (weak, nonatomic) IBOutlet UILabel *leftMilliSecondColon;
@property (weak, nonatomic) IBOutlet UILabel *leftMilliSecondLabel;




@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@property (weak, nonatomic) IBOutlet UIButton *moreBtn;


@end

@implementation Fcgo_HomeCollectionWholePointCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshLessTime) name:@"countdown1" object:nil];
    [self setupUI];
}

- (void)setupUI
{
    WEAKSELF(weakSelf);
    
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.height.mas_offset(kAutoWidth6(250));
        make.right.mas_offset(0);
    }];
    
    [self.saleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(kAutoWidth6(10));
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.height.mas_offset(kAutoWidth6(140)*42/338);
        make.width.mas_offset(kAutoWidth6(140));
    }];
    
    //整点抢购
    self.titleLabel.font = UIFontSacleSize(14);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.top.mas_equalTo(weakSelf.saleImg.mas_bottom).mas_offset(kAutoWidth6(10));
    }];
    //分后面的冒号约束
    self.leftMinColon.textColor = UIFontWhiteColor;
    self.leftMinColon.font = UIFontSacleSize(14);
    [self.leftMinColon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.titleLabel.mas_bottom).mas_offset(kAutoWidth6(10));
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.height.mas_offset(kAutoWidth6(17));
        make.width.mas_offset(kAutoWidth6(7));
    }];
    //分约束
    self.leftMinLabel.font = UIFontSacleSize(14);
    self.leftMinLabel.backgroundColor = UIFontWhiteColor;
    self.leftMinLabel.textColor = UIFontSortGrayColor;
    self.leftMinLabel.layer.cornerRadius = 2;
    self.leftMinLabel.layer.masksToBounds = YES;
    [self.leftMinLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.leftMinColon.mas_left).mas_offset(-3);
        make.height.mas_offset(kAutoWidth6(23));
        make.width.mas_offset(kAutoWidth6(23));
        make.centerY.mas_equalTo(weakSelf.leftMinColon.mas_centerY);
    }];
    //时后面的冒号约束
    self.leftHourColon.font = UIFontSacleSize(14);
    [self.leftHourColon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(weakSelf.leftMinLabel.mas_left).mas_offset(-3);
        make.centerY.mas_equalTo(weakSelf.leftMinLabel.mas_centerY);;
        make.height.mas_offset(kAutoWidth6(16));
        make.width.mas_offset(kAutoWidth6(7));
    }];
    
    //时约束
    self.leftHourLabel.font = UIFontSacleSize(14);
    self.leftHourLabel.backgroundColor = UIFontWhiteColor;
    self.leftHourLabel.textColor = UIFontSortGrayColor;
    self.leftHourLabel.layer.cornerRadius = 2;
    self.leftHourLabel.layer.masksToBounds = YES;
    [self.leftHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.leftMinLabel.mas_centerY);
        make.right.mas_equalTo(weakSelf.leftHourColon.mas_left).mas_offset(-3);
        make.height.mas_offset(kAutoWidth6(23));
        make.width.mas_offset(kAutoWidth6(23));
    }];
    
    //秒的约束
    self.leftSedLabel.font = UIFontSacleSize(14);
    self.leftSedLabel.backgroundColor = UIFontWhiteColor;
    self.leftSedLabel.textColor = UIFontSortGrayColor;
    self.leftSedLabel.layer.cornerRadius = 2;
    self.leftSedLabel.layer.masksToBounds = YES;
    [self.leftSedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftMinColon.mas_right).mas_offset(3);
        make.height.mas_offset(kAutoWidth6(23));
        make.width.mas_offset(kAutoWidth6(23));
        make.centerY.mas_equalTo(weakSelf.leftMinColon.mas_centerY);
    }];
    
    
    self.leftMilliSecondColon.font = UIFontSacleSize(14);
    [self.leftMilliSecondColon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.leftSedLabel.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(weakSelf.leftSedLabel.mas_centerY);;
        make.height.mas_offset(kAutoWidth6(17));
        make.width.mas_offset(kAutoWidth6(7));
    }];
    
    
    self.leftMilliSecondLabel.font = UIFontSacleSize(14);
    self.leftMilliSecondLabel.backgroundColor = UIFontRedColor;
    self.leftMilliSecondLabel.textColor = UIFontWhiteColor;
    self.leftMilliSecondLabel.layer.cornerRadius = 2;
    self.leftMilliSecondLabel.layer.masksToBounds = YES;
    [self.leftMilliSecondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weakSelf.leftMinLabel.mas_centerY);
        make.left.mas_equalTo(weakSelf.leftMilliSecondColon.mas_right).mas_offset(3);
        make.height.mas_offset(kAutoWidth6(23));
        make.width.mas_offset(kAutoWidth6(23));
    }];
    self.leftLabel.font = UIFontSacleSize(12);
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.leftHourLabel.mas_bottom);
        make.right.mas_equalTo(weakSelf.leftHourLabel.mas_left).mas_offset(-3);
    }];
    
    self.rightLabel.font = UIFontSacleSize(12);
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(weakSelf.leftMilliSecondLabel.mas_bottom);
        make.left.mas_equalTo(weakSelf.leftMilliSecondLabel.mas_right).mas_offset(3);
    }];
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_HomeCollectionWholePointGoodsCell class]) bundle:nil] forCellWithReuseIdentifier:@"homeCollectionWholePointGoodsCell"];
    [self.collectionView registerClass:[Fcgo_HomeWholePointGoodsFooterView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeWholePointGoodsFooterView"];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(weakSelf.leftHourLabel.mas_bottom).mas_offset(kAutoWidth6(10));
        make.height.mas_offset(kAutoWidth6(115));
    }];
    
    //查看约束的约束
    self.moreBtn.backgroundColor = UIFontClearColor;
    self.moreBtn.titleLabel.font = UIFontSacleSize(12);
    self.moreBtn.layer.cornerRadius = 2;
    self.moreBtn.layer.borderWidth = 0.5;
    self.moreBtn.layer.borderColor = UIFontWhiteColor.CGColor;
    self.moreBtn.layer.masksToBounds = YES;
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.collectionView.mas_bottom).mas_offset(kAutoWidth6(11));
        make.centerX.mas_equalTo(weakSelf.contentView.mas_centerX);
        make.height.mas_offset(kAutoWidth6(20));
        make.width.mas_offset(kAutoWidth6(70));
    }];
}

- (void)setWholePointModel:(Fcgo_HomeWholePointModel *)wholePointModel
{
    _wholePointModel = wholePointModel;
    self.leftLabel.text = [NSString stringWithFormat:@"%@场将在",wholePointModel.name];
    [self.collectionView setContentOffset:CGPointMake(0, 0)];
    [self.collectionView reloadData];
}

- (void)refreshLessTime
{
    WEAKSELF(weakSelf);
    if (!self.wholePointModel) {
        return;
    }
    NSDate* serverDate = [NSDate dateWithTimeIntervalSinceNow:self.wholePointModel.time_interval];
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:self.wholePointModel.end.doubleValue/1000];
    
    NSTimeInterval timeInterval = [endDate timeIntervalSinceDate:serverDate];
    long long timeout = timeInterval*100;
    if(timeout<0){ //倒计时结束，关闭
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.wholePointModel = nil;
            //倒计时完成。用block回调刷新表格
            if (weakSelf.timeFinishBlock) {
                weakSelf.timeFinishBlock();
            }
        });
    }else{
        int days = (int)(timeout/(360000*24));
        int hours = (int)((timeout-days*24*360000)/360000);
        int minutes = (int)(timeout-days*24*360000-hours*360000)/6000;
        int seconds = ((int)timeout-days*24*360000-hours*360000-minutes*6000)/100;
        int mills  = ((int)timeout-days*24*360000-hours*360000-minutes*6000 - seconds *100)/10;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSString *hour = nil;
            NSString *mintue = nil;
            NSString *second = nil;
            
            int hour_s = hours+ (days*24);
            if (hour_s<10) {
                hour = [NSString stringWithFormat:@"0%d",hour_s];
            }else{
                hour = [NSString stringWithFormat:@"%d",hour_s];
            }
            weakSelf.leftHourLabel.text = hour;
            if (minutes<10) {
                mintue = [NSString stringWithFormat:@"0%d",minutes];
            }else{
                mintue = [NSString stringWithFormat:@"%d",minutes];
            }
            weakSelf.leftMinLabel.text = mintue;
            if (seconds<10) {
                second = [NSString stringWithFormat:@"0%d",seconds];
            }else{
                second = [NSString stringWithFormat:@"%d",seconds];
            }
            weakSelf.leftSedLabel.text = second;
            weakSelf.leftMilliSecondLabel.text = [NSString stringWithFormat:@"%d",mills];
        });
        timeout--;
    }
}

- (IBAction)goMore:(UIButton *)sender
{
    if (self.pushWholePointDetailVC) {
        self.pushWholePointDetailVC();
    }
}

#pragma mark CollectionView delegate dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.wholePointModel) {
        return self.wholePointModel.datas.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_HomeCollectionWholePointGoodsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homeCollectionWholePointGoodsCell" forIndexPath:indexPath];
    
    
    if (self.wholePointModel)
    {
        Fcgo_WholePointGoodsModel *model = self.wholePointModel.datas[indexPath.item];
        cell.model = model;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pushWholePointDetailVC) {
        self.pushWholePointDetailVC();
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((kScreenWidth - kAutoWidth6(50))/4,kAutoWidth6(115));
    //return CGSizeMake(0,0);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionFooter) {
        Fcgo_HomeWholePointGoodsFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"homeWholePointGoodsFooterView" forIndexPath:indexPath];
        [footerView addSubview:footerView.arrowImageView];
        [footerView.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.centerY.mas_equalTo(footerView.mas_centerY);
            make.width.height.mas_offset(15);
        }];
        
        [footerView addSubview:footerView.titleLabel];
        [footerView.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.right.mas_offset(-12);
        }];
        return footerView;
    }
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (self.wholePointModel && self.wholePointModel.datas.count>3) {
        return CGSizeMake(47, collectionView.mj_h) ;
    }
    return CGSizeMake(0, collectionView.mj_h) ;
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumInteritemSpacing = kAutoWidth6(10);
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, kAutoWidth6(10), 0, kAutoWidth6(10));
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        //collectionView.backgroundColor = UIFontRedColor;
        collectionView.showsHorizontalScrollIndicator = 0;
        _collectionView = collectionView;
        if (@available(iOS 11.0, *)) {
            collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _collectionView;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    CGFloat offset_x = scrollView.contentOffset.x;
    if (offset_x > scrollView.contentSize.width - kScreenWidth+60) {
        if (self.pushWholePointDetailVC) {
            self.pushWholePointDetailVC();
        }
       
    }
}

@end
