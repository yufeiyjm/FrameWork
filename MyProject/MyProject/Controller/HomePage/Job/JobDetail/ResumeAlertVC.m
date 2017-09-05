//
//  ResumeAlertVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/30.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ResumeAlertVC.h"

@interface ResumeAlertVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation ResumeAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kClearColor;
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurEffectView.frame = _backView.bounds;
    [_backView addSubview:blurEffectView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)finishClick:(id)sender {
}
- (IBAction)cancleClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
