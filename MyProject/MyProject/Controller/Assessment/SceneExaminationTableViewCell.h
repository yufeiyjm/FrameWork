//
//  SceneExaminationTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/5.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HCSStarRatingView.h"

@interface SceneExaminationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet HCSStarRatingView *starRatingView;
@property (weak, nonatomic) IBOutlet UILabel *indexLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
