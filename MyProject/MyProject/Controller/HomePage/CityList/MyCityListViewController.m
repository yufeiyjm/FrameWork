//
//  MyCityListViewController.m
//  FrameWork2.0
//
//  Created by jiaming yan on 2017/2/24.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "MyCityListViewController.h"
#import "CityTableViewCell.h"
#import "CoreLocation/CoreLocation.h"
#import "LocalCityTableViewCell.h"
@interface MyCityListViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
@property (retain, nonatomic) CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UITableView *cityTableView;
@property(nonatomic,strong)NSMutableArray *dataArr;


@property(nonatomic,strong)NSMutableArray *suoyinArray;
@property(nonatomic,strong)NSMutableArray *historyArray;
@property(nonatomic,strong)NSDictionary *locationDic;

@end

@implementation MyCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"选择城市";
    [self.cityTableView registerNib:[UINib nibWithNibName:@"CityTableViewCell" bundle:nil] forCellReuseIdentifier:@"CityTableViewCell"];
    [self.cityTableView registerNib:[UINib nibWithNibName:@"LocalCityTableViewCell" bundle:nil] forCellReuseIdentifier:@"LocalCityTableViewCell"];
    _cityTableView.sectionIndexColor = kBlackColor;
//    self.historyArray = [[NSMutableArray alloc] init];
    KUSERDEFAULTS;
    NSArray *history = [defaults objectForKey:@"historyArray"];
    self.historyArray = [NSMutableArray arrayWithArray:history];
    if (self.historyArray.count > 7) {
        [self.historyArray removeObjectsInRange:NSMakeRange(7, self.historyArray.count-7)];
    }
    [self configIndexData];
    [self cofingData];
    [self loadLocation];

}
-(void)configIndexData{
    self.suoyinArray = [[NSMutableArray alloc] init];
    [self.suoyinArray addObject:@"!"];
    [self.suoyinArray addObject:@"#"];
    for (char c = 'A'; c<='Z'; c++) {
        [self.suoyinArray addObject:[NSString stringWithFormat:@"%c",c]];
    }
}
-(void)cofingData{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"1024" forKey:@"businessType"];
    if (self.isChina) {
       [dic setObject:@"1" forKey:@"type"];
    }else{
         [dic setObject:@"2" forKey:@"type"];
    }
   
    
    __weak typeof(self) weakSelf = self;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"];
    NSData *date = [NSData dataWithContentsOfFile:path];
    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:date options:0 error:0];
    
//    NSDictionary *dicResult = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"city" ofType:@"json"]];
    NSString *resultStr = dicResult[@"Data"];
    
    NSData *JSONData = [resultStr dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingMutableLeaves error:nil];
    
//    NSString *result = parseJSONStringToNSDictionary
    NSLog(@"%@",result);
    
    NSLog(@"%@",result[@"Hot_list"]);
    
    NSLog(@"%@",result[@"City_list"]);
    
    NSArray *city = result[@"City_list"];
    weakSelf.dataArr = [NSMutableArray arrayWithArray:city];
    NSMutableDictionary *hotDic = [[NSMutableDictionary alloc]init];
    [hotDic setObject:result[@"Hot_list"] forKey:@"CityList"];
    [hotDic setObject:@"#" forKey:@"Letter"];
    [weakSelf.dataArr insertObject:hotDic atIndex:0];
    
    NSMutableDictionary *localDic = [[NSMutableDictionary alloc]init];
    [localDic setObject:weakSelf.historyArray forKey:@"CityList"];
    [localDic setObject:@"!" forKey:@"Letter"];
    [weakSelf.dataArr insertObject:localDic atIndex:0];
    [weakSelf.cityTableView reloadData];
//    if (weakSelf.isChina) {
//        self.cityChinaArr(city);
//    }else{
//        self.cityAbroadArr(city);
//    }

    
//    //GCD执行耗时操作
//    [SendRequest startRequestWithParam:dic andFinishBlock:^(id result) {
//        NSArray *city = result[@"City_list"];
//        weakSelf.dataArr = [NSMutableArray arrayWithArray:city];
//        NSMutableDictionary *hotDic = [[NSMutableDictionary alloc]init];
//        [hotDic setObject:result[@"Hot_list"] forKey:@"CityList"];
//        [hotDic setObject:@"#" forKey:@"Letter"];
//        [weakSelf.dataArr insertObject:hotDic atIndex:0];
//        
//        NSMutableDictionary *localDic = [[NSMutableDictionary alloc]init];
//        [localDic setObject:weakSelf.historyArray forKey:@"CityList"];
//        [localDic setObject:@"!" forKey:@"Letter"];
//        [weakSelf.dataArr insertObject:localDic atIndex:0];
//        [weakSelf.cityTableView reloadData];
//        if (weakSelf.isChina) {
//             self.cityChinaArr(city);
//        }else{
//            self.cityAbroadArr(city);
//        }
//
//       
//
//    } andFaild:^(NSDictionary *dic) {
//        
//    }];

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

/*
 方法描述:
 代理方法必须实现
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
        NSLog(@"加载'%@",title);
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITableViewDataSource
//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return self.suoyinArray;
}
//索引列点击事件
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    NSLog(@"%@-%ld",title,index);
    for (NSString *character in self.suoyinArray) {
        if ([character isEqualToString:title]) {
            return count;
        }
        count++;
    }
    return 0;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArr.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *nowArr =  self.dataArr[section][@"CityList"];
    if (section == 0 || section == 1) {
        return 1;
    }
    return nowArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if ((self.historyArray.count + 1)%4 == 0) {
            return 43*((self.historyArray.count + 1)/4) ;
        }else{
            return 43*((self.historyArray.count + 1)/4 + 1) ;
        }
    }else if (indexPath.section == 1) {
        NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
        if (nowArr.count%4 == 0) {
            return 43*(nowArr.count/4) + 20;
        }else{
            return 43*(nowArr.count/4 + 1) + 20 ;
        }

        return 100;
    }
    return 33;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *identifier = @"LocalCityTableViewCell";
        LocalCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        //        NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
        //        cell.cityNameLab.text = nowArr[indexPath.row][@"City_name"];
        //        [cell.contentView removeFromSuperview];
        for (UIView *aView in [cell.backView subviews]) {
            [aView removeFromSuperview];
        }
        for (NSInteger i = 0; i < self.historyArray.count + 1; i++) {
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cityBtn setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
            cityBtn.tag = 10000+i;
            [cityBtn addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if ((self.historyArray.count + 1)%4 == 0) {
                cityBtn.frame = CGRectMake(15 + ((kScreenWidth - 75)/4 + 10)*(i%4), 10 + 43*(i/4), (kScreenWidth - 75)/4, 33);
            }else{
                cityBtn.frame = CGRectMake(15 + ((kScreenWidth - 75)/4 + 10)*(i%4), 10 + 43*(i/4), (kScreenWidth - 75)/4, 33);
            }
            if (i==0) {
                if (self.locationDic) {
                   [cityBtn setTitle:self.locationDic[@"City_name"] forState:UIControlStateNormal];
                }else{
                    [cityBtn setTitle:@"定位" forState:UIControlStateNormal];
                }
                
            }else{
                [cityBtn setTitle:self.historyArray[i-1][@"City_name"] forState:UIControlStateNormal];
            }
            cityBtn.titleLabel.font = k14Font;
            [cityBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [cell.backView addSubview:cityBtn];
        }
        return cell;
    }else  if (indexPath.section == 1) {
        static NSString *identifier = @"LocalCityTableViewCell";
        LocalCityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        //        NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
        //        cell.cityNameLab.text = nowArr[indexPath.row][@"City_name"];
        //        [cell.contentView removeFromSuperview];
        for (UIView *aView in [cell.backView subviews]) {
            [aView removeFromSuperview];
        }
        NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
        
        for (NSInteger i = 0; i < nowArr.count; i++) {
            UIButton *cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [cityBtn setBackgroundColor:UIColorFromRGB(0xf4f4f4)];
            cityBtn.tag = 20000+i;
            [cityBtn addTarget:self action:@selector(cityButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (nowArr.count%4 == 0) {
                cityBtn.frame = CGRectMake(15 + ((kScreenWidth - 75)/4 + 10)*(i%4), 10 + 43*(i/4), (kScreenWidth - 75)/4, 33);
            }else{
                cityBtn.frame = CGRectMake(15 + ((kScreenWidth - 75)/4 + 10)*(i%4), 10 + 43*(i/4), (kScreenWidth - 75)/4, 33);
            }
            
            cityBtn.titleLabel.font = k14Font;
            [cityBtn setTitle:nowArr[i][@"City_name"] forState:UIControlStateNormal];
            [cityBtn setTitleColor:kBlackColor forState:UIControlStateNormal];
            [cell.backView addSubview:cityBtn];
        }
        return cell;
    }else{
        static NSString *identifier = @"CityTableViewCell";
        CityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
        cell.cityNameLab.text = nowArr[indexPath.row][@"City_name"];
        
        return cell;
    }
    
}
-(void)cityButtonClick:(UIButton *)sender{
    if (sender.tag >= 20000) {//热门城市
        NSArray *nowArr =  self.dataArr[1][@"CityList"];
        if (self.citySelected) {
            [self.historyArray removeObject:nowArr[sender.tag - 20000]];
            [self.historyArray insertObject:nowArr[sender.tag - 20000] atIndex:0];
            if (self.historyArray.count > 7) {
                [self.historyArray removeObjectsInRange:NSMakeRange(7, self.historyArray.count-7)];
            }
            KUSERDEFAULTS;
            [defaults setObject:self.historyArray forKey:@"historyArray"];
            [defaults synchronize];
            self.citySelected(nowArr[sender.tag - 20000][@"City_name"],nowArr[sender.tag - 20000][@"City_id"]);
        }
    }else if (sender.tag == 10000){//定位城市
        if (self.citySelected) {
            [self.historyArray removeObject:self.locationDic];
            [self.historyArray insertObject:self.locationDic atIndex:0];
            if (self.historyArray.count > 7) {
                [self.historyArray removeObjectsInRange:NSMakeRange(7, self.historyArray.count-7)];
            }
            KUSERDEFAULTS;
            [defaults setObject:self.historyArray forKey:@"historyArray"];
            [defaults synchronize];
            self.citySelected(self.locationDic[@"City_name"],self.locationDic[@"City_id"]);
        }
    }else{//历史城市
        if (self.citySelected) {
            NSDictionary *dic = [NSDictionary dictionaryWithDictionary:self.historyArray[sender.tag - 10001]];
            [self.historyArray removeObjectAtIndex:(sender.tag - 10001)];
            [self.historyArray insertObject:dic atIndex:0];
            if (self.historyArray.count > 7) {
                [self.historyArray removeObjectsInRange:NSMakeRange(7, self.historyArray.count-7)];
            }
            KUSERDEFAULTS;
            [defaults setObject:self.historyArray forKey:@"historyArray"];
            [defaults synchronize];
            self.citySelected(dic[@"City_name"],dic[@"City_id"]);
        }
    }
}
//返回每个索引的内容
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   
    return self.dataArr[section][@"Letter"];
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        if (section == 0 || section == 1) {
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
            headView.backgroundColor = kWhiteColor;
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15, 17, 2.5, 22)];
            line.backgroundColor = kBlackColor;
            [headView addSubview:line];
            //标题文字
            UILabel *lblBiaoti = [[UILabel alloc]init];
            lblBiaoti.backgroundColor = [UIColor clearColor];
            lblBiaoti.textAlignment = NSTextAlignmentLeft;
            lblBiaoti.font = [UIFont systemFontOfSize:12];
            lblBiaoti.textColor = kBlackColor;
            
            lblBiaoti.frame = CGRectMake(25, 20, 200, 17);
            lblBiaoti.text = self.suoyinArray[section];
            if (section==0) {
                lblBiaoti.text = @"定位 / 历史";
            }else if (section==1){
                lblBiaoti.text = @"热门城市";
            }
            [headView addSubview:lblBiaoti];
            
            //        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,  26-1,KScreenW, 1)];
            //        lineView.backgroundColor = LayerGray;
            //        [headView addSubview:lineView];
            return headView;
        }else{
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 17)];
            headView.backgroundColor = UIColorFromRGB(0xf8f8f8);
            //标题文字
            UILabel *lblBiaoti = [[UILabel alloc]init];
            lblBiaoti.backgroundColor = [UIColor clearColor];
            lblBiaoti.textAlignment = NSTextAlignmentLeft;
            lblBiaoti.font = [UIFont systemFontOfSize:12];
            lblBiaoti.textColor = kBlackColor;
            
            lblBiaoti.frame = CGRectMake(15, 0, 200, 17);
            lblBiaoti.text = self.suoyinArray[section];
            if (section==0) {
                lblBiaoti.text = @"定位城市";
            }else if (section==1){
                lblBiaoti.text = @"热门城市";
            }
            [headView addSubview:lblBiaoti];

            return headView;
        }

  
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    if (section == 0 || section == 1) {
        return 40;
    }
    return 17;
}
- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    NSArray *nowArr =  self.dataArr[indexPath.section][@"CityList"];
    
//    NSMutableDictionary *localDic = [[NSMutableDictionary alloc]init];
//    [localDic setObject:self.historyArray forKey:@"CityList"];
//    [localDic setObject:@"!" forKey:@"Letter"];

    
    if (indexPath.section > 1) {
        if (self.citySelected) {
            [self.historyArray removeObject:nowArr[indexPath.row]];
            [self.historyArray insertObject:nowArr[indexPath.row] atIndex:0];
            if (self.historyArray.count > 7) {
                [self.historyArray removeObjectsInRange:NSMakeRange(7, self.historyArray.count-7)];
            }
            KUSERDEFAULTS;
            [defaults setObject:self.historyArray forKey:@"historyArray"];
            [defaults synchronize];
            self.citySelected(nowArr[indexPath.row][@"City_name"],nowArr[indexPath.row][@"City_id"]);
        }
    }
}

//定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    //    [locationManager stopUpdatingLocation];
    //SAINTILog(@"location ok");
    
    //SAINTILog(@"%@",[NSString stringWithFormat:@"经度:%3.5f\n纬度:%3.5f",newLocation.coordinate.latitude,newLocation.coordinate.longitude]);
   __block NSString *localCity_id = nil;
   __block NSString *localCity = nil;
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        for (CLPlacemark * placemark in placemarks) {
            
            NSDictionary *test = [placemark addressDictionary];
            //            _labelCurrentCity.text = [test objectForKey:@"City"];
            
            
            localCity = [test objectForKey:@"City"];
            localCity = [localCity substringWithRange:NSMakeRange(0,localCity.length - 1)];
            [self.locationManager stopUpdatingLocation];
            NSArray *city = self.dataArr;
            //        NSArray *hotCity = result[@"Hot_list"];
            for (NSInteger i=0; i<city.count; i++) {
                NSArray *nowArr =  city[i][@"CityList"];
                for (NSInteger j = 0; j < nowArr.count; j++) {
                    if ([nowArr[j][@"City_name"] isEqualToString:localCity]) {
                        localCity_id =nowArr[j][@"City_id"];
                    }
                }
            }
            
//            NSMutableDictionary *localDic = [[NSMutableDictionary alloc]init];
//            [localDic setObject:result[@"Hot_list"] forKey:@"CityList"];
//            [localDic setObject:@"!" forKey:@"Letter"];
//            [weakSelf.dataArr insertObject:localDic atIndex:0];
        }
        if (!self.locationDic) {
            self.locationDic = [NSDictionary dictionaryWithObjectsAndKeys:localCity,@"City_name",localCity_id,@"City_id", nil];
            
            [self.cityTableView reloadData];
        }
        
      SaintiLog(@"%@----------%@",localCity,localCity_id);
    }];
    
    
    
}
- (void)locationManager: (CLLocationManager *)manager
       didFailWithError: (NSError *)error {
    NSString *errorString;
    [manager stopUpdatingLocation];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
