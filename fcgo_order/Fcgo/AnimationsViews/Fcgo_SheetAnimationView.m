//
//  Fcgo_SheetAnimationView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/17.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SheetAnimationView.h"
#import "Fcgo_SheetAnimationViewTableViewCell.h"

@interface Fcgo_SheetAnimationView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView  *table;
@property (nonatomic,strong) NSArray      *titleArray;


@end

@implementation Fcgo_SheetAnimationView

+ (instancetype)sharedClient
{
    static Fcgo_SheetAnimationView *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[Fcgo_SheetAnimationView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KScreenHeight)];
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
    [self.table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SheetAnimationViewTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"sheetAnimationViewTableViewCell"];
    [self addSubview:self.table];
}

+ (void)showWithArray:(NSArray *)titleArray DidSelectedBlock:(DidSelectedBlock)didSelectedBlock
{
    Fcgo_SheetAnimationView *sheetAnimationView = [Fcgo_SheetAnimationView sharedClient];
    sheetAnimationView.titleArray = titleArray;
    sheetAnimationView.didSelectedBlock = didSelectedBlock;
    [sheetAnimationView.table reloadData];
    [[UIApplication sharedApplication].keyWindow addSubview:sheetAnimationView];
    [UIApplication sharedApplication].keyWindow.userInteractionEnabled = YES;
    
    float height = titleArray.count * kAutoWidth6(50);
    height = height+kAutoWidth6(50)+kAutoWidth6(5);
    sheetAnimationView.table.frame = CGRectMake(0, KScreenHeight, kScreenWidth, height);
    [UIView animateWithDuration:0.40
                          delay:0.0
         usingSpringWithDamping:0.75
          initialSpringVelocity:0.4
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         sheetAnimationView.table.frame = CGRectMake(0, KScreenHeight-height, kScreenWidth, height);
                     } completion:^(BOOL finished) {
                     }];
}

- (void)dismiss
{
    [self dismissBlock:nil];
}

- (void)dismissBlock:(void(^)(void))block;
{
    Fcgo_SheetAnimationView *sheetAnimationView = [Fcgo_SheetAnimationView sharedClient];
    CGRect rect =sheetAnimationView.table.frame;
    [UIView transitionWithView:sheetAnimationView.table duration:0.2 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        sheetAnimationView.table.frame = CGRectMake(0, KScreenHeight, kScreenWidth,rect.size.height );
    } completion:^(BOOL finished) {
        [sheetAnimationView removeFromSuperview];
        if (block) {
            block();
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return [self.titleArray count];
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fcgo_SheetAnimationViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sheetAnimationViewTableViewCell"];
    
    if (self.titleArray.count>0) {
        if (indexPath.section == 0)
        {
            cell.titleString = self.titleArray[indexPath.row];
            if (indexPath.row == self.titleArray.count - 1 ) {
                cell.bottomLineView.alpha = 0;
            }
            else
            {
                cell.bottomLineView.alpha = 1;
            }
        }
        else
        {
            cell.titleString =  @"取消";
            cell.bottomLineView.alpha = 0;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return kAutoWidth6(5);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 0.5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headView = [[UIView alloc]init];
    headView.backgroundColor = UIFontClearColor;
    return headView;
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
