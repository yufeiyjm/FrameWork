//
//  HomePageVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "HomePageVC.h"
#import "JobTableViewCell.h"
#import "WorkTopicsTableViewCell.h"
#import "CommitVC.h"
#import "Q_AListVC.h"
#import "SearchVC.h"
#import "IntentJobListVC.h"

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组

@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 285)];
    topView.backgroundColor = kBlackColor;
    self.tableView.tableHeaderView = topView;
    self.navigationController.navigationBarHidden = YES;
    /**372*/
    [self.tableView registerNib:[UINib nibWithNibName:@"JobTableViewCell" bundle:nil] forCellReuseIdentifier:@"JobTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WorkTopicsTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkTopicsTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self downRefreshRequest];
    [self upRefreshRequest];


    
 

}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;self.arrData.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"JobTableViewCell";
        JobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
        
    }else{
        static NSString *identifier = @"WorkTopicsTableViewCell";
        WorkTopicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    IntentJobListVC *vc = [[IntentJobListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
