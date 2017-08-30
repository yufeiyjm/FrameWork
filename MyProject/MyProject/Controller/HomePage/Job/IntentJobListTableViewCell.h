//
//  IntentJobListTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/8/29.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntentJobListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

@end
