//
//  VitaeVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "VitaeVC.h"
#import "NoVitaeTableViewCell.h"
#import "HeadTableViewCell.h"
#import "BaseInfoTableViewCell.h"
#import "WorkExperienceTableViewCell.h"
#import "EducationTableViewCell.h"
#import "EducationListVC.h"
#import "ExpectedWorkTableViewCell.h"
#import "ValuesTableViewCell.h"
#import "ProjectExperienceTableViewCell.h"
#import "SkillTableViewCell.h"

@interface VitaeVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (strong, nonatomic)  NSArray *headArrData;//头像名数组
@property (strong, nonatomic)  NSArray *titleArrData;//标题名数组
@end

@implementation VitaeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"完善简历";
    [self.tableView registerNib:[UINib nibWithNibName:@"NoVitaeTableViewCell" bundle:nil] forCellReuseIdentifier:@"NoVitaeTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadTableViewCell" bundle:nil] forCellReuseIdentifier:@"HeadTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"BaseInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"BaseInfoTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"WorkExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkExperienceTableViewCell"];
     [self.tableView registerNib:[UINib nibWithNibName:@"EducationTableViewCell" bundle:nil] forCellReuseIdentifier:@"EducationTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpectedWorkTableViewCell" bundle:nil] forCellReuseIdentifier:@"ExpectedWorkTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ValuesTableViewCell" bundle:nil] forCellReuseIdentifier:@"ValuesTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectExperienceTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectExperienceTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SkillTableViewCell" bundle:nil] forCellReuseIdentifier:@"SkillTableViewCell"];
    
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.headArrData = @[@"添加头像",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历",@"完善简历_工作经历"];
    self.titleArrData = @[@"添加头像",@"基本信息",@"工作经历",@"教育经历",@"期望工作",@"价值观匹配",@"项目经历",@"技能评价",@"自我描述"];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        static NSString *identifier = @"HeadTableViewCell";
        HeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1) {
        static NSString *identifier = @"BaseInfoTableViewCell";
        BaseInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 2) {
        static NSString *identifier = @"WorkExperienceTableViewCell";
        WorkExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.workExperienceArr = @[@"1",@"1",@"1",@"1",@"1"];
        return cell;
    }else if (indexPath.section == 3) {
        static NSString *identifier = @"EducationTableViewCell";
        EducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.educationArr = @[@"1",@"1",@"1",@"1",@"1"];
        [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 4) {
        static NSString *identifier = @"ExpectedWorkTableViewCell";
        ExpectedWorkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.expectedWorkArr = @[@"1",@"1",@"1",@"1",@"1"];
//        [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 5) {
        static NSString *identifier = @"ValuesTableViewCell";
        ValuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.valuesArr = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
        //        [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 6) {
        static NSString *identifier = @"ProjectExperienceTableViewCell";
        ProjectExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.projectArr = @[@"1",@"1",@"1",@"1",@"1"];
        //        [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 7) {
        static NSString *identifier = @"SkillTableViewCell";
        SkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.skillArr = @[@"1",@"1",@"1",@"1",@"1"];
        //        [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    else{
        static NSString *identifier = @"NoVitaeTableViewCell";
        NoVitaeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        return cell;
    }
   
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 30)];
    [backView setBackgroundColor:UIColorFromRGB(0xF2F5FA)];
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 10, 30)];
    img.contentMode = UIViewContentModeScaleAspectFit;
    img.image = IMAGE(self.headArrData[section]);
    [backView addSubview:img];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(28, 0, 100, 30)];
    lab.font = [UIFont systemFontOfSize:11.0f];
    lab.textColor = UIColorFromRGB(0xbbc4c8);
    [backView addSubview:lab];
    lab.text = self.titleArrData[section];
    [lab sizeToFit];
    lab.frame = CGRectMake(28, 0, lab.mj_w, 30);
    UILabel *labMust = [[UILabel alloc]initWithFrame:CGRectMake(lab.mj_x + lab.mj_w + 5, 8, 35, 14)];
    labMust.font = [UIFont fontWithName:@"PingFangSC-Light" size:10];
    labMust.textAlignment = NSTextAlignmentCenter;
    labMust.textColor = UIColorFromRGB(0x1caabb);
    labMust.backgroundColor = UIColorFromRGB(0xD9F1F4);
    labMust.clipsToBounds = YES;
    labMust.layer.cornerRadius = 7;
    [backView addSubview:labMust];
    labMust.text = @"必填";
    if (section > 5 || section == 0) {
        labMust.hidden = YES;
    }
    return backView;
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}
-(void)educationEdit:(UIButton *)sender{
    EducationListVC *vc = [[EducationListVC alloc]init];
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
