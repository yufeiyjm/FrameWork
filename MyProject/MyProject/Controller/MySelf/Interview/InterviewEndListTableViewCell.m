//
//  InterviewEndListTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/8.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "InterviewEndListTableViewCell.h"
#import "HXTagAttribute.h"

@implementation InterviewEndListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.scaleLabel.font = [UIFont fontWithName:@"DIN Condensed" size:18];
    _tagBackView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
    };
    _tagBackView.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _tagBackView.tags = @[@"沟通能力",@"团队协作",@"日语",@"学习能力"];
    [_tagBackView reloadData];
    HXTagAttribute *model = [[HXTagAttribute alloc]init];
    model.borderWidth  = 0;
    model.borderColor  = kClearColor;
    model.cornerRadius  = 8;
    model.titleSize  = 11;
    model.textColor  = UIColorFromRGB(0x1aa9ba);
    model.normalBackgroundColor  = UIColorFromRGB(0xe2f2f4);
    model.selectedBackgroundColor  = UIColorFromRGB(0xe2f2f4);
    model.tagSpace  = 8;
    
    _tagBackView.tagAttribute = model;
    
    [_tagBackView reloadData];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
