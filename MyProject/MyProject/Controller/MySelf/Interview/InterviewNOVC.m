//
//  InterviewNOVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/9/8.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "InterviewNOVC.h"
#import "ZJScrollPageView.h"
#import "InterviewNOListVC.h"
#import "WaitUpVideoListVC.h"

@interface InterviewNOVC ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;


@end

@implementation InterviewNOVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"待面试职位";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    style.scrollTitle = NO;
    style.scrollLineHeight = 2;//滚动条粗细
    style.scrollLineColor = UIColorFromRGB(0x1eb0c1);//滚动条颜色
    style.titleMargin = 15;//标题之间的间隙 默认为15.0
    style.titleFont = k15Font;//标题的字体 默认为14
    style.normalTitleColor = UIColorFromRGB(0xaabbc3);//标题一般状态的颜色
    style.selectedTitleColor = UIColorFromRGB(0x1eb0c1);//标题选中状态的颜色
    style.segmentHeight = 45;//segmentVIew的高度, 这个属性只在使用ZJScrollPageVIew的时候设置生效
    
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"◇  待面试",
                    @"◇  待上传视频"
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0.0, kScreenWidth, kScreenHeight - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
    
    UIView *aView = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth/2 - 1, 14, 2, 15)];
    [aView setBackgroundColor:UIColorFromRGB(0xf3f4f5)];
    [self.view addSubview:aView];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 0.5)];
    [lineView setBackgroundColor:UIColorFromRGB(0xf3f4f5)];
    [self.view addSubview:lineView];
}
- (NSInteger)numberOfChildViewControllers {
    return self.titles.count;
}

/*
 方法描述:
 1、设置每一栏的viewcontroller。
 2、一般在这个方法中传入一些属性参数，然后在不同的VC中请求网络。
 3、注意该VC需要继承一个代理。
 参数说明:
 index：判断第几个
 
 返回结果:
 <#返回结果#>
 
 */
- (UIViewController<ZJScrollPageViewChildVcDelegate> *)childViewController:(UIViewController<ZJScrollPageViewChildVcDelegate> *)reuseViewController forIndex:(NSInteger)index {
    UIViewController<ZJScrollPageViewChildVcDelegate> *childVc = reuseViewController;
    
    if (!childVc) {
        if (index == 0) {
            childVc = [[InterviewNOListVC alloc] init];
        }else{
            childVc = [[WaitUpVideoListVC alloc] init];
        }
        
        
    }
    
    
    NSLog(@"%ld-----%@",(long)index, childVc);
    
    return childVc;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
