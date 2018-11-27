//
//  YYZDViewController.m
//  MBB
//
//  Created by 陈彦 on 15/9/1.
//  Copyright (c) 2015年 elsa. All rights reserved.
//

#import "YYZDViewController.h"
#import "AppDelegate.h"
#import "UIImageView+WebCache.h"
#import "YYZDTableViewCell.h"

@interface YYZDViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UIColor *wordColor;
    UIColor *bgColor;
    UITableView *_tableView;
    NSMutableArray *dataArr;
    NSArray *nurtureGuide;
    int number;
    LoginUserNurtureGuideList *guide;
    UILabel *title;
    UIView *view;
    UIView *whiteView;
    UILabel *tishiLabel;
    
    UILabel *line;
}

@end

@implementation YYZDViewController

-(void)viewWillAppear:(BOOL)animated{
    for (int i=0; i<_buttonArr.count; i++) {
        UIButton *button = (UIButton *)[view viewWithTag:250+i];
        button.selected = NO;
    }
    UIButton *button = (UIButton *)[view viewWithTag:250];
    button.selected = YES;
    number = 0;
    if (nurtureGuide.count != 0) {
        guide = nurtureGuide[number];
        [dataArr removeAllObjects];
        [dataArr addObject:guide];
    }
    
    [_tableView reloadData];
    
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.report > 1) {
        whiteView.hidden = YES;
        
    }else if(delegate.report == 1){
        tishiLabel.text = @"养育指导将在一周后反馈，请您耐心等待";
        whiteView.hidden = NO;
        
        
        line.hidden = YES;
    }else if (delegate.report == 0){
        tishiLabel.text = @"您需要先提交记录，医生才能制定个性化的养育指导";
        whiteView.hidden = NO;
        
        line.hidden = YES;
    }


}

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    self.sex = delegate.sex;
    if (self.sex == YES) {
        wordColor = BOY_WORDCOLOR;
        bgColor = BOY_RIGHTVIEWCOLOR;
    }else{
        wordColor = GIRL_WORDCOLOR;
        bgColor = GIRL_RIGHTVIEWCOLOR;
    }
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/loadUser.plist"];
    if ([manager fileExistsAtPath:path]) {
        NSData *data = [NSData dataWithContentsOfFile:path];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        LoginUserNSObject *user = [[LoginUserNSObject alloc] initWithDictionary:dic];
        if (user.result) {
            if (user.result.nurtureGuideList) {
                nurtureGuide = user.result.nurtureGuideList;
                
                
            }
        }
        
        
    }else{
        NSLog(@"路径不存在！");
    }
    number = 0;
    
    
    _buttonArr = [[NSMutableArray alloc] init];
    /**
     *  假数据
     */
    if (nurtureGuide.count>0) {
        guide = nurtureGuide[number];
        [_buttonArr addObjectsFromArray:nurtureGuide];
        dataArr = [[NSMutableArray alloc] init];
    [dataArr addObject:guide];
    }
    
    
    
    
   

    
    [self createUI];
    
    // Do any additional setup after loading the view.
}
-(void)createUI{
    
    
    int i=0;
    int width = 0;
    view = [[UIView alloc] initWithFrame:CGRectMake(298, 65, self.view.frame.size.width-298, 100)];
    view.tag = 288;
    if (_buttonArr.count != 0) {
        for (LoginUserNurtureGuideList *nurture in _buttonArr) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(width, 0, 80, 100);
            [button setTitle:nurture.nurturename forState:UIControlStateNormal];
            button.tag = 250+i;
            [button setTitleColor:WORDDARKCOLOR forState:UIControlStateNormal];
            [button setTitleColor:wordColor forState:UIControlStateSelected];
            [button setTitleColor:wordColor forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont yaHeiFontOfSize:22];
            CGSize size = [button.titleLabel sizeThatFits:CGSizeMake(300, 100)];
            
            button.frame = CGRectMake(button.frame.origin.x, button.frame.origin.y, size.width+30,100);
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [view addSubview:button];
            
            if (i==0) {
                button.selected = YES;
            }
            width = width + size.width + 30;
            i++;
            view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y,width, view.frame.size.height);
        }

    }
    view.frame = CGRectMake((self.view.frame.size.width-175-view.frame.size.width-30)/2+175, view.frame.origin.y, view.frame.size.width, view.frame.size.height);
//    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    
    
    line = [[UILabel alloc] initWithFrame:CGRectMake(175, 144, 826, 1.5)];
    line.backgroundColor = wordColor;
    [self.view addSubview:line];
    
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(183, 174, self.view.frame.size.width-183-45, self.view.frame.size.height-174-10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    [_tableView registerClass:[YYZDTableViewCell class] forCellReuseIdentifier:@"str"];
    [self.view addSubview:_tableView];
    whiteView = [[UIView alloc] initWithFrame:_tableView.frame];
    whiteView.backgroundColor = [UIColor whiteColor];
    UIImageView *doctorHeader = [[UIImageView alloc] initWithFrame:CGRectMake((whiteView.frame.size.width-194)/2-10, (whiteView.frame.size.height-194)/2-150, 194, 194)];
    doctorHeader.image = [UIImage imageNamed:@"doctor"];
    [whiteView addSubview:doctorHeader];
    
    tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, doctorHeader.frame.origin.y + doctorHeader.frame.size.height + 20, whiteView.frame.size.width, 40)];
    tishiLabel.textAlignment = NSTextAlignmentCenter;
    tishiLabel.font = [UIFont yaHeiFontOfSize:18];
    tishiLabel.textColor = wordColor;
    [whiteView addSubview:tishiLabel];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    if (delegate.report > 1) {
        whiteView.hidden = YES;
    }else if(delegate.report == 1){
        tishiLabel.text = @"养育指导将在一周后反馈，请您耐心等待";
        whiteView.hidden = NO;
    }else if (delegate.report == 0){
        tishiLabel.text = @"您需要先提交记录，医生才能制定个性化的养育指导";
        whiteView.hidden = NO;
    }
    [self.view addSubview:whiteView];
    
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 64)];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 44)];
    label.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    NSString *str;
    if (number == 0) {
        str = @"一、";
    }else if (number == 1){
        str = @"二、";
    }else if (number == 2){
        str = @"三、";
    }else if (number == 3){
        str = @"四、";
    }else if (number == 4){
        str = @"五、";
    }else if (number == 5){
        str = @"六、";
    }else if (number == 6){
        str = @"七、";
    }else if (number == 7){
        str = @"八、";
    }else if (number == 8){
        str = @"九、";
    }else if (number == 9){
        str = @"十、";
    }
    if (dataArr.count != 0) {
        LoginUserNurtureGuideList *nurture = dataArr[0];
        
        label.text = [NSString stringWithFormat:@"%@%@",str,nurture.nurturename];
        label.textColor = wordColor;
        [view addSubview:label];

    }
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    }
    else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *str = @"str";
    YYZDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    LoginUserDetaillist *detail;
    
    
    if (dataArr.count != 0) {
        LoginUserNurtureGuideList *nurture = dataArr[0];
        detail = nurture.detaillist[indexPath.row];
    }
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YYZDTableViewCell" owner:self options:nil] lastObject];
    }
    

//    cell.textLabel.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
//   
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];
//    cell.textLabel.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,detail.appraisaltitle];
//    cell.detailTextLabel.text = detail.appraisalcontent;
//    cell.textLabel.font = [UIFont yaHeiFontOfSize:22];
//    cell.textLabel.textColor = wordColor;
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.detailTextLabel.textColor = WORDDARKCOLOR;
//    cell.detailTextLabel.font = [UIFont yaHeiFontOfSize:20];
    
    
    [cell makeCellWithModel:detail andSex:self.sex];
    cell.title.text = [NSString stringWithFormat:@"%ld、%@",indexPath.row+1,detail.appraisaltitle];
   
//    CGRect frame = cell.detail.frame;
//    frame.size.height = 200;
//    cell.detail.frame = frame;
    
    
    
    
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    
//    cell.title.frame = CGRectMake(0, 0, tableView.frame.size.width, 30);
////    cell.title.text = detail.appraisaltitle;
//    cell.title.font = [UIFont yaHeiFontOfSize:22];
//    cell.title.textColor = wordColor;
//    NSMutableAttributedString *attributedString0 = [[NSMutableAttributedString alloc]initWithString:cell.title.text];;
//    NSMutableParagraphStyle *paragraphStyle0 = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle0 setLineSpacing:30];
//    [attributedString0 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle0 range:NSMakeRange(0, cell.title.text.length)];
//    cell.title.attributedText = attributedString0;
//    
//    
//    cell.detail.text = detail.appraisalcontent;
//    cell.detail.textColor = WORDDARKCOLOR;
//    cell.detail.font = [UIFont yaHeiFontOfSize:20];
//    cell.detail.numberOfLines = 0;
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:cell.detail.text];;
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:10];
//    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, cell.detail.text.length)];
//    cell.detail.attributedText = attributedString;
//    CGRect rect = [detail.appraisalcontent boundingRectWithSize:CGSizeMake(769, 20000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont yaHeiFontOfSize:20] forKey:NSFontAttributeName] context:nil];
//    cell.detail.frame = CGRectMake(14, 35, rect.size.width, rect.size.height);
//    
//    cell.detail.backgroundColor = [UIColor yellowColor];
//    if (detail.imgurl.length > 0) {
//        cell.imageV.frame = CGRectMake(0, cell.detail.frame.origin.y+ cell.detail.frame.size.height + 10, 360, 270);
//        NSURL *url = [NSURL URLWithString:[NSString urlStringOfImage:detail.imgurl]];
//        [cell.imageV sd_setImageWithURL:url];
//        
//        
//    }
//    
//    cell.backgroundColor = [UIColor colorWithRed:arc4random()%256/255.0 green:arc4random()%256/255.0 blue:arc4random()%256/255.0 alpha:1];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (dataArr.count != 0) {
        LoginUserNurtureGuideList *nur = dataArr[0];
        NSArray *arr =  nur.detaillist;
        return [arr count];

    }else{
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataArr.count != 0) {
        LoginUserNurtureGuideList *nurture = dataArr[0];
        LoginUserDetaillist *detail = nurture.detaillist[indexPath.row];

        CGRect rect = [detail.appraisalcontent boundingRectWithSize:CGSizeMake(tableView.frame.size.width, 2000) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObject:[UIFont yaHeiFontOfSize:20] forKey:NSFontAttributeName] context:nil];
        if (detail.imgurl.length > 0) {
            return rect.size.height + (rect.size.height/20+1)*10 + 20 + 270;

        }else{ 
            return rect.size.height + (rect.size.height/30+1)*10 + 60;

        }
    }else{
        return 0;
    }
   
}


-(void)buttonClick:(UIButton *)button{
    NSArray *subViews = [self.view viewWithTag:288].subviews;
    for (id sub in subViews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *butt = (UIButton *)sub;
            butt.selected = NO;
        }
    }
    button.selected = YES;
    number = button.tag-250;
    if (nurtureGuide.count != 0) {
        guide = nurtureGuide[number];
        [dataArr removeAllObjects];
        [dataArr addObject:guide];
    }
   
    [_tableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
