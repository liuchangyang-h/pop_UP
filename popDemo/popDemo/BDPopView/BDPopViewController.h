

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger, BDPopViewIn)
{
    BDPopViewInCenter = 0,
    BDPopViewInTop = 1,
    BDPopViewInLeft = 2,
    BDPopViewInBottom = 3,
    BDPopViewInRight = 4,
    BDPopViewInCustom = 5
};
typedef NS_ENUM (NSInteger, BDPopViewStop)
{
    BDPopViewStopCenter = 0,
    BDPopViewStopTop = 1,
    BDPopViewStopLeft = 2,
    BDPopViewStopBottom = 3,
    BDPopViewStopRight = 4,
    BDPopViewStopCustom = 5
};
typedef NS_ENUM (NSInteger, BDPopViewOut)
{
    BDPopViewOutCenter = 0,
    BDPopViewOutTop = 1,
    BDPopViewOutLeft = 2,
    BDPopViewOutBottom = 3,
    BDPopViewOutRight = 4,
    BDPopViewOutCustom = 5
};

@interface BDPopViewController : UIViewController

/**
 单例

 @return 弹出实例
 */
+ (BDPopViewController *)sharePopViewController;

/**
 弹出自定义视图

 @param superView 视图父容器
 @param popView 自定义视图
 @param popViewIn 初始位置
 @param popViewStop 停留位置
 @param popViewOut 弹出位置
 @param popViewStopFrame 自定义停留位置
 @param bgViewShow 是否显示背景
 @param transparent 背景是否透明
 @param bgViewClickCancel 点击背景是否关闭弹框
 */
- (void)pushPopViewWithSuperView:(UIView *)superView PopView:(UIView *)popView BDPopViewIn:(BDPopViewIn)popViewIn BDPopViewStop:(BDPopViewStop)popViewStop BDPopViewOut:(BDPopViewOut)popViewOut BDPopViewStopFrame:(CGRect)popViewStopFrame bgViewShow:(BOOL)bgViewShow transparent:(BOOL)transparent BgViewClickCancel:(BOOL)bgViewClickCancel;

/**
 关闭弹框
 */
- (void)dissPopView;

/**
 设置偏移量

 @param top 往下偏移
 @param left 往右偏移
 */
- (void)setPopViewTop:(CGFloat)top Left:(CGFloat)left;
@end
