//
//  GossipListTableViewCell.h
//  MyProject
//
//  Created by jiaming yan on 2017/9/6.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+MHFacebookImageViewer.h"

@interface GossipListTableViewCell : UITableViewCell<MHFacebookImageViewerDatasource>
@property (weak, nonatomic) IBOutlet UIView *imageBackView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageBackTop;
@property (strong, nonatomic) NSArray *imageArr;

@end
