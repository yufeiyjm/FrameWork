//
//  WorkTopicsTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MHFacebookImageViewer.h"

@interface WorkTopicsTableViewCell : UITableViewCell<MHFacebookImageViewerDatasource>
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackTop;
@property (strong, nonatomic) NSArray *imageArr;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topTitleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineHeight;
@end
