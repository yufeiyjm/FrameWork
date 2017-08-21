/*
 ***************************************************************************
 * 建立日期	： 2016-07-26
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： emoji表情的实现
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */
#import "EmojiVC.h"
#import <AGEmojiKeyboard/AGEmojiKeyboardView.h>
#import "NSString+Expand.h"
@interface EmojiVC ()<AGEmojiKeyboardViewDelegate, AGEmojiKeyboardViewDataSource,UITextViewDelegate>
{
    UITextField *_keyboardTxt;//隐藏的TextField，用来掉起键盘使用
}
@property (nonatomic) IBOutlet UITextView *textView;//输入框

@end

@implementation EmojiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"自定义表情键盘";
    AGEmojiKeyboardView *emojiKeyboardView = [[AGEmojiKeyboardView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216) dataSource:self];
    emojiKeyboardView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    emojiKeyboardView.delegate = self;
    emojiKeyboardView.backgroundColor = kWhiteColor;
    emojiKeyboardView.pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    emojiKeyboardView.pageControl.pageIndicatorTintColor = [UIColor grayColor];
    emojiKeyboardView.segmentsBar.tintColor = kRedColor;
    /****创建一个隐藏的输入文本，用来掉起键盘****/
    _keyboardTxt = [[UITextField alloc]init];
    _keyboardTxt.inputView = emojiKeyboardView;
    [self.view addSubview:_keyboardTxt];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
/*
 方法描述:
 调起键盘
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (IBAction)emojiClick:(id)sender {
    [_keyboardTxt becomeFirstResponder];
    [self.textView scrollRangeToVisible:NSMakeRange(0, self.textView.text.length)];
}
/*
 方法描述:
 emoji表情选择后方法
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (void)emojiKeyBoardView:(AGEmojiKeyboardView *)emojiKeyBoardView didUseEmoji:(NSString *)emoji {

    self.textView.text = [self.textView.text stringByAppendingString:emoji];
    /****滚动到最后****/
    [self.textView scrollRangeToVisible:NSMakeRange(0, self.textView.text.length)];
}
/*
 方法描述:
 emoji键盘上返回按钮的点击，该方法暂时放到外面，有需要在封装到工程中。
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (void)emojiKeyBoardViewDidPressBackSpace:(AGEmojiKeyboardView *)emojiKeyBoardView {
    NSString * newStr = @"";
    NSString *text = self.textView.text;
    if (text.length>0) {
        
        if (text.length >3) {
            if ([self stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                newStr=[text substringToIndex:text.length-1];
            }else if ([self stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                newStr=[text substringToIndex:text.length-2];
            }else if ([self stringContainsEmoji:[text substringFromIndex:text.length-3]]) {
                newStr=[text substringToIndex:text.length-3];
            }else  if ([self stringContainsEmoji:[text substringFromIndex:text.length-4]]) {
                newStr=[text substringToIndex:text.length-4];
            }else{
                newStr=[text substringToIndex:text.length-1];
            }
            
        }else if (text.length >2) {
            
            if ([self stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                newStr=[text substringToIndex:text.length-1];
            }else if ([self stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                newStr=[text substringToIndex:text.length-2];
            }else if ([self stringContainsEmoji:[text substringFromIndex:text.length-3]]) {
                newStr=[text substringToIndex:text.length-3];
            }else{
                newStr=[text substringToIndex:text.length-1];
            }
        }else   if (text.length >1) {
            if ([self stringContainsEmoji:[text substringFromIndex:text.length-1]]) {
                newStr=[text substringToIndex:text.length-1];
            }else if ([self stringContainsEmoji:[text substringFromIndex:text.length-2]]) {
                newStr=[text substringToIndex:text.length-2];
            }else{
                newStr=[text substringToIndex:text.length-1];
            }
            
        }else {
        }
        self.textView.text=newStr;
    }
}
/*
 方法描述:
 判断是否是emoji表情，方便我们删除
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
    
}

/*
 方法描述:
 选中状态下emoji键盘类型的图片
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {

    return IMAGE(@"backImage");
}
/*
 方法描述:
 正常情况下emoji表情的类型图片
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (UIImage *)emojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView imageForNonSelectedCategory:(AGEmojiKeyboardViewCategoryImage)category {
    if (category == AGEmojiKeyboardViewCategoryImageRecent) {
       return IMAGE(@"noData");
    }else if (category == AGEmojiKeyboardViewCategoryImageFace) {
        return IMAGE(@"专题（点击）");
    }
    else{
        return IMAGE(@"backImage");
    }
    
}
/*
 方法描述:
 返回按钮的图片
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (UIImage *)backSpaceButtonImageForEmojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView {

    return IMAGE(@"noData");
}
/*
 方法描述:
 默认选中emoji表情的种类。
 
 参数说明:
 <#参数说明#>
 
 返回结果:
 <#返回结果#>
 
 */
- (AGEmojiKeyboardViewCategoryImage)defaultCategoryForEmojiKeyboardView:(AGEmojiKeyboardView *)emojiKeyboardView{
    return AGEmojiKeyboardViewCategoryImageFace;
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
