//
//  CommitVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "MatchingJobListVC.h"
#import "JobTableViewCell.h"
#import "MatchingJobListTopicTableViewCell.h"
#import "SelectButtonView.h"
#import "CompanyView.h"
#import "JobDetailVC.h"
#import "SpecialDetailVC.h"

@interface MatchingJobListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (weak, nonatomic) IBOutlet SelectButtonView *jobTypeView;
@property (weak, nonatomic) IBOutlet CompanyView *companyView;
@property (weak, nonatomic) IBOutlet SelectButtonView *salaryView;

@end

@implementation MatchingJobListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"匹配职位";
    [self.tableView registerNib:[UINib nibWithNibName:@"MatchingJobListTopicTableViewCell" bundle:nil] forCellReuseIdentifier:@"MatchingJobListTopicTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"JobTableViewCell" bundle:nil] forCellReuseIdentifier:@"JobTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self downRefreshRequest];
    [self upRefreshRequest];
    
    self.jobTypeView.buttonArr = @[@"全职",@"兼职",@"实习"];
    self.jobTypeView.titleStr = @"工作性质";
    self.jobTypeView.selectSure = ^(NSInteger index){
        SaintiLog(@"点击了第%zd个了啊",index);
    };
    self.companyView.titleStr = @[@"公司筛选",@"公司筛选1"];
    self.companyView.buttonArr = @[@[@"全部",@"未融资",@"天使轮",@"A轮",@"B轮",@"C轮",@"D轮以上",@"已上市",@"不需要融资"],@[@"全部",@"0-20人",@"20-99人",@"100-499人",@"500-999人",@"10000人以上"]];
    
    self.companyView.selectSure = ^(NSMutableArray  *selectIndexArr){
        SaintiLog(@"点击了第%@个了啊",selectIndexArr);
    };
    
    self.salaryView.buttonArr = @[@"全部",@"3K以下",@"3K-5K",@"5K-8K",@"8K-10K",@"10K-12K",@"12K-15K",@"15K以上"];
    self.salaryView.titleStr = @"薪资";
    self.salaryView.selectSure = ^(NSInteger index){
        SaintiLog(@"点击了第%zd个了啊",index);
    };
    
    [self.jobTypeView close];
    [self.salaryView close];
    [self.companyView close];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 13;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row != 2) {
        
        static NSString *identifier = @"JobTableViewCell";
        JobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        return cell;
    }else{
        /**第三条固定插入一个专题*/
        static NSString *identifier = @"MatchingJobListTopicTableViewCell";
        MatchingJobListTopicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if (indexPath.row != 2) {
        SpecialDetailVC *vc = [[SpecialDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        JobDetailVC *vc = [[JobDetailVC alloc]init];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

#pragma mark -
#pragma mark 下拉刷新
- (void)downRefreshRequest //内部方法改
{
    //    __block MyFolderVC *business = self;
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        weakSelf.page = kStartPage;
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"1022" forKey:@"businessType"];
        
        [dic setObject:[NSString stringWithFormat:@"%zd",weakSelf.page] forKey:@"page"];
        //        //GCD执行耗时操作
        //        [SendRequest startRequestWithParam:dic andFinishBlock:^(id result) {
        //            weakSelf.tableView.emptyDataSetDelegate = self;
        //            weakSelf.tableView.emptyDataSetSource = self;
        //            weakSelf.arrData = [NSMutableArray arrayWithArray:result];
        //            if (weakSelf.arrData.count < 10) {
        //                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        //
        //            }else{
        //                [weakSelf.tableView.mj_footer endRefreshing];
        //            }
        //            [weakSelf.tableView.mj_header endRefreshing];
        //            [weakSelf.tableView reloadData];
        //
        //        } andFaild:^(NSDictionary *dic) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //        }];
        
    }];
    MJHEADER;
    
    
    self.tableView.mj_header = header;
    [self.tableView.mj_header beginRefreshing];
}
#pragma mark 上拉加载
- (void)upRefreshRequest //内部方法改
{
    __weak typeof(self) weakSelf = self;
    
    MJRefreshBackGifFooter *footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
        weakSelf.page ++;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"1022" forKey:@"businessType"];
        
        [dic setObject:[NSString stringWithFormat:@"%zd",weakSelf.page] forKey:@"page"];
        //        //GCD执行耗时操作
        //        [SendRequest startRequestWithParam:dic andFinishBlock:^(id result) {
        //
        //            [weakSelf.arrData addObjectsFromArray:result];
        //            if (((NSArray *)result).count < 10) {
        //                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
        //
        //            }else{
        //                [weakSelf.tableView.mj_footer endRefreshing];
        //            }
        //            [weakSelf.tableView.mj_header endRefreshing];
        //            [weakSelf.tableView reloadData];
        //        } andFaild:^(NSDictionary *dic) {
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView.mj_footer endRefreshing];
        //        }];
        
    }];
    
    MJFOOTER;
    self.tableView.mj_footer = footer;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)typeButtonClick:(UIButton *)sender {

    if (sender.tag == 0) {
        [self.companyView close];
        [self.salaryView close];
        [self.jobTypeView changeView];
    }else if (sender.tag == 1) {
        [self.jobTypeView close];
        [self.salaryView close];
        [self.companyView changeView];
    }else if (sender.tag == 2) {
        [self.jobTypeView close];
        [self.companyView close];
        [self.salaryView changeView];
    }
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
