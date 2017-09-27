//
//  AddProjectExperienceVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AddProjectExperienceVC.h"
#import "IQTextView.h"
#import "TimeSelectView.h"

@interface AddProjectExperienceVC ()
@property (weak, nonatomic) IBOutlet UITextField *projectNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTextField;
@property (weak, nonatomic) IBOutlet UITextField *beginTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *endTimeTextField;
@property (weak, nonatomic) IBOutlet IQTextView *desTextView;

@end

@implementation AddProjectExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"编辑项目经历";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x13bacd) forState:UIControlStateNormal];
    button.titleLabel.font = k15Font;
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(saveButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,barItem];
}
-(void)saveButtonClick{
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    __weak typeof(self) weakSelf = self;
    
    if (textField == self.beginTimeTextField) {
        [self.view endEditing:YES];
        TimeSelectView *time = [[TimeSelectView alloc]init];
        time.selectTime = ^(NSString *timeStr){
            weakSelf.beginTimeTextField.text = [NSString stringWithFormat:@"%@",timeStr];
        };
        [time creatTimeSelectView:self.view];
        time.timePicker.maximumDate= [NSDate date];
        return NO;
    }else if (textField == self.endTimeTextField) {
        [self.view endEditing:YES];
        TimeSelectView *time = [[TimeSelectView alloc]init];
        time.selectTime = ^(NSString *timeStr){
            weakSelf.endTimeTextField.text = [NSString stringWithFormat:@"%@",timeStr];
        };
        [time creatTimeSelectView:self.view];
        time.timePicker.maximumDate= [NSDate date];
        return NO;
    }
    UIView *tempView = [self.view viewWithTag:909090901];
    [tempView removeFromSuperview];
    return YES;
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    UIView *tempView = [self.view viewWithTag:909090901];
    [tempView removeFromSuperview];
    return YES;
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
