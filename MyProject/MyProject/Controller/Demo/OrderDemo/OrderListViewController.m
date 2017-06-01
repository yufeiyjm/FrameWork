/*
 ***************************************************************************
 * 建立日期	： 2016-07-26
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 菜单的子类VC
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import "OrderListViewController.h"
#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);
@interface OrderListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic)  NSArray *arrData;//图片名数组
@end

@implementation OrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     NSLog(@"加载了第%zd",self.selectIndex);
    if (self.selectIndex == 0) {
        self.arrData = @[@"全部",@"全部",@"全部",@"全部",@"全部",@"全部"];
    }else if (self.selectIndex == 1) {
        self.arrData = @[@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成",@"已完成"];
    }else if (self.selectIndex == 2) {
        self.arrData = @[@"已评价",@"已评价",@"已评价",@"已评价",@"已评价",@"已评价",@"已评价",@"已评价"];
    }else if (self.selectIndex == 3) {
       self.arrData = @[@"退货",@"退货",@"退货",@"退货",@"退货",@"退货",@"退货",@"退货",@"退货",@"退货"];
    }
}
/*
 方法描述:
 代理方法必须实现
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (void)setUpWhenViewWillAppearForTitle:(NSString *)title forIndex:(NSInteger)index firstTimeAppear:(BOOL)isFirstTime {
    if (isFirstTime) {
         NSLog(@"加载'%@",title);
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    }
    
    cell.textLabel.text = self.arrData[indexPath.row];
    
    return cell;
}
- (void)dealloc
{
    NSLog(@"%@-----test---销毁", self.description);
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
