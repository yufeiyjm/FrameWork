//
//  ViewpointDetailVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/16.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ViewpointDetailVC.h"
#import "Q_ADetailListTableViewCell.h"
#import "UIImageView+MHFacebookImageViewer.h"

@interface ViewpointDetailVC ()<MHFacebookImageViewerDatasource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组

/**顶部*/
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackHeight;
@property (strong, nonatomic) NSArray *imageArr;
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

/**发送评论*/
@property (weak, nonatomic) IBOutlet UITextField *commitTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sendBottom;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ViewpointDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"观点详情";
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.navigationBarHidden = NO;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"Q_ADetailListTableViewCell" bundle:nil] forCellReuseIdentifier:@"Q_ADetailListTableViewCell"];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
    [self downRefreshRequest];
    [self upRefreshRequest];
    self.imageArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1504676319933&di=ebdfbc51e94c0fd291675a2266ce45f0&imgtype=0&src=http%3A%2F%2Fcimg.taohuaan.net%2Fupload%2F201211%2F09%2F161159Wq7P8.jpg"];
    
    ///监听键盘高度变化
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
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

-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    for (UIView *aView in [self.imageBackView subviews]) {
        [aView removeFromSuperview];
    }
    if (imageArr.count == 0) {
        self.imageBackTop.constant = 0;
        self.imageBackHeight.constant = 0;
    }else if (imageArr.count == 1){
        self.imageBackTop.constant = 15;
        self.imageBackHeight.constant = 158;
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(0, 0, 158, 158) url:imageArr[0] index:0]];
    }else if (imageArr.count == 2){
        self.imageBackTop.constant = 15;
        self.imageBackHeight.constant = (kScreenWidth - 40- 18)/2;
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(0, 0, (kScreenWidth - 40 - 18)/2, (kScreenWidth - 40- 18)/2) url:imageArr[0] index:0]];
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake((kScreenWidth - 40- 18)/2 + 10, 0, (kScreenWidth - 40- 18)/2, (kScreenWidth - 40- 18)/2) url:imageArr[1] index:1]];
    }else{
        /**图片行数*/
        NSInteger totalLine = (imageArr.count%3==0)?(imageArr.count/3):(imageArr.count/3 + 1);
        self.imageBackHeight.constant = (kScreenWidth - 50 - 18 )/3*totalLine + 10*(totalLine - 1);
        SaintiLog(@"i=%zd",(kScreenWidth - 50 - 18 )/3);
        for (NSInteger i = 0; i < imageArr.count; i ++) {
            self.imageBackTop.constant = 15;
            NSInteger line = i/3;
            
            [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(i%3*((kScreenWidth - 50- 18)/3 + 10), ((kScreenWidth - 50- 18)/3 + 10)*line, (kScreenWidth - 50- 18)/3, (kScreenWidth - 50- 18)/3) url:imageArr[i] index:i]];
        }
    }
    [self.contentLabel sizeToFit];
    
    self.topView.frame = CGRectMake(0, 0, kScreenWidth, self.contentLabel.frame.size.height + self.contentLabel.frame.origin.y + self.imageBackTop.constant + self.imageBackHeight.constant  + 55 + 38 + 27);
    self.tableView.tableHeaderView = self.topView;
    [self.tableView reloadData];
}
-(UIImageView *)creatImageViewWithFrame:(CGRect )frame url:(NSString *)url index:(NSInteger )index{
    UIImageView *img = [[UIImageView alloc]initWithFrame:frame];
    img.contentMode = UIViewContentModeScaleAspectFill;
    [img setupImageViewerWithDatasource:self initialIndex:index  onOpen:^{
        NSLog(@"OPEN!");
    } onClose:^{
        NSLog(@"CLOSE!");
    }];
    img.clipsToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE(@"默认图")];
    return img;
}
- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer *)imageViewer {
    return self.imageArr.count;
}
-  (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer {
    return [NSURL URLWithString:[self.imageArr objectAtIndex:index]];
}

- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer{
    return IMAGE(@"默认图1");
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
