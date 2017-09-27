//
//  LoginAlertVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/26.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "LoginAlertVC.h"
#import "AppDelegate.h"

@interface LoginAlertVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (weak, nonatomic) IBOutlet UILabel *agreementLabel;

@end

@implementation LoginAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kClearColor;

    NSMutableAttributedString *content = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"使用协议"]];
    NSRange contentRange = {0,[content length]};
    [content addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:contentRange];
    
    self.agreementLabel.attributedText = content;
    
    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    toolbar.barStyle = UIBlurEffectStyleDark;
    [_backView addSubview:toolbar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)loginClick:(id)sender {
    [((AppDelegate *)[[UIApplication sharedApplication] delegate]) gotoHome];
}
- (IBAction)closeClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)forgetPswClick:(id)sender {
    if (self.forgetPswClick) {
        self.forgetPswClick();
    }
}
- (IBAction)registerClick:(id)sender {
    if (self.registerClick) {
        self.registerClick();
    }
}
- (IBAction)agreementClick:(id)sender {
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
