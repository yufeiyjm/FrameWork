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
#import "Q_AListVC.h"
#import "SearchVC.h"
#import "MatchingJobListVC.h"
#import "IntentJobListVC.h"
#import "MySelfVC.h"
#import "MessageListVC.h"

@interface HomePageVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (weak, nonatomic) IBOutlet UIView *cirque;
@property (weak, nonatomic) IBOutlet UIView *circelBackView;

@property (strong, nonatomic) IBOutlet UIView *topView;
@end

@implementation HomePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, 372);
    self.tableView.tableHeaderView = self.topView;
    self.navigationController.navigationBarHidden = YES;
    /**372*/
    [self.tableView registerNib:[UINib nibWithNibName:@"JobTableViewCell" bundle:nil] forCellReuseIdentifier:@"JobTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WorkTopicsTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkTopicsTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self downRefreshRequest];
    [self upRefreshRequest];


    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 10;
    //圆环的颜色
    layer.strokeColor = UIColorFromRGB(0x1AB1C0).CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //设置半径为10
    CGFloat radius = 60;
    //按照顺时针方向
    BOOL clockWise = true;
    SaintiLog(@"%f----%f",self.cirque.center.x,self.cirque.center.y);
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(78 , 78 - 1 ) radius:radius startAngle:(2*M_PI) endAngle:3.3*M_PI clockwise:clockWise];
    layer.path = [path CGPath];
    [self.circelBackView.layer addSublayer:layer];
 

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;self.arrData.count;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]init];
    aView.backgroundColor = UIColorFromRGB(0xE5EDEE);
    return aView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *aView = [[UIView alloc]init];
    aView.backgroundColor = UIColorFromRGB(0xE5EDEE);
    return aView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
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
        cell.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg"];
        if (indexPath.row == 0) {
            cell.topTitleHeight.constant = 26;
        }else{
            cell.topTitleHeight.constant = 0;
        }
        return cell;
    }
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    Q_AListVC *vc = [[Q_AListVC alloc]init];
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
#pragma mark ------搜索
- (IBAction)searchButtonClick:(id)sender {
    SearchVC *vc = [[SearchVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------消息
- (IBAction)messageButtonClick:(id)sender {
    
    MessageListVC *vc = [[MessageListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------我的
- (IBAction)mineButtonClick:(id)sender {
    
    MySelfVC *vc = [[MySelfVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------求职意向
- (IBAction)workTopicsClick:(id)sender {
    IntentJobListVC *vc = [[IntentJobListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark ------个人简历
- (IBAction)resumeClick:(id)sender {
    Q_AListVC *vc = [[Q_AListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------ABLE评测
- (IBAction)evaluatingClick:(id)sender {
}
#pragma mark ------匹配意向职位
- (IBAction)matchingJobClick:(id)sender {
    MatchingJobListVC *vc = [[MatchingJobListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------智能匹配职位
- (IBAction)intelligentMatchJobClick:(id)sender {
    MatchingJobListVC *vc = [[MatchingJobListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
