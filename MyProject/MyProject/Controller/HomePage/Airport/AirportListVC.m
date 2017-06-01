//
//  AirportListVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/4/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AirportListVC.h"
#import "AirportListTableViewCell.h"
#import "CoreLocation/CoreLocation.h"

@interface AirportListVC ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrNearData;
@property (strong, nonatomic)  NSMutableArray *arrTopData;
@property (strong, nonatomic)  NSMutableArray *arrLocalData;

@property (weak, nonatomic) IBOutlet UIView *searchBack;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (retain, nonatomic) CLLocationManager *locationManager;
@property (assign, nonatomic) BOOL isLocaltion;

@end

@implementation AirportListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.searchTextField.placeholder = self.airport;
    self.navigationItem.title = NSLocalizedString(@"Airports", nil);
    self.navigationItem.leftBarButtonItem = nil;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 55;
    [self.tableView registerNib:[UINib nibWithNibName:@"AirportListTableViewCell" bundle:nil] forCellReuseIdentifier:@"AirportListTableViewCell"];
    self.tableView.tableFooterView = [[UIView alloc]init];

    self.searchBack.layer.borderColor = UIColorFromRGB(0xC2C2C2).CGColor;
    self.searchBack.layer.borderWidth = 0.5;
    self.searchBack.layer.cornerRadius = 4;
    self.searchTextField.tintColor = UIColorFromRGB(0x999999);
    [self.searchTextField addTarget:self action:@selector(searchClick:) forControlEvents:UIControlEventEditingChanged];
    KUSERDEFAULTS;
    self.arrLocalData = [NSMutableArray arrayWithArray:[defaults objectForKey:@"LocalCity"]];
    
    [self loadLocation];

    
    
   
}
/*
 方法描述:
 调用定位
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)loadLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 1000.0f;
    if([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
}
//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //    [locationManager stopUpdatingLocation];
    //SAINTILog(@"location ok");
    
    //SAINTILog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
    __weak typeof(self) weakSelf = self;

    if (self.isLocaltion == NO) {
        self.isLocaltion = YES;
        
        //GCD执行耗时操作
        [self showProgressWithView:self.view animated:YES];
        [SendRequest requestAirportListWithLat:[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.latitude] lon:[NSString stringWithFormat:@"%3.5f",newLocation.coordinate.longitude] result:^(id result, NSError *error){
            [weakSelf hideProgress:self.view animated:YES];
            if ([result[@"result"] integerValue] == 1) {
                weakSelf.arrTopData = result[@"data"][@"topAirportList"];
                weakSelf.arrNearData = result[@"data"][@"nearAirportList"];
                [weakSelf.tableView reloadData];
            }
            
        }];
    }
    
    
}
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    NSString *errorString;
    [manager stopUpdatingLocation];
    __weak typeof(self) weakSelf = self;

    //GCD执行耗时操作
    [self showProgressWithView:self.view animated:YES];
    [SendRequest requestAirportListWithLat:@"" lon:@"" result:^(id result, NSError *error){
        [weakSelf hideProgress:self.view animated:YES];
        if ([result[@"result"] integerValue] == 1) {
            weakSelf.arrTopData = result[@"data"][@"topAirportList"];
            weakSelf.arrNearData = result[@"data"][@"nearAirportList"];
            [weakSelf.tableView reloadData];
        }
        
    }];
    //    //NSLog(@"Error: %@",[error localizedDescription]);
    switch([error code]) {
        case kCLErrorDenied:
        {
            //Access denied by user
            errorString = @"请再系统设置中开启定位服务(设置>隐私>定位服务>开启约伴)";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"定位服务未开启" message:errorString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"开启", nil];
            alert.tag = 1000;
            [alert show];
            //Do something...
        }
            break;
        case kCLErrorLocationUnknown:
        {
            //Probably temporary...
            //            errorString = @"定位服务不可用";
            //            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:errorString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"开启", nil];
            //            alert.tag = 1000;
            //            [alert show];
            //Do something else...
        }
            break;
        default:
        {
            errorString = @"An unknown error has occurred";
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"信息提示" message:errorString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"开启", nil];
            alert.tag = 1000;
            [alert show];
        }
            break;
    }
    
    
}

-(void)searchClick:(UITextField *)textField{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 25)];
    [backView setBackgroundColor:UIColorFromRGB(0xcccccc)];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(25, 0, 200, 25)];
    lab.textColor = UIColorFromRGB(0x505050);
    lab.font = [UIFont boldSystemFontOfSize:10.0];
    [backView addSubview:lab];
    switch (section) {
        case 0:
        {
            lab.text = NSLocalizedString(@"Recent Searches", nil);;
            
        }
            break;
        case 1:
        {
            lab.text = NSLocalizedString(@"Nearby", nil);
        }
            break;
        case 2:
        {
            lab.text = NSLocalizedString(@"Top 50", nil);
        }
            break;
        default:
            break;
    }
    return backView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (self.arrLocalData.count >= 6) {
            return 6;
        }
        return self.arrLocalData.count;
    }else if (section == 1) {
        return self.arrNearData.count;
    }else if (section == 2) {
        return self.arrTopData.count;
    }else{
        return 0;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"AirportListTableViewCell";
    AirportListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    //    cell.contentView.backgroundColor = kClearColor;
    if (indexPath.section == 0) {
        cell.airportNameLab.text = [NSString stringWithFormat:@"%@(%@)",self.arrLocalData[indexPath.row][@"airport_name"],self.arrLocalData[indexPath.row][@"airport_code"]];
        cell.cityLab.text = self.arrLocalData[indexPath.row][@"city"];
//        cell.airportNameLab.text = self.arrLocalData[];
    }else if (indexPath.section == 1) {
        cell.airportNameLab.text = [NSString stringWithFormat:@"%@(%@)",self.arrNearData[indexPath.row][@"airport_name"],self.arrNearData[indexPath.row][@"airport_code"]];
        cell.cityLab.text = self.arrNearData[indexPath.row][@"city"];
    }else if (indexPath.section == 2) {
        cell.airportNameLab.text = [NSString stringWithFormat:@"%@(%@)",self.arrTopData[indexPath.row][@"airport_name"],self.arrTopData[indexPath.row][@"airport_code"]];
        cell.cityLab.text = self.arrTopData[indexPath.row][@"city"];
        
    }else{
       
        
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (self.selectAirport) {
           
            
            self.selectAirport(self.arrLocalData[indexPath.row][@"airport_code"],self.arrLocalData[indexPath.row][@"city"]);
            NSDictionary *tempDic = [NSDictionary dictionaryWithDictionary:self.arrLocalData[indexPath.row]];
            
            [self.arrLocalData removeObject:self.arrLocalData[indexPath.row]];
            [self.arrLocalData insertObject:tempDic atIndex:0];
            KUSERDEFAULTS;
            [defaults setObject:self.arrLocalData forKey:@"LocalCity"];
            [defaults synchronize];
        }
    }else if (indexPath.section == 1) {
        if (self.selectAirport) {
           
            
            self.selectAirport(self.arrNearData[indexPath.row][@"airport_code"],self.arrNearData[indexPath.row][@"city"]);
            [self.arrLocalData removeObject:self.arrNearData[indexPath.row]];
            [self.arrLocalData insertObject:self.arrNearData[indexPath.row] atIndex:0];
            KUSERDEFAULTS;
            [defaults setObject:self.arrLocalData forKey:@"LocalCity"];
            [defaults synchronize];
        }
        
    }else if (indexPath.section == 2) {
        
        if (self.selectAirport) {
           
            self.selectAirport(self.arrTopData[indexPath.row][@"airport_code"],self.arrTopData[indexPath.row][@"city"]);
            [self.arrLocalData removeObject:self.arrTopData[indexPath.row]];
            [self.arrLocalData insertObject:self.arrTopData[indexPath.row] atIndex:0];
            KUSERDEFAULTS;
            [defaults setObject:self.arrLocalData forKey:@"LocalCity"];
            [defaults synchronize];
        }
    }else{
        
    }
   
    [self.navigationController popViewControllerAnimated:YES];
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
