//
//  CommitTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "CommitTableViewCell.h"
#import "HXTagAttribute.h"

@implementation CommitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _tagBackView.completion = ^(NSArray *selectTags,NSInteger currentIndex) {
        NSLog(@"selectTags:%@ currentIndex:%ld",selectTags, (long)currentIndex);
    };
    _tagBackView.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _tagBackView.tags = @[@"环境高大上",@"老板是美女",@"薪资很高"];
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
