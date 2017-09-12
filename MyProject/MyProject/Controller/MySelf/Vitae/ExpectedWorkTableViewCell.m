//
//  ExpectedWorkTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ExpectedWorkTableViewCell.h"

@implementation ExpectedWorkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.editButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
}
-(void)setExpectedWorkArr:(NSArray *)expectedWorkArr{
    self.backHeight.constant = 58 * expectedWorkArr.count + 20;
   
    for (NSInteger i = 0 ; i < expectedWorkArr.count; i++) {
        UILabel *labMust = [[UILabel alloc]initWithFrame:CGRectMake(14, 17 + 58 * i, kScreenWidth - 130, 18)];
        labMust.font = [UIFont fontWithName:@"PingFangSC-Light" size:14];
        labMust.textAlignment = NSTextAlignmentLeft;
        labMust.textColor = UIColorFromRGB(0x6c7374);
        [self.backView addSubview:labMust];
        labMust.text = @"产品经理";
        
        UILabel *detailLab = [[UILabel alloc]initWithFrame:CGRectMake(14, labMust.mj_y + labMust.mj_h + 11, kScreenWidth - 130, 17)];
        detailLab.font = [UIFont fontWithName:@"PingFangSC-Light" size:13];
        detailLab.textAlignment = NSTextAlignmentLeft;
        detailLab.textColor = UIColorFromRGB(0xadb6bc);
        [self.backView addSubview:detailLab];
        detailLab.text = @"全职/大连/10-15K";
        
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
