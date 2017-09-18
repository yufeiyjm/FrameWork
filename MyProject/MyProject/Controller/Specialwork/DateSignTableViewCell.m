//
//  DateSignTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/16.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "DateSignTableViewCell.h"

@implementation DateSignTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    
    [self.signImageView setupImageViewerWithDatasource:self initialIndex:0  onOpen:^{
        NSLog(@"OPEN!");
    } onClose:^{
        NSLog(@"CLOSE!");
    }];

}

- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer *)imageViewer {
    return 1;
}
-  (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer {
    NSString *path= [[NSBundle mainBundle]pathForResource:@"riqian" ofType:@"png"];
    return [NSURL fileURLWithPath:path];
}

- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer{
    return IMAGE(@"默认图1");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
