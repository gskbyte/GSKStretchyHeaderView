// GSKGeometry.h
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
