//
//  SpecialDetailVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/18.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SpecialDetailVC.h"
#import "SpecialDetailTableViewCell.h"
#import "AddGossipVC.h"

@interface SpecialDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
@property (weak, nonatomic) IBOutlet UIButton *collectionButton;

@end

@implementation SpecialDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"SpecialDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"SpecialDetailTableViewCell"];
    
    self.shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    self.collectionButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.contentLabel.text = @"胜利大街法拉盛就分啦就发了手机发了可是；飞机sad开了房静安寺看到了；飞机萨迪克雷锋精神多啦开发撒到了荆防颗粒是大家付款了撒酒疯上课啦的飞机；阿斯利康发久啊圣诞快乐放假啊圣诞快乐放假啊大神看来飞机；啥都看了法就是登录快捷方式大连科技第三方金卡戴珊";
    [self.titleLabel sizeToFit];
    [self.contentLabel sizeToFit];
    
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, 339 + self.titleLabel.mj_h + self.contentLabel.mj_h - 43);
    self.tableView.tableHeaderView = self.topView;

    [self downRefreshRequest];
    [self upRefreshRequest];
}
#pragma mark ------列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 13;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"SpecialDetailTableViewCell";
    SpecialDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.imageArr = nil;
    if (indexPath.row == 0) {
    }else if(indexPath.row == 2){
        cell.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg"];
    }else{
    }
//    cell.specialDetailButton.tag = indexPath.row;
//    [cell.specialDetailButton addTarget:self action:@selector(specialDetailClick:) forControlEvents:UIControlEventTouchUpInside];
//    cell.lineHeight.constant = 10;
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
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)attentionSpecialClick:(id)sender {
    AddGossipVC *vc= [[AddGossipVC alloc]init];
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
