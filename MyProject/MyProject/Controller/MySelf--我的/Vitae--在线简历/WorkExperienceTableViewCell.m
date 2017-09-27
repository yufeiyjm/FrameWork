//
//  EmptyTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "WorkExperienceTableViewCell.h"

@implementation WorkExperienceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
-(void)setWorkExperienceArr:(NSArray *)workExperienceArr{
    self.backHeight.constant = 58 * workExperienceArr.count + 20;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(15.5, 24 , 2, 58 * (workExperienceArr.count - 1 ))];
    line.backgroundColor = UIColorFromRGB(0xE5EDEE);;
    [self.backView addSubview:line];
    for (NSInteger i = 0 ; i < workExperienceArr.count; i++) {
        UIView *circularView = [[UIView alloc]initWithFrame:CGRectMake(13, 24 + 58 * i, 7, 7)];
        circularView.backgroundColor = UIColorFromRGB(0x50BDCA);
        circularView.layer.borderColor = UIColorFromRGB(0x6c7374).CGColor;
        circularView.layer.borderWidth = 1;
        circularView.layer.cornerRadius = 3.5;
        circularView.clipsToBounds = YES;
        [self.backView addSubview:circularView];
        
        
        UILabel *labMust = [[UILabel alloc]initWithFrame:CGRectMake(25, 17 + 58 * i, kScreenWidth - 130, 18)];
        labMust.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        labMust.textAlignment = NSTextAlignmentLeft;
        labMust.textColor = UIColorFromRGB(0x6c7374);
        [self.backView addSubview:labMust];
        labMust.text = @"大连圣笛科技产品经理";
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(25, labMust.mj_y + labMust.mj_h + 11, kScreenWidth - 130, 17)];
        detailLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.textColor = UIColorFromRGB(0xadb6bc);
        [self.backView addSubview:detailLab];
        detailLab.text = @"2017年07月-至今";
        
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
