//
//  LoginVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/26.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "LoginVC.h"
#import "LoginAlertVC.h"
#import "ForgetPswVc.h"
#import "RegisterVC.h"

@interface LoginVC ()

@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginClick:(id)sender {
    LoginAlertVC *vc = [[LoginAlertVC alloc]init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    vc.forgetPswClick = ^(void){
        ForgetPswVc *vc = [[ForgetPswVc alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    vc.registerClick = ^(void){
        RegisterVC *vc = [[RegisterVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    [self.navigationController presentViewController:vc animated:NO completion:nil];
}
- (IBAction)registerClick:(id)sender {
    RegisterVC *vc = [[RegisterVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
