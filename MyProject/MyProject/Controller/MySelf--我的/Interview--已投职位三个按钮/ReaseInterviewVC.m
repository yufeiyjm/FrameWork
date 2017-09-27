//
//  ReaseInterviewVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/19.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ReaseInterviewVC.h"
#import "IQTextView.h"

@interface ReaseInterviewVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet IQTextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextField *tagTextField;
@property (weak, nonatomic) IBOutlet UIView *tagBackView;
@property (weak, nonatomic) IBOutlet UIButton *difficultyButton1;
@property (weak, nonatomic) IBOutlet UIButton *difficultyButton2;
@property (weak, nonatomic) IBOutlet UIButton *difficultyButton3;
@property (copy, nonatomic) NSString *difficultyStr;
@property (strong, nonatomic) NSMutableArray *tagArr;

@end

@implementation ReaseInterviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发布面试经验";
    self.contentTextView.placeholder  = @"分享您的面试经验";
    self.difficultyStr = @"";
    self.tagArr = [NSMutableArray array];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x13bacd) forState:UIControlStateNormal];
    button.titleLabel.font = k15Font;
    button.frame = CGRectMake(0, 0, 40, 40);
    [button addTarget:self action:@selector(addButtonClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = @[negativeSpacer,barItem];
    
}
-(void)addButtonClick{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.tagArr.count >= 2) {
        ALERT_VIEW(@"最多只能填写2个标签");
        return NO;
    }
    [self.tagArr addObject:textField.text];
    
    [self loadTagView];
    textField.text = @"";
    return NO;
}
-(void)deleteButtonClick:(UIButton *)sender{
    [self.tagArr removeObjectAtIndex:sender.tag];
    [self loadTagView];
}
-(void)loadTagView{
    for (UIView *aView in [self.tagBackView subviews]) {
        if ([aView isKindOfClass:[UILabel class]] || [aView isKindOfClass:[UIButton class]] ) {
            [aView removeFromSuperview];
        }
        
    }
    CGFloat x = 12;
    for (NSInteger i = 0 ;i < self.tagArr.count; i++) {
        UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(x, 18, 10, 20)];
        lab.backgroundColor = UIColorFromRGB(0xE1F1F4);
        lab.text = self.tagArr[i];
        lab.clipsToBounds = YES;
        lab.layer.cornerRadius = 10;
        [self.tagBackView addSubview:lab];
        lab.font = k12Font;
        lab.textColor = UIColorFromRGB(0x1aa9ba);
        lab.textAlignment = NSTextAlignmentCenter;
        [lab sizeToFit];
        lab.frame = CGRectMake(lab.mj_x, lab.mj_y, lab.mj_w + 20, 20);
        x = lab.mj_x + lab.mj_w + 20;
        
        UIButton *deleteButton = [[UIButton alloc]initWithFrame:CGRectMake(lab.mj_x + lab.mj_w - 7, lab.mj_y - 7, 14, 14)];
        [deleteButton setImage:IMAGE(@"发布面试关闭") forState:UIControlStateNormal];
        deleteButton.tag = i;
        [deleteButton addTarget:self action:@selector(deleteButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tagBackView addSubview:deleteButton];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)difficultyButtonClick:(UIButton *)sender {
    
    if (sender == self.difficultyButton1) {
        self.difficultyStr = @"1";
        [self.difficultyButton1 setBackgroundColor:UIColorFromRGB(0X1AA9BA)];
        [self.difficultyButton1 setTitleColor:UIColorFromRGB(0Xffffff) forState:UIControlStateNormal];
        
        [self.difficultyButton2 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton2 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
        
        [self.difficultyButton3 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton3 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
    }else  if (sender == self.difficultyButton2) {
        self.difficultyStr = @"2";
        [self.difficultyButton2 setBackgroundColor:UIColorFromRGB(0X1AA9BA)];
        [self.difficultyButton2 setTitleColor:UIColorFromRGB(0Xffffff) forState:UIControlStateNormal];
        
        [self.difficultyButton1 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton1 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
        
        [self.difficultyButton3 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton3 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
    }else  if (sender == self.difficultyButton3) {
        self.difficultyStr = @"3";
        [self.difficultyButton3 setBackgroundColor:UIColorFromRGB(0X1AA9BA)];
        [self.difficultyButton3 setTitleColor:UIColorFromRGB(0Xffffff) forState:UIControlStateNormal];
        
        [self.difficultyButton1 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton1 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
        
        [self.difficultyButton2 setBackgroundColor:UIColorFromRGB(0Xffffff)];
        [self.difficultyButton2 setTitleColor:UIColorFromRGB(0X6C7374) forState:UIControlStateNormal];
    }

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
