//
//  ProjectExperienceListVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ProjectExperienceListVC.h"
#import "ProjectExperienceListTableViewCell.h"
#import "AddProjectExperienceVC.h"

@interface ProjectExperienceListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组

@end

@implementation ProjectExperienceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"项目经历";
    [self.tableView registerNib:[UINib nibWithNibName:@"ProjectExperienceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ProjectExperienceListTableViewCell"];
    
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 10)];
    top.backgroundColor = UIColorFromRGB(0xF2F5FA);
    self.tableView.tableHeaderView = top;
    
    UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    bottom.backgroundColor = UIColorFromRGB(0xF2F5FA);
    self.tableView.tableFooterView = bottom;
    
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.frame = CGRectMake(20, 26, kScreenWidth - 40, 48);
    [addBtn setTitle:@"添加项目经历" forState:UIControlStateNormal];
    addBtn.backgroundColor = UIColorFromRGB(0x1CAABB);
    addBtn.titleLabel.font = k14Font;
    addBtn.layer.cornerRadius = 4;
    addBtn.clipsToBounds = YES;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:addBtn];
    
}
-(void)addBtnClick{
    AddProjectExperienceVC *vc = [[AddProjectExperienceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 117;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"ProjectExperienceListTableViewCell";
    ProjectExperienceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
    if (indexPath.row == 1) {
        cell.contentLabel.text = @"打了款数据库了飞机ask冷风机阿是打开费老劲sad开了房；啥飞机上的卡了；附件萨克冷风机萨克雷发髻上；开发洒洒地卡罗发髻上；反馈拉丝粉撒娇的发生了；就艾弗森大连科技反馈绿色大嫁风尚卡里的；复健科拉萨到放假啊是飞机sad飞机sad雷锋精神打开了飞机阿萨德";
    }
    return cell;
    
}

-(void)educationEdit:(UIButton *)sender{
    AddProjectExperienceVC *vc = [[AddProjectExperienceVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
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
