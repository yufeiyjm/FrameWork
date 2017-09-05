//
//  ExaminationVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/5.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ExaminationVC.h"
#import "SceneExaminationTableViewCell.h"

@interface ExaminationVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组

@end

@implementation ExaminationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"测试";
    self.view.backgroundColor = kWhiteColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SceneExaminationTableViewCell" bundle:nil] forCellReuseIdentifier:@"SceneExaminationTableViewCell"];
    self.tableView.estimatedRowHeight = 117.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
    UIImageView *img = [[UIImageView alloc]initWithImage:IMAGE(@"测试背景图-")];
    img.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = img;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 67;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"SceneExaminationTableViewCell";
    SceneExaminationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.lineView.hidden = NO;
    if (indexPath.row == 0) {
        cell.indexLabel.text = @"A";
    }else if (indexPath.row == 1) {
        cell.indexLabel.text = @"B";
    }else if (indexPath.row == 2) {
        cell.indexLabel.text = @"C";
        cell.titleLabel.text = @"cellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcell";
    }else if (indexPath.row == 3) {
        cell.indexLabel.text = @"D";
        cell.lineView.hidden = YES;
    }
    return cell;
    
}


- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
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
