/*
 ***************************************************************************
 * 建立日期	： 2014-04-15
 * 版权声明	： 本代码版权归圣笛科技所有，禁止任何未授权的传播和使用
 * 作者		： yanjiaming@sainti.com
 * 模块		：
 * 描述		： BaseViewController
 * -------------------------------------------------------------------------
 * 修改历史
 * 序号			日期					修改人				修改原因
 * <#序号#>        <#日期#>                <#修改人#>              <#修改原因#>
 *
 ***************************************************************************
 */

#import <UIKit/UIKit.h>
#import "Common.h"
#import "MBProgressHUD.h"
@interface BaseViewController : UIViewController
{
@private
    NSTimer *_hideProgressTimer;
}

@property (retain, nonatomic) UIView * topToolBarView;

@property (nonatomic, retain) UIButton *btnBack;
@property (nonatomic, retain) UILabel *lblTitle;
/*
 方法说明:
 添加并显示等待条
 
 参数说明:
 UIView* view        添加等待条的View对象
 BOOL    isAnimated  是否出现动画
 
 返回结果:
 void
 */
- (void)showProgressWithView:(UIView*)view animated:(BOOL)isAnimated;

/*
 方法说明:
 隐藏并释放等待条
 
 参数说明:
 UIView* view        隐藏并释放等待条的View对象
 BOOL    isAnimated  是否出现动画
 
 返回结果:
 void
 */
- (void)hideProgress:(UIView*)view animated:(BOOL)isAnimated;
- (void)btnBackClicked:(id)sender;

@end
