//
//  BaseInfoVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "BaseInfoVC.h"
#import "TimeSelectView.h"
#import "TypePickerView.h"
#import "IQTextView.h"

@interface BaseInfoVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UITextField *qualificationsTextField;
@property (weak, nonatomic) IBOutlet UITextField *workYearTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
@property (weak, nonatomic) IBOutlet IQTextView *describeTextView;

@end

@implementation BaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"基本信息";
    self.describeTextView.placeholder = @"请输入一句话描述";
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
    if (textField == self.sexTextField) {
        [self.view endEditing:YES];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = @[@"男",@"女"];
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.sexTextField.text = timeStr;
        };
        [time creatTypePickerView:self.view];
        return NO;
    }else if (textField == self.birthdayTextField) {
         [self.view endEditing:YES];
        TimeSelectView *time = [[TimeSelectView alloc]init];
        time.selectTime = ^(NSString *timeStr){
            weakSelf.birthdayTextField.text = [NSString stringWithFormat:@"%@出生",timeStr];
        };
        [time creatTimeSelectView:self.view];
        time.timePicker.maximumDate= [NSDate date];
        return NO;
    }else if (textField == self.qualificationsTextField) {
         [self.view endEditing:YES];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = @[@"本科",@"专科",@"高中",@"硕士",@"博士"];
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.qualificationsTextField.text = timeStr;
        };
        [time creatTypePickerView:self.view];
        return NO;
    }else if (textField == self.workYearTextField) {
         [self.view endEditing:YES];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = @[@"无经验",@"1年",@"2年",@"3~5年",@"5~10年",@"10年以上"];
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.workYearTextField.text = timeStr;
        };
        [time creatTypePickerView:self.view];
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
