//
//  DateSignTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/16.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MHFacebookImageViewer.h"

@interface DateSignTableViewCell : UITableViewCell<MHFacebookImageViewerDatasource>
@property (weak, nonatomic) IBOutlet UIButton *zanButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIImageView *signImageView;
@end
