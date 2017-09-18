//
//  DateSignListVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/16.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "DateSignListVC.h"
#import "DateSignTableViewCell.h"
#import "MakeDateSignVC.h"

@interface DateSignListVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ViewpointLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLabel;

@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *collectButton;
@end

@implementation DateSignListVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    self.navigationItem.title = @"话题列表";
    self.navigationController.navigationBarHidden = YES;
    self.shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    self.collectButton.titleEdgeInsets = UIEdgeInsetsMake(0, 12, 0, 0);
    self.contentLabel.text = @"绝对是拉法基阿圣诞快乐飞机ask了对方就是带宽拉法基是打开冷风机ask冷风机sad开发了静安寺了；撒娇的废卡类似点击反馈萨拉丁；附件卡里是交房；萨迪克冷风机ask冷风机ask冷风机ask冷风机；按时浪费；大家付了款；电视剧啊绝对是拉法基阿圣诞快乐飞机ask了对方就是带宽拉法基是打开冷风机ask冷风机sad开发了静安寺了；撒娇的废卡类似点击反馈萨拉丁；附件卡里是交房；萨迪克冷风机ask冷风机ask冷风机ask冷风机；按时浪费；大家付了款；电视剧啊绝对是拉法基阿圣诞快乐飞机ask了对方就是带宽拉法基是打开冷风机ask冷风机sad开发了静安寺了；撒娇的废卡类似点击反馈萨拉丁；附件卡里是交房；萨迪克冷风机ask冷风机ask冷风机ask冷风机；按时浪费；大家付了款；电视剧啊";
    [self.contentLabel sizeToFit];
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, 317 + self.contentLabel.mj_h - 20);
    self.tableView.tableHeaderView = self.topView;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DateSignTableViewCell" bundle:nil] forCellReuseIdentifier:@"DateSignTableViewCell"];
    self.tableView.estimatedRowHeight = 83.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self downRefreshRequest];
    [self upRefreshRequest];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 14;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 83;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"DateSignTableViewCell";
    DateSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    
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
- (IBAction)makeDateSignClick:(id)sender {
    MakeDateSignVC *vc = [[MakeDateSignVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
