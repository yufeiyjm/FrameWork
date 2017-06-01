//
//  CitySelectedVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/5/27.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "CitySelectedVC.h"
#import "CityTableViewCell.h"

@interface CitySelectedVC ()
//搜索相关
@property(nonatomic,strong)NSMutableArray *searchArray;
@property(nonatomic,assign)BOOL isSearch;
@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *searchResultTableView;

@property(nonatomic,strong)NSMutableArray *cityChinaArr;
@property(nonatomic,strong)NSMutableArray *cityAbroadArr;
@end

@implementation CitySelectedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Choose a city or airline", nil);;
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    style.scrollTitle = NO;
    
    style.scrollLineHeight = 2;//滚动条粗细
    style.scrollLineColor = UIColorFromRGB(0x0D84BF);//滚动条颜色
    style.titleMargin = 15;//标题之间的间隙 默认为15.0
    style.titleFont = k15Font;//标题的字体 默认为14
    style.normalTitleColor = UIColorFromRGB(0x666666);//标题一般状态的颜色
    style.selectedTitleColor =  UIColorFromRGB(0x0D84BF);//标题选中状态的颜色
    style.segmentHeight = 0;//segmentVIew的高度, 这个属性只在使用ZJScrollPageVIew的时候设置生效
    style.scrollContentView = NO;
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    style.coverCornerRadius = 0;
    style.coverHeight = 0;
    style.showCover = YES;
    style.coverBackgroundColor = kWhiteColor;
    self.titles = @[@"国内",
                    @"国外"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    scrollPageView.segmentView.backgroundColor = kWhiteColor;//UIColorFromRGB(0xf4f4f4);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 44.5, kScreenWidth, 0.5)];
    [lineView setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
    [scrollPageView.segmentView addSubview:lineView];
    [self.view addSubview:scrollPageView];
    [self configSearch];
    
    [self.searchResultTableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
    
}
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

/*
 方法描述:
 1、设置每一栏的viewcontroller。
 2、一般在这个方法中传入一些属性参数，然后在不同的VC中请求网络。
 3、注意该VC需要继承一个代理。
 参数说明:
 index：判断第几个
 
 返回结果:
 <#返回结果#>
 
 */
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        switch (index) {
            case 0:
            {
                childVc = [[CityListVC alloc] init];
                ((CityListVC *)childVc).isChina = YES;
                ((CityListVC *)childVc).citySelected=^(NSDictionary *cityDic){
                    
                    self.citySelected(cityDic);
                    [self.navigationController popViewControllerAnimated:YES];
                };
                ((CityListVC *)childVc).cityChinaArr=^(NSArray *cityArr){
                    self.cityChinaArr = [NSMutableArray arrayWithArray:cityArr];
                };
            }
                break;
            case 1:
            {
                childVc = [[CityListVC alloc] init];
                ((CityListVC *)childVc).citySelected=^(NSDictionary *cityDic){
                    self.citySelected(cityDic);
                    [self.navigationController popViewControllerAnimated:YES];
                };
                ((CityListVC *)childVc).cityAbroadArr=^(NSArray *cityArr){
                    self.cityAbroadArr = [NSMutableArray arrayWithArray:cityArr];
                };
                
            }
                break;
                
            default:
                break;
        }
        
        
    }
    
    
    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)configSearch{
    self.searchArray = [[NSMutableArray alloc] init];
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectZero];
    self.searchBar.placeholder = NSLocalizedString(@"Please enter the name of the city", nil);
    //    self.searchBar.showsCancelButton = YES;
    
    //    //删除searchBar的两条黑线
    //    for (UIView *obj in [self.searchBar subviews]) {
    //        for (UIView *objs in [obj subviews]) {
    //            if ([objs isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
    //                [objs removeFromSuperview];
    //            }
    //        }
    //        if ([obj isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){
    //            [obj removeFromSuperview];
    //        }
    //    }
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    //   self.domesticTable.tableHeaderView = self.searchBar;
    [self.searchBar setImage:[UIImage imageNamed:@"citySearch"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [self.searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchBarImage"] forState:UIControlStateNormal];
    //    self.searchBar.layer.borderWidth = 1;
    //    self.searchBar.layer.borderColor = UIColorFromRGB(0xe1e1e1).CGColor;
    //    self.searchBar.layer.cornerRadius = 2;
    //    self.searchBar.clipsToBounds = YES;
    self.searchResultTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight-64) style:UITableViewStylePlain];
    self.searchResultTableView.delegate = self;
    self.searchResultTableView.dataSource = self;
    self.searchResultTableView.hidden = YES;
    self.searchResultTableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.searchResultTableView];
    //self.searchResultTableView.tableHeaderView = self.searchBar;
}
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self valueChanged:searchText];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
     [self.searchBar endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.isSearch = NO;
    self.searchBar.text = @"";
    self.searchResultTableView.hidden = YES;
    [self.searchBar endEditing:YES];
}
//搜索城市
-(void)valueChanged:(NSString *)searchString{
    
    NSLog(@"textField.text :%@",searchString);
    if ([searchString isEqualToString:@""]) {
        self.isSearch = NO;
        self.searchResultTableView.hidden = YES;
        return;
    }else{
        self.isSearch = YES;
        self.searchResultTableView.hidden = NO;
    }
    [self.searchArray removeAllObjects];
    for (NSInteger i = 0; i < self.cityChinaArr.count; i++) {
        NSArray *cityArr =  self.cityChinaArr[i][@"CityList"];
        for (NSInteger j = 0; j < cityArr.count; j++) {
            NSString *cityName =  cityArr[j][@"City_name"];
            if([cityName rangeOfString:searchString].location !=NSNotFound)//_roaldSearchText
            {
                [self.searchArray addObject:cityArr[j]];
            }
            else
            {
                NSLog(@"no");
            }
        }
    }
    
    for (NSInteger i = 0; i < self.cityAbroadArr.count; i++) {
        NSArray *cityArr =  self.cityAbroadArr[i][@"CityList"];
        for (NSInteger j = 0; j < cityArr.count; j++) {
            NSString *cityName =  cityArr[j][@"City_name"];
            if([cityName rangeOfString:searchString].location !=NSNotFound)//_roaldSearchText
            {
                [self.searchArray addObject:cityArr[j]];
            }
            else
            {
                NSLog(@"no");
            }
        }
    }
    [self.searchResultTableView reloadData];
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    self.isSearch = NO;
    return YES;
}
#pragma mark-tableViewDataSource&Delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.citySelected(self.searchArray[indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"CityTableViewCell";
    CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.cityNameLab.text = self.searchArray[indexPath.row][@"City_name"];
    NSString *strCity_id = self.searchArray[indexPath.row][@"City_id"];
    if (strCity_id.length > 0) {
        cell.cityNameLab.text = [NSString stringWithFormat:@"%@(%@)",self.searchArray[indexPath.row][@"City_name"],strCity_id];
        
    }
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchArray.count==0) {
        self.searchResultTableView.hidden = YES;
    }else{
        self.searchResultTableView.hidden = NO;
    }
    return self.searchArray.count;
}
-(void)doBack:(id)sender{
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
