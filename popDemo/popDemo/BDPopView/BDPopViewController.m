

#import "BDPopViewController.h"

#import "BDPopBgView.h"
#import "BDExtend.h"

#define kPopViewDuration 0.35

@interface BDPopViewController ()

@property (nonatomic, strong) UIView *superView;

@property (nonatomic, strong) BDPopBgView *bgView;

@property (nonatomic, strong) UIView *popView;

@property (nonatomic, assign) BDPopViewIn popViewIn;

@property (nonatomic, assign) BDPopViewStop popViewStop;

@property (nonatomic, assign) BDPopViewOut popViewOut;

@property (nonatomic, assign) CGRect popViewStopFrame;

@property (nonatomic, assign) BOOL bgViewShow;

@property (nonatomic, assign) BOOL bgViewClickCancel;

@property (nonatomic, assign) BOOL bgTransparent;

@end

@implementation BDPopViewController

+ (BDPopViewController *)sharePopViewController
{
    static BDPopViewController *popViewController;
    if (popViewController == nil)
    {
        popViewController = [[BDPopViewController alloc] init];
    }
    return popViewController;
}

- (void)pushPopViewWithSuperView:(UIView *)superView PopView:(UIView *)popView BDPopViewIn:(BDPopViewIn)popViewIn BDPopViewStop:(BDPopViewStop)popViewStop BDPopViewOut:(BDPopViewOut)popViewOut BDPopViewStopFrame:(CGRect)popViewStopFrame bgViewShow:(BOOL)bgViewShow transparent:(BOOL)transparent BgViewClickCancel:(BOOL)bgViewClickCancel
{
    if ([self.popView bd_isValue])
    {
        [self dissPopView];
        return;
    }
    
    self.superView = superView;
    self.popView = popView;
    self.popViewIn = popViewIn;
    self.popViewStop = popViewStop;
    self.popViewOut = popViewOut;
    self.popViewStopFrame = popViewStopFrame;
    self.bgViewShow = bgViewShow;
    self.bgTransparent = transparent;
    self.bgViewClickCancel = bgViewClickCancel;
    
    if (self.bgViewShow)
    {
        self.bgView = [[BDPopBgView alloc] init];
        [self.bgView initWith:self.bgTransparent];
        [self.bgView setFrame:self.superView.bounds];
        [self.bgView setBackgroundColor:[UIColor clearColor]];
        [self.superView addSubview:self.bgView];
        if (self.bgViewClickCancel)
        {
            [self.bgView addTarget:self action:@selector(clickCancel) forControlEvents:UIControlEventTouchUpInside];
        }
        [self.bgView addSubview:self.popView];
    }
    else
    {
        [self.superView addSubview:self.popView];
    }
    CGRect startRect;
    switch (self.popViewIn)
    {
        case BDPopViewInCenter:
        {
            startRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewInTop:
        {
            startRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, - self.popView.bounds.size.height, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewInLeft:
        {
            startRect = CGRectMake(- self.popView.bounds.size.width, (self.bgView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewInBottom:
        {
            startRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, self.superView.bounds.size.height, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewInRight:
        {
            startRect = CGRectMake(self.superView.bounds.size.width, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewInCustom:
        {
            startRect = self.popViewStopFrame;
        }
            break;
        default:
            break;
    }
    
    CGRect endRect;
    switch (self.popViewStop)
    {
        case BDPopViewStopCenter:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewStopTop:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, 0, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewStopLeft:
        {
            endRect = CGRectMake(0, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewStopBottom:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, self.superView.bounds.size.height - self.popView.bounds.size.height, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewStopRight:
        {
            endRect = CGRectMake(self.superView.bounds.size.width - self.popView.bounds.size.width, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewStopCustom:
        {
            endRect = self.popViewStopFrame;
        }
            break;
        default:
            break;
    }
    [self.bgView setAlpha:0.0f];
    [self.popView setFrame:startRect];
    [UIView animateWithDuration:kPopViewDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.bgView setAlpha:1.0f];
        [self.popView setFrame:endRect];
    } completion:^(BOOL finished) {
    }];
}

- (void)dissPopView
{
    CGRect endRect;
    switch (self.popViewOut)
    {
        case BDPopViewOutCenter:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewOutTop:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, - self.popView.bounds.size.height, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewOutLeft:
        {
            endRect = CGRectMake(- self.popView.bounds.size.width, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewOutBottom:
        {
            endRect = CGRectMake((self.superView.bounds.size.width - self.popView.bounds.size.width)/2, self.superView.bounds.size.height, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewOutRight:
        {
            endRect = CGRectMake(self.superView.bounds.size.width, (self.superView.bounds.size.height - self.popView.bounds.size.height)/2, self.popView.bounds.size.width, self.popView.bounds.size.height);
        }
            break;
        case BDPopViewOutCustom:
        {
            endRect = self.popViewStopFrame;
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:kPopViewDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.bgView setAlpha:0.0f];
        [self.popView setFrame:endRect];
    } completion:^(BOOL finished) {
        [self.popView removeFromSuperview];
        self.popView = nil;
        [self.bgView removeFromSuperview];
        self.bgView = nil;
    }];
}

- (void)clickCancel
{
    [self dissPopView];
}

- (void)setPopViewTop:(CGFloat)top Left:(CGFloat)left;
{
    CGRect rect = self.popView.frame;
    rect.origin.x += left;
    rect.origin.y += top;
    [self.popView setFrame:rect];
}

@end
