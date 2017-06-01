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
#import <Foundation/Foundation.h>
#import "BaseModel.h"
@interface OrderModel : BaseModel
@property(nonatomic,strong) NSString *coin;
@property(nonatomic,strong) NSString *count;
@property(nonatomic,strong) NSString *date;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *orderId;
@property(nonatomic,strong) NSString *pic_url;
@end
