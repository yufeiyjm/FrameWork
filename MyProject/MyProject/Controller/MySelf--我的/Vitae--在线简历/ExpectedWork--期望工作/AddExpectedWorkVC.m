//
//  AddExpectedWorkVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AddExpectedWorkVC.h"
#import "TypePickerView.h"

@interface AddExpectedWorkVC ()
@property (weak, nonatomic) IBOutlet UITextField *jobNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;

@property (weak, nonatomic) IBOutlet UITextField *salaryTextField;
@end

@implementation AddExpectedWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"期望工作";
    
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
   
    if (textField == self.jobTypeTextField) {
        [self.view endEditing:YES];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = @[@"全职",@"兼职"];
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.jobTypeTextField.text = timeStr;
        };
        [time creatTypePickerView:self.view];
        return NO;
    }
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
