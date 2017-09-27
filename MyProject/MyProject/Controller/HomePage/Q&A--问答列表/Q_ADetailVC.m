//
//  CommitVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "Q_ADetailVC.h"
#import "Q_ADetailListTableViewCell.h"
#import "MatchingJobListVC.h"
#import "HeadCollectionViewCell.h"
#import "PraiseListVC.h"
#import "IQKeyboardManager.h"

@interface Q_ADetailVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (weak, nonatomic) IBOutlet UITextField *commitTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *tableViewHead;

@end

@implementation Q_ADetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"问答详情";
    [self.tableView registerNib:[UINib nibWithNibName:@"Q_ADetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Q_ADetailListTableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableViewHead.frame = CGRectMake(0, 0, kScreenWidth, 195);
    self.tableView.tableHeaderView = self.tableViewHead;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.sectionInset = UIEdgeInsetsZero;
    flowLayout.itemSize = CGSizeMake(28, 28);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView.collectionViewLayout = flowLayout;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"HeadCollectionViewCell" bundle:nil]  forCellWithReuseIdentifier:@"HeadCollectionViewCell"];
    
    
    
    [self downRefreshRequest];
    [self upRefreshRequest];
    
    ///监听键盘高度变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{

}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    
}
///动态更改frame
-(void)keyboardFrameChange:(NSNotification *)notify
{
    NSDictionary *dict = [notify userInfo];
    NSValue *endValue = [dict objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect endFrame = [endValue CGRectValue];
    SaintiLog(@"%f---%f",endFrame.origin.y,endFrame.size.height);
    

    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    
    NSNumber *isShowKeyboardValue = [dict objectForKey:@"UIKeyboardIsLocalUserInfoKey"];
    BOOL isShowKeyboard = isShowKeyboardValue.boolValue;
    
    
    if (isShowKeyboard)
    {
        
        ///键盘高度更改
        [self.bottomView setFrame:CGRectMake(0, endFrame.origin.y - 55 , screenWidth, 55)];
        self.sendBottom.constant = (screenHeight - endFrame.origin.y);
    }
    else
    {
//        [UIView beginAnimations:nil context:nil];
//        [UIView setAnimationDuration:0.25];
        ///键盘隐藏
        [self.bottomView setFrame:CGRectMake(0, screenHeight, screenWidth, 55)];
        self.sendBottom.constant = 0;
//         [UIView commitAnimations];
    }
    
   
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commitTextField resignFirstResponder];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 13;self.arrData.count;
}

#pragma mark ---- UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  6;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"HeadCollectionViewCell";
    
    HeadCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier forIndexPath:indexPath];
//    if (indexPath.row == self.selectIndex) {
//        cell.titleLabel.backgroundColor = UIColorFromRGB(0x1EB0C1);
//        cell.titleLabel.textColor = kWhiteColor;
//    }else{
//        cell.titleLabel.backgroundColor = kWhiteColor;
//        cell.titleLabel.textColor = UIColorFromRGB(0x1EB0C1);
//    }
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"Q_ADetailListTableViewCell";
    Q_ADetailListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    
    if (indexPath.row==1) {
        cell.contentLabel.text = @"工作三年工作三年工作三年工作三年工作";
        NSMutableAttributedString *attributeString  = [[NSMutableAttributedString alloc]initWithString:@"张三回复李四说：你今天该睡觉了，该怎么样你自己看着办吧，不行就睡马路"];
        [attributeString addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x1AA9BA) range:NSMakeRange(4,2)];
        cell.contentLabel.attributedText = attributeString;
    }else{
        cell.contentLabel.text = @"工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年工作三年";
    }
    return cell;
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
//    [self.commitTextField resignFirstResponder];
    MatchingJobListVC *vc = [[MatchingJobListVC alloc]init];
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
- (IBAction)zanClick:(id)sender {
}
- (IBAction)morePeopleClick:(id)sender {
    PraiseListVC *vc = [[PraiseListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
