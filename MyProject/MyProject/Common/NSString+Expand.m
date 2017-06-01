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

#import "NSString+Expand.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import "MF_Base64Additions.h"
#define gkey @"b0326c4f1e0e2c2970584b14a5a36d1886b4b115"
#define gIv  @"EBPPURLREQUEST3DESKEY000"
#define kSecrectKeyLength 24
@implementation NSString (Expand)
/*
 方法说明:
 添加正则验证
 
 参数说明:
 validateStr：正则字符
 返回结果:
 
 */
-(BOOL )isMatchedWithRegex:(NSString *)regexStr{
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexStr];
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}
/*
 方法说明:
 计算带汉字的字符串长度
 
 参数说明:
 text：需要计算的内容
 返回结果:
 int：带汉字的计算结果
 */
-(NSInteger)textLength
{
    NSInteger returnLength=self.length;
    NSInteger length=self.length;
    while (length>0) {
        unichar c=[self characterAtIndex:--length];
        NSString *str=[NSString stringWithFormat:@"%C",c];
        if ([str isMatchedWithRegex:@"[^x00-xff]"]) {
            returnLength=returnLength+1;
        }
    }
    return returnLength;
}
/*
 方法说明:
 去除所有空格，包括开头和字符串中间
 
 参数说明:
 无
 
 返回结果:
 NSString
 */
-(NSString *)trimAll
{
    NSString *result=[self stringByReplacingOccurrencesOfString:@" " withString:@""];
    result=[result stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    return result;
    
}
/*
 方法说明:
 截取字符串中从I到J的字符串
 
 参数说明:
 star:表示开始截取位置（从0开始）
 length:表示截取长度
 
 返回结果:
 NSString
 */

-(NSString *)subString :(int)star length:(int)length
{
    if (self.length<star+length) {
        return nil;
    }
    NSRange range;
    range.location=star;
    range.length=length;
    return [self substringWithRange:range];
}
/*
 方法说明:
 字符串中是否包含str2
 
 参数说明:
 str2:被包含的字符串
 
 返回结果:
 BOOL
 */
-(BOOL)isContainStr:(NSString *)str2
{
    NSRange range=[self rangeOfString:str2];
    if (range.length!=0) {
        return YES;
    }else {
        return NO;
    }
}
/*
 方法说明:
 字符串翻转，将字符串倒置
 参数说明:
 无
 
 返回结果:
 NSString
 */

-(NSString *)reverse
{
    NSUInteger len=[self length];
    NSMutableString *retStr=[NSMutableString stringWithCapacity:len];
    while (len>0) {
        unichar c=[self characterAtIndex:--len];
        NSString *str=[NSString stringWithFormat:@"%C",c];
        [retStr appendString:str];
    }
    return retStr;
}

/*
 方法说明:
 删除字符串中指定的字符
 参数说明:
 str：被删除的字符串
 
 返回结果:
 NSString
 */
-(NSString *)removeStr:(NSString *)str
{
    NSString *newStr=[self stringByReplacingOccurrencesOfString:str withString:@""];
    return newStr;
}
/*
 方法说明:
 将字符串中指定位置的字符删除
 参数说明:
 star：表示开始删除位置（从0开始）
 length：表示删除长度
 
 返回结果:
 NSString
 */
-(NSString *)removeAtIndexStr:(int)star length:(int)length
{
    if (self.length<star+length) {
        return nil;
    }
    NSRange range;
    range.location=star;
    range.length=length;
    NSString *result= [self stringByReplacingCharactersInRange:range withString:@""];
    return result;
}

/*
 方法说明:
 字符串中指定字符str的出现的次数
 参数说明:
 str：指定的字符串
 
 返回结果:
 int:指定字符串出现的次数
 */
-(NSInteger)countStr:(NSString *)str
{
    //以str为线分割字符串放入到数组中
    NSArray *arr = [self componentsSeparatedByString:str];
    NSInteger count = 0;
    if(arr && arr.count > 0)
        count = arr.count - 1;
    return count;
}

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

-(NSString *)replaceStr:(int)star length:(int)length str:(NSString *)str
{
    if (self.length<star+length) {
        return nil;
    }
    NSRange range;
    range.location=star;
    range.length=length;
    NSString *result= [self stringByReplacingCharactersInRange:range withString:str];
    return result;
}


/*
 方法说明:
 判断字符串是否为空
 参数说明:
 
 返回结果:
 BOOL
 */
-(BOOL)isNotEmpty
{
    NSString *result=self;
    BOOL flag=NO;
    if (![result isEqualToString:@""]) {
        flag=YES;
    }
    return flag;
}

/*
 方法说明:
 将NSNULL对象转成“-”，
 返回NSString对象
 参数说明:
 
 返回结果:
 处理后的结果
 */
+ (NSString *)stringExceptNull:(id)obj{
    
    if ([obj isKindOfClass:[NSNull class]]) {
        return @"-";
    }
    return [NSString stringWithFormat:@"%@",obj];
    
}
/*
 方法描述:
 获取label大小
 
 参数说明:
 font:字体
 width:宽度
 idx:数据的位置
 subIdx:提示在数据中的位置
 返回结果:
 CGSize:大小
 
 */
- (float)stringSizeWithFont:(UIFont*)font
                   forWidth:(CGFloat)width{
    
    CGSize size = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, 2000) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size.height;
}
/*
 方法说明:
 对字符串进行MD5加密
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 */
- (NSString *) stringFromMD5{
    
    if(self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
    //需要定算法
//    const char *cStr = [self UTF8String];
//    unsigned char result[16];
//    CC_MD5( cStr, strlen(cStr), result );
//    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
//            result[0], result[1], result[2], result[3],
//            result[4], result[5], result[6], result[7],
//            result[8], result[9], result[10], result[11],
//            result[12], result[13], result[14], result[15]
//            ];
}

- (NSString *)encodeToPercentEscapeString: (NSString *) input
{
    // Encode all the reserved characters, per RFC 3986
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    NSString *outputStr = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)input,
                                            NULL,
                                            (CFStringRef)@"|!*+,'();:@ &amp; &=1+$,?%\"#[]\r\n",
                                            kCFStringEncodingUTF8));
    return outputStr;
}
/*
 方法描述:
 3DES加密算法
 
 参数说明:
 KEY：key值
 
 返回结果:
 加密后字符
 
 */
- (NSString*)encryptWithKey:(NSString*)key{
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(keyData.bytes, keyData.length, digest);
    
    uint8_t keyByte[key.length];
    for (int i=0; i<key.length; i++) {
        keyByte[i] = [key characterAtIndex:i];
    }
    //    for (int i=0; i<8; i++) {
    //        keyByte[16+i] = digest[i];
    //    }
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    size_t plainTextBufferSize = [data length];
    const void *vplainText = (const void *)[data bytes];
    
//    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) keyByte;
    const void *vinitVec = (const void *) [gIv UTF8String];
    
//    ccStatus =
    CCCrypt(kCCEncrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
    NSString *result = [MF_Base64Codec base64StringFromData:myData];
    return result;
}
/*
 方法描述:
 3DES解密
 
 参数说明:
 key：key
 
 返回结果:
 解密后字符
 
 */
- (NSString*)decryptWithKey:(NSString*)key{
    
    const char *cstr = [key cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:key.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    
    //    uint8_t keyByte[kSecrectKeyLength];
    //    for (int i=0; i<16; i++) {
    //        keyByte[i] = digest[i];
    //    }
    //    for (int i=0; i<8; i++) {
    //        keyByte[16+i] = digest[i];
    //    }
    uint8_t keyByte[key.length];
    for (int i=0; i<key.length; i++) {
        keyByte[i] = [key characterAtIndex:i];
    }
    NSData *encryptData = [NSData dataWithBase64String:self];
    size_t plainTextBufferSize = [encryptData length];
    const void *vplainText = [encryptData bytes];
    
//    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSize3DES) & ~(kCCBlockSize3DES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    const void *vkey = (const void *) keyByte;
    const void *vinitVec = (const void *) [gIv UTF8String];
    
//    ccStatus =
    CCCrypt(kCCDecrypt,
                       kCCAlgorithm3DES,
                       kCCOptionPKCS7Padding,
                       vkey,
                       kCCKeySize3DES,
                       vinitVec,
                       vplainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    
    NSString *result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr
                                                                      length:(NSUInteger)movedBytes] encoding:NSUTF8StringEncoding];
    return result;
}

//判断是不是数字
- (BOOL)CheckFloatValueInput:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
+ (BOOL)CheckIntValueInput:(NSString *)string {
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

@end
