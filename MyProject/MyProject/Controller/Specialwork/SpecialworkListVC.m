//
//  SpecialworkListVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/14.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SpecialworkListVC.h"
#import "WorkTopicsTableViewCell.h"
#import "SpecialWorkHotCollectionViewCell.h"
#import "DateSignTableViewCell.h"
#import "MakeDateSignVC.h"
#import "TopicListVC.h"
#import "ViewpointDetailVC.h"
#import "DateSignListVC.h"
#import "SpecialDetailVC.h"
@interface SpecialworkListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组


@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic)  NSMutableArray *arrCollectionDate;//头像数组
@end

@implementation SpecialworkListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"WorkTopicsTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkTopicsTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"DateSignTableViewCell" bundle:nil] forCellReuseIdentifier:@"DateSignTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, 337);
    self.tableView.tableHeaderView = self.topView;
    /**初始化顶部CollectionView*/
    [self loadTopHead];
    
    [self downRefreshRequest];
    [self upRefreshRequest];
    
}
/*
 方法描述:
 初始化顶部CollectionView
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)loadTopHead{
    [self.collectionView registerNib:[UINib nibWithNibName:@"SpecialWorkHotCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"SpecialWorkHotCollectionViewCell"];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.itemSize = CGSizeMake(128,73);
    flowLayout.sectionInset = UIEdgeInsetsMake(0,12, 0, 12);
    self.collectionView.collectionViewLayout = flowLayout;
}
#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  11;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"SpecialWorkHotCollectionViewCell";
    SpecialWorkHotCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = kClearColor;

    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    DateSignListVC *vc = [[DateSignListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
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
    
    
   
    if (indexPath.row == 2) {
        static NSString *identifier = @"DateSignTableViewCell";
        DateSignTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else{
        static NSString *identifier = @"WorkTopicsTableViewCell";
        WorkTopicsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.imageArr = nil;
        if (indexPath.row == 0) {
            cell.topTitleHeight.constant = 26;
        }else if(indexPath.row == 2){
            cell.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg"];
        }else{
            cell.topTitleHeight.constant = 0;
        }
        cell.specialDetailButton.tag = indexPath.row;
        [cell.specialDetailButton addTarget:self action:@selector(specialDetailClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.lineHeight.constant = 10;
        return cell;
    }
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    ViewpointDetailVC *vc = [[ViewpointDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)specialDetailClick:(UIButton *)sender{
    SpecialDetailVC *vc = [[SpecialDetailVC alloc]init];
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
- (IBAction)moreTopic:(id)sender {
    TopicListVC *vc = [[TopicListVC alloc]init];
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
