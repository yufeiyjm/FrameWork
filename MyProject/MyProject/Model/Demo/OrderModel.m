/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 订单的model
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */
#import "OrderModel.h"

@implementation OrderModel
-(id)initWithDic:(NSDictionary *)data{
    self=[super init];
    if (self) {
        self.coin=[data objectForKey:@"coin"];
        self.count=[data objectForKey:@"count"];
        self.date=[data objectForKey:@"date"];
        self.name=[data objectForKey:@"name"];
        self.orderId=[data objectForKey:@"orderId"];
        self.pic_url=[data objectForKey:@"pic_url"];
    }
     return self;
}
@end
