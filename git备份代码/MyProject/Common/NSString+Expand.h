/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： 字符串处理扩展类
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import <Foundation/Foundation.h>

@interface NSString (Expand)
/*
 方法说明:
 添加正则验证
 
 参数说明:
 validateStr：正则字符
 返回结果:
 
 */
-(BOOL )isMatchedWithRegex:(NSString *)regexStr;
/*
 方法说明:
 计算带汉字的字符串长度
 
 参数说明:
 无
 返回结果:
 int：带汉字的计算结果
 */
-(NSInteger)textLength;
/*
 方法说明:
 去除所有空格，包括开头和字符串中间
 
 参数说明:
 无
 
 返回结果:
 NSString
 */
-(NSString *)trimAll;

/*
 方法说明:
 截取字符串中从I到J的字符串
 
 参数说明:
 star:表示开始截取位置（从0开始）
 length:表示截取长度
 
 返回结果:
 NSString
 */
-(NSString *)subString :(int)star length:(int)length;
/*
 方法说明:
 字符串中是否包含str2
 
 参数说明:
 str2:被包含的字符串
 
 返回结果:
 BOOL
 */

-(BOOL)isContainStr:(NSString *)str2;
/*
 方法说明:
 字符串翻转，将字符串倒置
 参数说明:
 无
 
 返回结果:
 NSString
 */
-(NSString *)reverse;
/*
 方法说明:
 删除字符串中指定的字符
 参数说明:
 str：被删除的字符串
 
 返回结果:
 NSString
 */
-(NSString *)removeStr:(NSString *)str;
/*
 方法说明:
 将字符串中指定位置的字符删除
 参数说明:
 star：表示开始删除位置（从0开始）
 length：表示删除长度
 
 返回结果:
 NSString
 */
-(NSString *)removeAtIndexStr:(int)star length:(int)length;
/*
 方法说明:
 字符串中指定字符str的出现的次数
 参数说明:
 str：指定的字符串
 
 返回结果:
 int:指定字符串出现的次数
 */
-(NSInteger)countStr:(NSString *)str;
/*
 方法说明:
 替换字符串中指定的字符
 参数说明:
 star：表示开始替换位置（从0开始）
 length：表示替换长度
 str:要替换成的字符串的str
 返回结果:
 NSString
 */
-(NSString *)replaceStr:(int)star length:(int)length str:(NSString *)str;
/*
 方法说明:
 判断字符串是否为空
 参数说明:
 
 返回结果:
 BOOL
 */
-(BOOL)isNotEmpty;
/*
 方法说明:
 将NSNULL对象转成“-”，
 返回NSString对象
 参数说明:
 
 返回结果:
 处理后的结果
 */
+ (NSString *)stringExceptNull:(id)obj;

/*
 方法描述:
 获取label大小
 
 参数说明:
 font:字体
 width:宽度
 返回结果:
 CGSize:大小
 
 */
- (float)stringSizeWithFont:(UIFont*)font
                   forWidth:(CGFloat)width;

- (NSString *) stringFromMD5;
- (NSString *)encodeToPercentEscapeString: (NSString *) input;
/*
 方法描述:
 3DES加密算法
 
 参数说明:
 KEY：key值
 
 返回结果:
 加密后字符
 
 */
- (NSString*)encryptWithKey:(NSString*)key;
/*
 方法描述:
 3DES解密
 
 参数说明:
 key：key
 
 返回结果:
 解密后字符
 
 */
- (NSString*)decryptWithKey:(NSString*)key;
//判断是否float类型
- (BOOL)CheckFloatValueInput:(NSString *)string ;
//判断是否整数
+ (BOOL)CheckIntValueInput:(NSString *)string;

@end
