//
//  ForecastVC.m
//  MyProject
//
//  Created by jiaming yan on 2017/4/14.
//  Copyright © 2017年 yanjiaming. All rights reserved.
//

#import "ForecastVC.h"
#import "AAChartView.h"
#import "ForecastTowVC.h"

@interface ForecastVC ()
@property(nonatomic,strong)AAChartModel *chartModel;
@property(nonatomic,strong)AAChartView *chartView;
@end

@implementation ForecastVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    AAChartTypeArea
    self.navigationItem.title = @"价格走势";
    [self configTheChartView:AAChartTypeArea];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 64, 44);
    [backBtn setTitle:@"Other" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(otherClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer,backItem, nil];
    
    //GCD执行耗时操作
    [self showProgressWithView:self.view animated:YES];
    [SendRequest requestHistoryWithOrigin:@"" dest:@"" deptdate:@"" returndate:@"" result:^(id result, NSError *error){
        [self hideProgress:self.view animated:YES];
        if ([result[@"result"] integerValue] == 1) {
            
            
        }
        
    }];
}
-(void)otherClick{
    ForecastTowVC *vc = [[ForecastTowVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)configTheChartView:(NSString *)chartType{
    self.chartView = [[AAChartView alloc]init];
    self.view.backgroundColor = [UIColor whiteColor];
    self.chartView.frame = CGRectMake(0, kScreenHeight - 400 -64, kScreenWidth, 400);
    self.chartView.contentHeight = self.view.frame.size.height-220;
    [self.view addSubview:self.chartView];
    self.chartModel= AAObject(AAChartModel)
    .chartTypeSet(chartType)
    .titleSet(@"历史价格走势")
    .subtitleSet(@"last 15 days")
    .categoriesSet(@[@"4/1",@"4/2",@"4/3",@"4/4",@"4/5",@"4/6",@"4/7",@"4/8",@"4/9",@"4/10",@"4/11",@"4/12",@"4/13",@"4/14",@"4/15"])
    .yAxisTitleSet(@"机票金额$")
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"价格走势")
                 .dataSet(@[@740,@1100,@740,@740,@740,@1380,@740,@740,@1000,@1000,@1000,@740,@1200,@740,@1380])                 ]
               )
    ;
    
    self.chartModel.yAxisGridLineWidth = @0.5;
//    self.chartModel.xAxisGridLineWidth = @0.5;
    self.chartModel.gradientColorEnable = YES;
    [self.chartView aa_drawChartWithChartModel:_chartModel];
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
