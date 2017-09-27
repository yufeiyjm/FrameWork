//
//  ArticleDetailVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/6.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ArticleDetailVC.h"
#import "Q_ADetailListTableViewCell.h"
#import "IQKeyboardManager.h"

@interface ArticleDetailVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/**发送评论*/
@property (weak, nonatomic) IBOutlet UITextField *commitTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@end

@implementation ArticleDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"八卦详情";
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.navigationBarHidden = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"Q_ADetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Q_ADetailListTableViewCell"];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self downRefreshRequest];
    [self upRefreshRequest];

    ///监听键盘高度变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.contentLabel.text = @"namenamenamenamenam\nenamenamenamenamenamenamenamenamename/nnamenamenamenamenamename";
    [self.contentLabel sizeToFit];
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, self.contentLabel.mj_h + 90);
    self.tableView.tableHeaderView = self.topView;
    [self.tableView reloadData];
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
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [[IQKeyboardManager sharedManager] setEnable:NO];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.commitTextField resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 14;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 77;
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
