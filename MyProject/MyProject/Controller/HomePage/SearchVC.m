//
//  SearchVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/28.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SearchVC.h"
#import "HXTagAttribute.h"
#import "HXTagsView.h"
#import "SearchListVC.h"
@interface SearchVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UIImageView *searchImageView;
@property (weak, nonatomic) IBOutlet HXTagsView *historyView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historyHeight;
@property (weak, nonatomic) IBOutlet HXTagsView *hotView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotHeight;

@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    [self.searchTextField addTarget:self action:@selector(textFieldEditChange:) forControlEvents:UIControlEventEditingChanged];
    self.view.backgroundColor = UIColorFromRGB(0xF2F5FA);
    self.navigationController.navigationBarHidden = YES;
    
    
    _historyView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        SearchListVC *vc = [[SearchListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    _historyView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _historyView.layout.itemSize = CGSizeMake(100.0f, 30.0f);
    _historyView.tags = @[@"产品经理",@"JAVA",@"大连圣笛科技",@"家里蹲"];
    [_historyView reloadData];
    HXTagAttribute *model = [[HXTagAttribute alloc]init];
    model.borderWidth  = 0;
    model.borderColor  = kClearColor;
    model.cornerRadius  = 15;
    model.titleSize  = 15;
    model.textColor  = UIColorFromRGB(0x6c7374);
    model.normalBackgroundColor  = UIColorFromRGB(0xffffff);
    model.selectedBackgroundColor  = UIColorFromRGB(0x1aa9ba);
    model.tagSpace  = 20;
    
    _historyView.tagAttribute = model;
    
    CGFloat height = [HXTagsView getHeightWithTags:_historyView.tags layout:_historyView.layout tagAttribute:_historyView.tagAttribute width:kScreenWidth - 28];
    self.historyHeight.constant = height + 0;
    _historyView.frame = CGRectMake(14, 123, kScreenWidth - 28, height);
    [_historyView reloadData];
    
    
    _hotView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
        
        SearchListVC *vc = [[SearchListVC alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    };
    _hotView.layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _hotView.layout.itemSize = CGSizeMake(100.0f, 30.0f);
    _hotView.tags = @[@"产品经理",@"JAVA",@"大连圣笛科技",@"家里蹲",@"JAVA1",@"大连圣笛科技1",@"家里蹲1",@"JAVA2",@"大连圣笛科技2",@"家里蹲2"];
    [_hotView reloadData];
    HXTagAttribute *hotHeightModel = [[HXTagAttribute alloc]init];
    hotHeightModel.borderWidth  = 0;
    hotHeightModel.borderColor  = kClearColor;
    hotHeightModel.cornerRadius  = 15;
    hotHeightModel.titleSize  = 15;
    hotHeightModel.textColor  = UIColorFromRGB(0x6c7374);
    hotHeightModel.normalBackgroundColor  = UIColorFromRGB(0xffffff);
    hotHeightModel.selectedBackgroundColor  = UIColorFromRGB(0x1aa9ba);
    hotHeightModel.tagSpace  = 20;
    
    _hotView.tagAttribute = hotHeightModel;
    CGFloat hotHeight = [HXTagsView getHeightWithTags:_hotView.tags layout:_hotView.layout tagAttribute:_hotView.tagAttribute width:kScreenWidth - 28];
    self.hotHeight.constant = hotHeight + 0;
//    _hotView.frame = CGRectMake(14, _hotView.mj_y, kScreenWidth - 28, hotHeight);
    [_hotView reloadData];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentLeft;
    self.searchImageView.hidden = YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    SearchListVC *vc = [[SearchListVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField{
    textField.textAlignment = NSTextAlignmentCenter;
    self.searchImageView.hidden = NO;
    return YES;
}
//-(void)textFieldEditChange:(UITextField *)textField{
//    if (textField.text.length > 0) {
//        self.searchImageView.hidden = YES;
//    }else{
//        self.searchImageView.hidden = NO;
//    }
//}
- (IBAction)closeClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
