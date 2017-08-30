//
//  CompanyDetailVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/29.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "CompanyDetailVC.h"

@interface CompanyDetailVC ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollWidth;

@end

@implementation CompanyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.scrollWidth.constant = kScreenWidth;
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = UIColorFromRGB(0xF2F5FA);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
