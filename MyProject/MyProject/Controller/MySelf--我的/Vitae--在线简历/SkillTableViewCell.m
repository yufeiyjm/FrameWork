//
//  SkillTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "SkillTableViewCell.h"

@implementation SkillTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
-(void)setSkillArr:(NSArray *)skillArr{
    
    CGFloat height = 0;
    for (NSInteger i = 0 ; i < skillArr.count; i++) {
        UILabel *labMust = [[UILabel alloc]initWithFrame:CGRectMake(14, 55 * i, kScreenWidth - 130, 55)];
        labMust.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        labMust.textAlignment = NSTextAlignmentLeft;
        labMust.textColor = UIColorFromRGB(0x6c7374);
        [self.backView addSubview:labMust];
        labMust.text = @"JAVA语言";
        [labMust sizeToFit];
        labMust.frame = CGRectMake(labMust.mj_x, labMust.mj_y, labMust.mj_w, 55);
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(labMust.mj_x + labMust.mj_w + 10, 55 * i, kScreenWidth - 130, 55)];
        detailLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.textColor = UIColorFromRGB(0xadb6bc);
        [self.backView addSubview:detailLab];
        detailLab.text = @"熟练";
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, detailLab.mj_y + detailLab.mj_h , kScreenWidth - 20, 0.5)];
        line.backgroundColor = UIColorFromRGB(0xe4eaf4);;
        [self.backView addSubview:line];
        
        if (i == (skillArr.count - 1)) {
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
