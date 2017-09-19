//
//  SpecialDetailTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/18.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MHFacebookImageViewer.h"

@interface SpecialDetailTableViewCell : UITableViewCell<MHFacebookImageViewerDatasource>
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackHeight;
@property (strong, nonatomic) NSArray *imageArr;
@property (weak, nonatomic) IBOutlet UIButton *reportButton;

@end
