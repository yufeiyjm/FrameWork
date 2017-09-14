//
//  DescribeVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "DescribeVC.h"
#import "IQTextView.h"

@interface DescribeVC ()
@property (weak, nonatomic) IBOutlet IQTextView *desTextView;

@end

@implementation DescribeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"编辑自我描述";
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
    self.desTextView.placeholder = @"请输入自我描述";
}
-(void)saveButtonClick{
    
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
