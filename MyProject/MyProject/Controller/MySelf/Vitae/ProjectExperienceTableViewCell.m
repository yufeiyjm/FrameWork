//
//  ProjectExperienceTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ProjectExperienceTableViewCell.h"

@implementation ProjectExperienceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
-(void)setProjectArr:(NSArray *)projectArr{
    
    CGFloat height = 0;
    for (NSInteger i = 0 ; i < projectArr.count; i++) {
        
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(14, 17 + 130 * i, kScreenWidth - 130, 18)];
        timeLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        timeLab.textAlignment = NSTextAlignmentLeft;
        timeLab.textColor = UIColorFromRGB(0xadb6bc);
        [self.backView addSubview:timeLab];
        timeLab.text = @"2017.4-2017.6";
        
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(14, timeLab.mj_y + timeLab.mj_h + 7, kScreenWidth - 130, 18)];
        nameLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        nameLab.textAlignment = NSTextAlignmentLeft;
        nameLab.textColor = UIColorFromRGB(0x6c7374);
        [self.backView addSubview:nameLab];
        nameLab.text = @"【项目名称】 约伴";
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(14, nameLab.mj_y + nameLab.mj_h + 7, kScreenWidth - 130, 18)];
        detailLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.textColor = UIColorFromRGB(0x6c7374);
        [self.backView addSubview:detailLab];
        detailLab.text = @"【项目职责】 产品设计";
        
        
        UILabel *detailDesLab = [[UILabel alloc]initWithFrame:CGRectMake(14, detailLab.mj_y + detailLab.mj_h + 7, kScreenWidth - 130, 17)];
        detailDesLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
        detailDesLab.textAlignment = NSTextAlignmentLeft;
        detailDesLab.textColor = UIColorFromRGB(0xadb6bc);
        [self.backView addSubview:detailDesLab];
        detailDesLab.text = @"全职/大连/10-15K";
        [detailDesLab sizeToFit];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, detailDesLab.mj_y + detailDesLab.mj_h + 20 , kScreenWidth - 20, 0.5)];
        line.backgroundColor = UIColorFromRGB(0xe4eaf4);;
        [self.backView addSubview:line];
        
        if (i == (projectArr.count - 1)) {
            line.hidden = YES;
        }
        
       height = line.mj_y + line.mj_h;
    }
    self.backHeight.constant = height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
