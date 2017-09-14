//
//  AddWorkExperienceVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AddWorkExperienceVC.h"
#import "TypePickerView.h"
#import "IQTextView.h"

@interface AddWorkExperienceVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *companyTextField;
@property (weak, nonatomic) IBOutlet UITextField *jobNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *entryTimeTextField;
@property (weak, nonatomic) IBOutlet UITextField *quitTimeTextField;
@property (weak, nonatomic) IBOutlet IQTextView *contentTextView;

@end

@implementation AddWorkExperienceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"编辑工作经历";
    
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
    self.contentTextView.placeholder = @"请输入工作内容";
}
-(void)saveButtonClick{
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    __weak typeof(self) weakSelf = self;
    NSDate* _date = [NSDate date];
    
    /*添加你自己响应代码*/
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy"];

    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:_date];
    NSMutableArray *yearArr = [NSMutableArray array];
    
    for (NSInteger i = 0; i < 30; i++) {
        [yearArr addObject:[NSString stringWithFormat:@"%zd",[currentDateStr integerValue] - i]];
        
    }
    if (textField == self.entryTimeTextField) {
        [self.view endEditing:YES];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = yearArr;
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.entryTimeTextField.text = [NSString stringWithFormat:@"%@入职",timeStr];
        };
        [time creatTypePickerView:self.view];
        return NO;
    }else if (textField == self.quitTimeTextField) {
        [self.view endEditing:YES];
        [yearArr insertObject:@"至今" atIndex:0];
        TypePickerView *time = [[TypePickerView alloc]init];
        time.typeArr = yearArr;
        time.selectPicker = ^(NSString *timeStr){
            weakSelf.quitTimeTextField.text = timeStr;
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
