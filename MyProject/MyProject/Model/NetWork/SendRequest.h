/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 请求接口封装 DAO
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import <Foundation/Foundation.h>
#import "OrderModel.h"
@interface SendRequest : NSObject
/*
 方法说明:
 获取机场列表
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestAirportListWithLat:(NSString *)lat lon:(NSString *)lon result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 查询当前出行最低票价。
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestLowestWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 Query for the lowest fare for the given trip in the past 2 weeks
 查询过去2周行程中的最低票价
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestHistoryWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 Lowest fare calendar in the future (Calendar)
 
 未来价格预测
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCalendarWithOrigin:(NSString *)origin dest:(NSString *)dest los:(NSString *)los result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 现在是否适合购买机票
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestRecommendWithOrigin:(NSString *)origin dest:(NSString *)dest deptdate:(NSString *)deptdate returndate:(NSString *)returndate result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 查询城市代码，根据机场名或者城市
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCityCodeWithTerm:(NSString *)term result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 Calendar Heatmap (New)
 
 价格预测
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestCalendarHeatWithOrigin:(NSString *)origin dest:(NSString *)dest result:(void (^)(NSDictionary *result, NSError *error))block;
/*
 方法说明:
 获取ip请求地址
 
 参数说明:
 空
 
 返回结果:
 NSDictionary *result；block的返回结果，这个可以自定义，可以是数组，字典，也可以是一个实例类，建议实例类，这样用起来比较方便，代码易读。
 */
+ (NSURLSessionDataTask *)requestUrlRouteWithLanguage:(NSString *)language result:(void (^)(NSDictionary *result, NSError *error))block;
@end
