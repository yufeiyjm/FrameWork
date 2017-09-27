//
//  WorkExperienceListVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "WorkExperienceListVC.h"
#import "WorkExperienceListTableViewCell.h"
#import "AddWorkExperienceVC.h"

@interface WorkExperienceListVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组

@end

@implementation WorkExperienceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"工作经历";
    [self.tableView registerNib:[UINib nibWithNibName:@"WorkExperienceListTableViewCell" bundle:nil] forCellReuseIdentifier:@"WorkExperienceListTableViewCell"];
    
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
    [addBtn setTitle:@"添加工作经历" forState:UIControlStateNormal];
    addBtn.backgroundColor = UIColorFromRGB(0x1CAABB);
    addBtn.titleLabel.font = k14Font;
    addBtn.layer.cornerRadius = 4;
    addBtn.clipsToBounds = YES;
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [bottom addSubview:addBtn];
    
}
-(void)addBtnClick{
    AddWorkExperienceVC *vc = [[AddWorkExperienceVC alloc]init];
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
    
    
    static NSString *identifier = @"WorkExperienceListTableViewCell";
    WorkExperienceListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    [cell.editButton addTarget:self action:@selector(educationEdit:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(void)educationEdit:(UIButton *)sender{
    AddWorkExperienceVC *vc = [[AddWorkExperienceVC alloc]init];
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
