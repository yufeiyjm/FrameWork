//
//  BannerVC.m
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/27.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import "BannerVC.h"
#import "ImagePlayerView.h"
#import "UIImageView+MHFacebookImageViewer.h"
@interface BannerVC ()<ImagePlayerViewDelegate,MHFacebookImageViewerDatasource>
@property (nonatomic, strong)  NSArray *imageURLs;
@property (weak, nonatomic) IBOutlet ImagePlayerView *headImageView;

@end

@implementation BannerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.headImageView.imagePlayerViewDelegate = self;
   self.imageURLs = @[@"http://7xjcc5.com2.z0.glb.clouddn.com/files/photos/qlnBWKae1477626025_300x0_2"];
    [self.headImageView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - ImagePlayerViewDelegate
- (NSInteger)numberOfItems
{
    return self.imageURLs.count;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index
{
    [imageView setupImageViewerWithDatasource:self initialIndex:index  onOpen:^{
        NSLog(@"OPEN!");
    } onClose:^{
        NSLog(@"CLOSE!");
    }];
    // recommend to use SDWebImage lib to load web image
    [imageView sd_setImageWithURL:[self.imageURLs objectAtIndex:index] placeholderImage:IMAGE(@"默认图")];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    
   
}

- (NSInteger) numberImagesForImageViewer:(MHFacebookImageViewer *)imageViewer {
    return self.imageURLs.count;
}
-  (NSURL*) imageURLAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer {
    return [NSURL URLWithString:[self.imageURLs objectAtIndex:index]];
}

- (UIImage*) imageDefaultAtIndex:(NSInteger)index imageViewer:(MHFacebookImageViewer *)imageViewer{
    return IMAGE(@"默认图1");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
