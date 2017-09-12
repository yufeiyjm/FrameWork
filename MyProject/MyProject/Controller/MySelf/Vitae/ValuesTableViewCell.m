//
//  ValuesTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ValuesTableViewCell.h"
#import "HXTagAttribute.h"

@implementation ValuesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}
-(void)setValuesArr:(NSArray *)valuesArr{
    
}
- (IBAction)tagButtonClick:(UIButton *)sender {
    if (sender.selected == NO) {
        sender.backgroundColor = UIColorFromRGB(0x1AA9BA);
        [sender setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
    }else{
        sender.backgroundColor = UIColorFromRGB(0xffffff);
        [sender setTitleColor:UIColorFromRGB(0x6C7374) forState:UIControlStateNormal];
    }
    sender.selected = !sender.selected;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
