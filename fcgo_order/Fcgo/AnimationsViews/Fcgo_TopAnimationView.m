//
//  Fcgo_TopAnimationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_TopAnimationView.h"
#import "Fcgo_TopAnimationViewTableViewCell.h"


@interface Fcgo_TopAnimationView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *table;
@property (nonatomic,strong) UIViewController *parentVC;
@property (nonatomic,strong) NSArray      *titleArray;
@property (nonatomic,assign) NSInteger    currentIndex;

@end

@implementation Fcgo_TopAnimationView

+ (instancetype)sharedClient
{
    static Fcgo_TopAnimationView *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Fcgo_TopAnimationView alloc] initWithFrame:CGRectMake(0, kNavigationHeight, kScreenWidth, KScreenHeight - kNavigationHeight)];
    });
    return _sharedClient;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIRGBColor(0, 0, 0, 0.2);
        [self addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_TopAnimationViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"topAnimationViewTableViewCell"];
    [self addSubview:self.table];
}

+ (void)showWithVC:(UIViewController *)vc  titleArray:(NSArray *)titleArray currentSelected:(NSInteger)index DidSelectedBlock:(DidSelectedBlock)didSelectedBlock
{
    Fcgo_TopAnimationView *topAnimationView = [Fcgo_TopAnimationView sharedClient];
    topAnimationView.parentVC = vc;
    topAnimationView.titleArray = titleArray;
    topAnimationView.didSelectedBlock = didSelectedBlock;
    topAnimationView.currentIndex = index;
    [topAnimationView.table reloadData];
    
    [topAnimationView.parentVC.view addSubview:topAnimationView];
    //[UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    
    float height = titleArray.count * kAutoWidth6(50);
    //height = height+kAutoWidth6(60)+kAutoWidth6(15);
    topAnimationView.table.frame = CGRectMake(0, 0, kScreenWidth, 0);
    [UIView animateWithDuration:0.40
                          delay:0.0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         topAnimationView.table.frame = CGRectMake(0, 0, kScreenWidth, height);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)dismiss
{
    if (self.didSelectedBlock) {
        self.didSelectedBlock(self.currentIndex);
    }
    [self dismissBlock:nil];
}

- (void)dismissBlock:(void(^)(void))block;
{
    Fcgo_TopAnimationView *topAnimationView = [Fcgo_TopAnimationView sharedClient];
    [UIView transitionWithView:topAnimationView.table duration:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        topAnimationView.table.frame = CGRectMake(0, 0, kScreenWidth,0);
    } completion:^(BOOL finished) {
        [topAnimationView removeFromSuperview];
        if (block) {
            block();
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.titleArray) {
        return [self.titleArray count];
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_TopAnimationViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topAnimationViewTableViewCell"];
    
    if (self.titleArray.count>0) {
       cell.titleString = self.titleArray[indexPath.row];
    }
    if(indexPath.row == self.currentIndex)
    {
        cell.checkImageView.alpha = 1;
    }
    else
    {
        cell.checkImageView.alpha = 0;
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Fcgo_TopAnimationViewTableViewCell *deselectCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    deselectCell.checkImageView.alpha = 0;
    
    Fcgo_TopAnimationViewTableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.checkImageView.alpha = 1;
    
    self.currentIndex = indexPath.row;
    
    WEAKSELF(weakSelf);
    [self dismissBlock:^{
        if(indexPath.section == 0)
        {
            if (weakSelf.didSelectedBlock) {
                weakSelf.didSelectedBlock(indexPath.row);
            }
        }
    }];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kAutoWidth6(50);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 0.5;
}


#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table    = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        table.backgroundColor = UIFontClearColor;
        table.scrollEnabled   = 0;
        table.separatorStyle  = 0;
        table.delegate        = self;
        table.dataSource      = self;
        table.alpha           = 1;
        _table                = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}

@end
