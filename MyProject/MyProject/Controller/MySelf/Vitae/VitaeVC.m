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
#import "RemarksTableViewCell.h"
#import "BaseInfoVC.h"
#import "WorkExperienceListVC.h"
#import "AddExpectedWorkVC.h"
#import "ProjectExperienceListVC.h"
#import "SkillListVC.h"
#import "DescribeVC.h"

@interface VitaeVC ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
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
    [self.tableView registerNib:[UINib nibWithNibName:@"RemarksTableViewCell" bundle:nil] forCellReuseIdentifier:@"RemarksTableViewCell"];
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    aView.backgroundColor = UIColorFromRGB(0xF2F5FA);
    self.tableView.tableFooterView = aView;
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
        [cell.editButton addTarget:self action:@selector(BaseInfoEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 2) {
        /**工作经历*/
        static NSString *identifier = @"WorkExperienceTableViewCell";
        WorkExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.workExperienceArr = @[@"1",@"1",@"1",@"1",@"1"];
        [cell.editButton addTarget:self action:@selector(WorkExperienceEdit:) forControlEvents:UIControlEventTouchUpInside];
        
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
        cell.expectedWorkArr = @[@"1"];
        [cell.editButton addTarget:self action:@selector(expectedWorkEdit:) forControlEvents:UIControlEventTouchUpInside];
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
        [cell.editButton addTarget:self action:@selector(projectExperienceEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 7) {
        static NSString *identifier = @"SkillTableViewCell";
        SkillTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.skillArr = @[@"1",@"1",@"1",@"1",@"1"];
        [cell.editButton addTarget:self action:@selector(skillEdit:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else if (indexPath.section == 8) {
        static NSString *identifier = @"RemarksTableViewCell";
        RemarksTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
        cell.remarkLabel.text = @"我邻居发收到甲方三雷锋精神多啦发件了大看是否啥打了卡福桑德拉开发阿斯利康；发啥打了卡福答复阿斯顿发生东方闪电阿范德萨佳得乐发圣诞节快乐技术方面你我哪些 看撒娇发爱的世界金坷垃";
                [cell.editButton addTarget:self action:@selector(describeEdit:) forControlEvents:UIControlEventTouchUpInside];
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
    if (indexPath.section == 0) {
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍摄" otherButtonTitles:@"从相册选择", nil];
        [sheet showInView:self.view];
        [self.view endEditing:YES];
    }
}
/*
 方法描述:
 基本信息
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)BaseInfoEdit:(UIButton *)sender{
    BaseInfoVC *vc = [[BaseInfoVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 工作经历
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)WorkExperienceEdit:(UIButton *)sender{
    WorkExperienceListVC *vc = [[WorkExperienceListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 教育经历
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)educationEdit:(UIButton *)sender{
    EducationListVC *vc = [[EducationListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 期望工作
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)expectedWorkEdit:(UIButton *)sender{
    AddExpectedWorkVC *vc = [[AddExpectedWorkVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 项目经历
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)projectExperienceEdit:(UIButton *)sender{
    ProjectExperienceListVC *vc = [[ProjectExperienceListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 技能评价
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)skillEdit:(UIButton *)sender{
    SkillListVC *vc = [[SkillListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 自我描述
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
-(void)describeEdit:(UIButton *)sender{
    DescribeVC *vc = [[DescribeVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 0) {
        //拍摄
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];//初始化
        picker.view.tag = actionSheet.tag;
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
        
    }else if (buttonIndex == 1) {
        //从相册选择
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;//设置可编辑
        picker.view.tag = actionSheet.tag;
        [self presentViewController:picker animated:YES completion:nil];
    }
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)aImage editingInfo:(NSDictionary *)editingInfo
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    // 获得编辑过的图片
    // 把图片转成NSData类型的数据来保存文件(存入到沙盒中)
    // 判断图片是不是png格式的文件
    if (UIImagePNGRepresentation(aImage)) {
        // 返回为png图像。
    }else if (UIImageJPEGRepresentation(aImage, 1.0)){
        // 返回为JPEG图像
    }else{
        [[CommonUtils sharedCommonUtils]showAlert:@"请上传 jpeg或是png格式" delegate:nil];
        return;
    }
    
    //    //    if (aImage.size.width < 800 || aImage.size.height < 800) {
    //    //        [[CommonUtils sharedCommonUtils]showAlert:@"您上传的图片大小最低为800*800" delegate:nil];
    //    //        return;
    //    //    }
    //    //    [self.headImage setImage:aImage forState:UIControlStateNormal];
    //    NSData *datas = UIImageJPEGRepresentation(aImage,1);
    //    //    MBProgressHUD *progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    //    progress.mode = MBProgressHUDModeAnnularDeterminate;
    //
    //    NSArray *dataArr = [NSArray arrayWithObjects:datas, nil];
    //    //GCD执行耗时操作
    //    [SendRequest uploadWithFileDatas:dataArr andFinishBlock:^(id result) {
    //        [self hideProgress:self.view animated:YES];
    //
    //        [self.headImageButton setImage:aImage forState:UIControlStateNormal];
    //        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUserInfo" object:nil];
    //    } andFaild:^(NSDictionary *dic) {
    //        [self hideProgress:self.view animated:YES];
    //    }];
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
