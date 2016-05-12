#ifndef GSKGeometry_h
#define GSKGeometry_h

#include <CoreGraphics/CGGeometry.h>

CG_INLINE CGFloat CGFloatInterpolate(CGFloat factor, CGFloat min, CGFloat max) {
    return min + (max - min) * factor;
}

CG_EXTERN CGFloat CGFloatTranslateRange(CGFloat value, CGFloat oldMin, CGFloat oldMax, CGFloat newMin, CGFloat newMax);
CG_EXTERN CGPoint CGPointInterpolate(CGFloat factor, CGPoint origin, CGPoint end);
CG_EXTERN CGSize CGSizeInterpolate(CGFloat factor, CGSize minSize, CGSize maxSize);
CG_EXTERN CGRect CGRectInterpolate(CGFloat factor, CGRect minRect, CGRect maxRect);

#endif
