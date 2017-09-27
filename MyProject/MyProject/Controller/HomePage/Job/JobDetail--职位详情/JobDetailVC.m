//
//  JobDetailVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/30.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "JobDetailVC.h"
#import "ResumeAlertVC.h"
#import "Q_AListVC.h"
#import "CommitVC.h"
#import "CompanyDetailVC.h"
@interface JobDetailVC ()

@end

@implementation JobDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"职位详情-职位亮点_PxCook.png";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 方法描述:
 公司详情
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)companyClick:(id)sender {
    CompanyDetailVC *vc = [[CompanyDetailVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}
/*
 方法描述:
 查看全部评论
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)allCommitClick:(id)sender {
    
    CommitVC *vc = [[CommitVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
/*
 方法描述:
 查看全部问答
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)allQAClick:(id)sender {
    Q_AListVC *vc = [[Q_AListVC alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

}
/*
 方法描述:
 我要提问
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)askClick:(id)sender {
}
/*
 方法描述:
 投递简历
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)resumeClick:(id)sender {
    
    ResumeAlertVC *vc = [[ResumeAlertVC alloc]init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.sureClick = ^{
        /**确认投递*/
    };
    [self.navigationController presentViewController:vc animated:NO completion:nil];
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
