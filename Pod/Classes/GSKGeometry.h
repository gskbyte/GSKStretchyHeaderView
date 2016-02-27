#ifndef GSKGeometry_h
#define GSKGeometry_h

#include <CoreGraphics/CGGeometry.h>

CG_INLINE CGFloat CGFloatInterpolate(CGFloat factor, CGFloat min, CGFloat max) {
    return min + (max - min) * factor;
}

CG_INLINE CGFloat CGFloatTranslateRange(CGFloat value, CGFloat oldMin, CGFloat oldMax, CGFloat newMin, CGFloat newMax) {
    CGFloat oldRange = oldMax - oldMin;
    CGFloat newRange = newMax - newMin;
    return (value - oldMin) * newRange / oldRange + newMin;
}

CG_INLINE CGPoint CGPointInterpolate(CGFloat factor, CGPoint origin, CGPoint end) {
    return CGPointMake(CGFloatInterpolate(factor, origin.x, end.x),
                       CGFloatInterpolate(factor, origin.y, end.y));
}

CG_INLINE CGSize CGSizeInterpolate(CGFloat factor, CGSize minSize, CGSize maxSize) {
    return CGSizeMake(CGFloatInterpolate(factor, minSize.width, maxSize.width),
                      CGFloatInterpolate(factor, minSize.height, maxSize.height));
}

CG_INLINE CGRect CGRectInterpolate(CGFloat factor, CGRect minRect, CGRect maxRect) {
    CGRect rect;
    rect.origin = CGPointInterpolate(factor, minRect.origin, maxRect.origin);
    rect.size = CGSizeInterpolate(factor, minRect.size, maxRect.size);
    return rect;
    
}


#endif
