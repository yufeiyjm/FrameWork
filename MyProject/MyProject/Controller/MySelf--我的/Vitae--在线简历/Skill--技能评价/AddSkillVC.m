//
//  AddSkillVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/13.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "AddSkillVC.h"

@interface AddSkillVC ()
@property (weak, nonatomic) IBOutlet UIButton *typeButton1;
@property (weak, nonatomic) IBOutlet UIButton *typeButton2;
@property (weak, nonatomic) IBOutlet UIButton *typeButton3;

@end

@implementation AddSkillVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"编辑技能";
    self.view.backgroundColor = kWhiteColor;
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
- (IBAction)typeButtonClick:(UIButton *)sender {
    if (sender == self.typeButton1) {
        self.typeButton1.backgroundColor = UIColorFromRGB(0x1AA9BA);
        [self.typeButton1 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.typeButton2.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton2 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
        self.typeButton3.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton3 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
    }else if (sender == self.typeButton2) {
        self.typeButton2.backgroundColor = UIColorFromRGB(0x1AA9BA);
        [self.typeButton2 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.typeButton1.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton1 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
        self.typeButton3.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton3 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
    }else if (sender == self.typeButton3) {
        self.typeButton3.backgroundColor = UIColorFromRGB(0x1AA9BA);
        [self.typeButton3 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        self.typeButton2.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton2 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
        self.typeButton1.backgroundColor = UIColorFromRGB(0xffffff);
        [self.typeButton1 setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
        
    }
    
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
