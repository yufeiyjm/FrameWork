//
//  SettingVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/8.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SettingVC.h"

@interface SettingVC ()
@property (weak, nonatomic) IBOutlet UIButton *switchButton1;
@property (weak, nonatomic) IBOutlet UIButton *switchButton2;

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"设置";
    [self.switchButton1 setImage:IMAGE(@"开放任意职位") forState:UIControlStateNormal];
    [self.switchButton1 setImage:IMAGE(@"开放测评结果") forState:UIControlStateSelected];
    [self.switchButton2 setImage:IMAGE(@"开放任意职位") forState:UIControlStateNormal];
    [self.switchButton2 setImage:IMAGE(@"开放测评结果") forState:UIControlStateSelected];
}
- (IBAction)switchButtonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
}
- (IBAction)bottomButtnClick:(UIButton *)sender {
}
- (IBAction)logoutClick:(id)sender {
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
