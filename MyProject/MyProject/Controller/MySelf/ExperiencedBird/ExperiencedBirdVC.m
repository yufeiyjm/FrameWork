//
//  ExperiencedBirdVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/11.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ExperiencedBirdVC.h"

@interface ExperiencedBirdVC ()
@property (weak, nonatomic) IBOutlet UIButton *picButton;
@property (weak, nonatomic) IBOutlet UIView *sucessView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end

@implementation ExperiencedBirdVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"申请成为老鸟";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)picButtonClick:(id)sender {
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
