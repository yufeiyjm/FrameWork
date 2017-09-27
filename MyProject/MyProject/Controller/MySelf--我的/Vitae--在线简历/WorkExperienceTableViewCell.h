//
//  EmptyTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/12.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkExperienceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backHeight;
@property (strong, nonatomic)  NSArray *workExperienceArr;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end
