//
//  RegisterVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/27.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "RegisterVC.h"
#import "PerfectInfoVC.h"
@interface RegisterVC ()
@property (assign, nonatomic)  NSInteger count;
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pswTextField;
@property (strong, nonatomic)  NSTimer *timer;
@end

@implementation RegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";
    self.view.backgroundColor = kWhiteColor;
}
- (IBAction)verificationCodeClick:(id)sender {
    self.verificationCodeButton.enabled = NO;
    _count = 60;
    _timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    [_timer fire];
}
-(void)timerAction{
    _count --;
    [self.verificationCodeButton setTitle:[NSString stringWithFormat:@"%02zdS",_count] forState:UIControlStateNormal];
    if (self.count <= 0) {
        self.verificationCodeButton.enabled = YES;
        [self.verificationCodeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
        //在这里执行事件
        [_timer invalidate];
        _timer = nil;
    }
    
    
}
- (IBAction)sureButtonClick:(id)sender {
    PerfectInfoVC *vc = [[PerfectInfoVC alloc]init];
    vc.modalPresentationStyle=UIModalPresentationOverCurrentContext;
    vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
   
    [self.navigationController presentViewController:vc animated:NO completion:nil];

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
