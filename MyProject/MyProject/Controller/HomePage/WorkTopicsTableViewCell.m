//
//  WorkTopicsTableViewCell.m
//  MyProject
//
//  Created by jiaming yan on 2017/8/21.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "WorkTopicsTableViewCell.h"

@implementation WorkTopicsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    self.commentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
}

-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    for (UIView *aView in [self.imageBackView subviews]) {
        [aView removeFromSuperview];
    }
    if (imageArr.count == 0) {
        self.imageBackTop.constant = 0;
        self.imageBackHeight.constant = 0;
    }else if (imageArr.count == 1){
        self.imageBackTop.constant = 15;
        self.imageBackHeight.constant = 158;
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(0, 0, 158, 158) url:imageArr[0] index:0]];
    }else if (imageArr.count == 2){
        self.imageBackTop.constant = 15;
        self.imageBackHeight.constant = (kScreenWidth - 40)/2;
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(0, 0, (kScreenWidth - 40)/2, (kScreenWidth - 40)/2) url:imageArr[0] index:0]];
        [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake((kScreenWidth - 40)/2 + 10, 0, (kScreenWidth - 40)/2, (kScreenWidth - 40)/2) url:imageArr[1] index:1]];
    }else{
        /**图片行数*/
        NSInteger totalLine = (imageArr.count%3==0)?(imageArr.count/3):(imageArr.count/3 + 1);
        self.imageBackHeight.constant = (kScreenWidth - 50 )/3*totalLine + 10*(totalLine - 1);
        for (NSInteger i = 0; i < imageArr.count; i ++) {
            self.imageBackTop.constant = 15;
            NSInteger line = i/3;
            SaintiLog(@"i=%zd,line=%zd,i-3=%zd",i,line,i%3)
            [self.imageBackView addSubview:[self creatImageViewWithFrame:CGRectMake(i%3*((kScreenWidth - 50)/3 + 10), ((kScreenWidth - 50)/3 + 10)*line, (kScreenWidth - 50)/3, (kScreenWidth - 50)/3) url:imageArr[i] index:i]];
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(UIImageView *)creatImageViewWithFrame:(CGRect )frame url:(NSString *)url index:(NSInteger )index{
    UIImageView *img = [[UIImageView alloc]initWithFrame:frame];
    img.contentMode = UIViewContentModeScaleAspectFill;
    [img setupImageViewerWithDatasource:self initialIndex:index  onOpen:^{
        NSLog(@"OPEN!");
    } onClose:^{
        NSLog(@"CLOSE!");
    }];
    img.clipsToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:IMAGE(@"默认图")];
    return img;
}
- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer *)imageViewer {
    return self.imageArr.count;
}
-  (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer {
    return [NSURL URLWithString:[self.imageArr objectAtIndex:index]];
}

- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer{
    return IMAGE(@"默认图1");
}
@end
