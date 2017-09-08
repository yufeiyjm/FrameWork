//
//  InterviewEndListTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/8.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagsView.h"

@interface InterviewEndListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *scaleLabel;
@property (weak, nonatomic) IBOutlet HXTagsView *tagBackView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *jobNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@end
