//
//  MySelfVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/31.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "MySelfVC.h"
#import "MyCollectionVC.h"
#import "MyCommitVC.h"
#import "MyAttendTopicListVC.h"
#import "FeedBackVC.h"
#import "SettingVC.h"
#import "InterviewEndListVC.h"
#import "InterviewNOVC.h"
#import "SubmittedJobVC.h"
#import "BaseInformationViewController.h"
#import "ExperiencedBirdVC.h"
#import "VitaeVC.h"

@interface MySelfVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollWidth;

@end

@implementation MySelfVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
    self.scrollWidth.constant = kScreenWidth;
}
- (IBAction)myInfoClick:(id)sender {
    BaseInformationViewController *vc = [[BaseInformationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------返回
- (IBAction)backClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ------设置
- (IBAction)settingClick:(id)sender {
    
    SettingVC *vc = [[SettingVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ------已投职位、待面试、已面试点击
- (IBAction)middleButtonClick:(UIButton *)sender {
    if (sender.tag == 1) {/**已投递职位*/
        SubmittedJobVC *vc = [[SubmittedJobVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    else if (sender.tag == 2) {/**已面试*/
        InterviewNOVC *vc = [[InterviewNOVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
   else if (sender.tag == 3) {/**已面试*/
        InterviewEndListVC *vc = [[InterviewEndListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}
#pragma mark ------底部多个按钮点击事件
- (IBAction)bottomButtonClick:(UIButton *)sender {
    
    switch (sender.tag) {
            
        case 1:/**我的简历*/
        {
            VitaeVC *vc = [[VitaeVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:/**我的收藏*/
        {
            MyCollectionVC *vc = [[MyCollectionVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:/**我的评论*/
        {
            MyCommitVC *vc = [[MyCommitVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:/**我参与的话题*/
        {
            MyAttendTopicListVC *vc = [[MyAttendTopicListVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:/**申请成为老鸟*/
        {
            ExperiencedBirdVC *vc = [[ExperiencedBirdVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:/**意见反馈*/
        {
            FeedBackVC *vc = [[FeedBackVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
           
        default:
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
