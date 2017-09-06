//
//  SelectVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/5.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SelectVC.h"
#import "SelectTableViewCell.h"

@interface SelectVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSMutableArray *arrData;//图片名数组
@property (assign, nonatomic)  NSInteger selectIndex;//已选择
@end

@implementation SelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"测试";
    self.selectIndex = -1;
    self.view.backgroundColor = kWhiteColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SelectTableViewCell" bundle:nil] forCellReuseIdentifier:@"SelectTableViewCell"];
    self.tableView.estimatedRowHeight = 37.0f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.tableFooterView = [[UIView alloc]init];
    UIImageView *img = [[UIImageView alloc]initWithImage:IMAGE(@"测试背景图-")];
    img.contentMode = UIViewContentModeScaleAspectFill;
    self.tableView.backgroundView = img;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;self.arrData.count;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 37;
//}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *identifier = @"SelectTableViewCell";
    SelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    cell.lineView.hidden = NO;
    if (indexPath.row == 0) {
        cell.indexLabel.text = @"A";
    }else if (indexPath.row == 1) {
        cell.indexLabel.text = @"B";
    }else if (indexPath.row == 2) {
        cell.indexLabel.text = @"C";
        cell.titleLabel.text = @"cellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcellcell";
    }else if (indexPath.row == 3) {
        cell.indexLabel.text = @"D";
        cell.lineView.hidden = YES;
    }
    if (indexPath.row == self.selectIndex) {
        cell.indexLabel.backgroundColor = UIColorFromRGB(0x1eb0c1);
        cell.indexLabel.textColor = kWhiteColor;
        cell.indexLabel.layer.borderColor = UIColorFromRGB(0x000000).CGColor;
    }else{
        cell.indexLabel.backgroundColor = UIColorFromRGB(0xffffff);
        cell.indexLabel.textColor =  UIColorFromRGB(0x1eb0c1);
        cell.indexLabel.layer.borderColor = UIColorFromRGB(0xE5EDEE).CGColor;
    }
    cell.indexButton.tag = indexPath.row;
    [cell.indexButton addTarget:self action:@selector(indexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

-(void)indexButtonClick:(UIButton *)sender{
    self.selectIndex = sender.tag;
    [self.tableView reloadData];
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
