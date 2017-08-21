//
//  OrderDemoVC.m
//  FrameWork2.0
//
//  Created by jiaming yan on 16/7/26.
//  Copyright © 2016年 yanjiaming. All rights reserved.
//

#import "OrderDemoVC.h"
#import "ZJScrollPageView.h"
#import "OrderListViewController.h"
@interface OrderDemoVC ()<ZJScrollPageViewDelegate>
@property(strong, nonatomic)NSArray<NSString *> *titles;
@end

@implementation OrderDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"订单效果";
    //必要的设置, 如果没有设置可能导致内容显示不正常
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ZJSegmentStyle *style = [[ZJSegmentStyle alloc] init];
    //显示滚动条
    style.showLine = YES;
    style.scrollTitle = NO;
    style.scrollLineHeight = 2;//滚动条粗细
    style.scrollLineColor = kGreenColor;//滚动条颜色
    style.titleMargin = 15;//标题之间的间隙 默认为15.0
    style.titleFont = k15Font;//标题的字体 默认为14
    style.normalTitleColor = [UIColor orangeColor];//标题一般状态的颜色
    style.selectedTitleColor = [UIColor yellowColor];//标题选中状态的颜色
    style.segmentHeight = 30;//segmentVIew的高度, 这个属性只在使用ZJScrollPageVIew的时候设置生效
    
    // 颜色渐变
    style.gradualChangeTitleColor = YES;
    
    self.titles = @[@"全部",
                    @"已完成",
                    @"已评价",
                    @"退款",
                    ];
    // 初始化
    ZJScrollPageView *scrollPageView = [[ZJScrollPageView alloc] initWithFrame:CGRectMake(0, 0.0, kScreenWidth, kScreenHeight - 64.0) segmentStyle:style titles:self.titles parentViewController:self delegate:self];
    
    [self.view addSubview:scrollPageView];
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
        childVc = [[OrderListViewController alloc] init];
        if ([childVc isKindOfClass:[OrderListViewController class]]) {
            ((OrderListViewController *)childVc).selectIndex = index;
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
