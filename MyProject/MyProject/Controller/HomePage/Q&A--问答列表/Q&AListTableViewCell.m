//
//  Q&AListTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "Q&AListTableViewCell.h"

@implementation Q_AListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
