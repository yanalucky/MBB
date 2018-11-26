//
//  Fcgo_SortLeftTableView.m
//  Fcgo
//
//  Created by huafanxiao on 2017/5/23.
//  Copyright © 2017年 huafanxiao. All rights reserved.
//

#import "Fcgo_SortLeftTableView.h"
#import "Fcgo_SortLeftTableViewCell.h"


@interface Fcgo_SortLeftTableView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView    *table;
@property (nonatomic,assign) NSInteger      currentIndex;

@end

@implementation Fcgo_SortLeftTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
         
        [self addSubview:self.table];
        
        UIView *rightLineView = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-1, 0, 1, frame.size.height)];
        rightLineView.backgroundColor = UISepratorLineColor;
        [self addSubview:rightLineView];
    }
    return self;
}

- (void)setSortArray:(NSMutableArray *)sortArray
{
    _sortArray = sortArray;
    [self.table reloadData];
}

#pragma mark table delegate datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sortArray.count>0) {
        return self.sortArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Fcgo_SortLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"sortLeftTableViewCell"];
    if (self.sortArray && self.sortArray.count>0) {
        Fcgo_SortModel *model = self.sortArray[indexPath.row];
        cell.titleString = model.sort_name;
    }
    if (self.currentIndex == indexPath.row) {
        cell.isSelected = 1;
    }else{
        cell.isSelected = 0;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return kAutoWidth6(55);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.currentIndex == indexPath.row) {
        return;
    }
    Fcgo_SortLeftTableViewCell *deselectCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.currentIndex inSection:0]];
    deselectCell.isSelected = 0;
    
    Fcgo_SortLeftTableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    selectCell.isSelected = 1;
    
    self.currentIndex = indexPath.row;
    
     Fcgo_SortModel *model = self.sortArray[indexPath.row];
    if (self.didSelectedBlock) {
        self.didSelectedBlock(model);
    }
}

#pragma mark Lazy method

- (UITableView *)table
{
    if (!_table) {
        UITableView *table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.mj_w-1, self.mj_h) style:UITableViewStylePlain];
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = 0;
        table.showsVerticalScrollIndicator = 0;
        table.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [table registerNib:[UINib nibWithNibName:NSStringFromClass([Fcgo_SortLeftTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"sortLeftTableViewCell"];
        _table = table;
        if (@available(iOS 11.0, *)) {
            table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _table;
}
@end
