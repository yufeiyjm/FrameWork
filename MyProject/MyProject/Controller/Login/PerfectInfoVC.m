//
//  PerfectInfoVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/27.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "PerfectInfoVC.h"

@interface PerfectInfoVC ()
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *sexButton;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@end

@implementation PerfectInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = kClearColor;
    
    [self.sexButton setImage:IMAGE(@"完善信息（男）") forState:UIControlStateNormal];
    [self.sexButton setImage:IMAGE(@"完善信息（女）") forState:UIControlStateSelected];

    
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    toolbar.barStyle = UIBlurEffectStyleDark;
    [_backView addSubview:toolbar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sexClick:(id)sender {
    self.sexButton.selected = !self.sexButton.selected;
}
- (IBAction)placeClick:(id)sender {
}
- (IBAction)nextClick:(id)sender {
}
- (IBAction)closeClick:(id)sender {
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
