

#import "BDPopBgView.h"
#import "BDExtend.h"

@implementation BDPopBgView

- (void)drawRect:(CGRect)rect
{
    if (self.isColor)
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        size_t locationsCount = 2;
        CGFloat locations[2] = {0.0f, 1.0f};
        CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.75f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
        CGColorSpaceRelease(colorSpace);
        
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
        CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
    else
    {
        CGContextRef context = UIGraphicsGetCurrentContext();
        size_t locationsCount = 2;
        CGFloat locations[2] = {0.0f, 1.0f};
        CGFloat colors[8] = {0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f,0.0f};
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
        CGColorSpaceRelease(colorSpace);
        
        CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        float radius = MIN(self.bounds.size.width , self.bounds.size.height) ;
        CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
        CGGradientRelease(gradient);
    }
}

- (void)initWith:(BOOL)isColor
{
    self.isColor = isColor;
}

@end
