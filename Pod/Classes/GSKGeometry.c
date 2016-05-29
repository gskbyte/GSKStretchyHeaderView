// GSKGeometry.c
// Copyright (c) 2016 Jose Alcalá Correa ( http://github.com/gskbyte )
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#include "GSKGeometry.h"

CGFloat CGFloatTranslateRange(CGFloat value, CGFloat oldMin, CGFloat oldMax, CGFloat newMin, CGFloat newMax) {
    CGFloat oldRange = oldMax - oldMin;
    CGFloat newRange = newMax - newMin;
    return (value - oldMin) * newRange / oldRange + newMin;
}

CGPoint CGPointInterpolate(CGFloat factor, CGPoint origin, CGPoint end) {
    return CGPointMake(CGFloatInterpolate(factor, origin.x, end.x),
                       CGFloatInterpolate(factor, origin.y, end.y));
}

CGSize CGSizeInterpolate(CGFloat factor, CGSize minSize, CGSize maxSize) {
    return CGSizeMake(CGFloatInterpolate(factor, minSize.width, maxSize.width),
                      CGFloatInterpolate(factor, minSize.height, maxSize.height));
}

CGRect CGRectInterpolate(CGFloat factor, CGRect minRect, CGRect maxRect) {
    CGRect rect;
    rect.origin = CGPointInterpolate(factor, minRect.origin, maxRect.origin);
    rect.size = CGSizeInterpolate(factor, minRect.size, maxRect.size);
    return rect;
    
}
