// UIScrollView+GSKStretchyHeaderView.m
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

#import "UIScrollView+GSKStretchyHeaderView.h"
#import "GSKStretchyHeaderView.h"
#import "GSKStretchyHeaderView+Protected.h"

@implementation UIScrollView (GSKStretchyHeaderView)

- (void)gsk_arrangeSubviewsWithStretchyHeaderView:(GSKStretchyHeaderView *)headerView {
    NSAssert(headerView.superview == self, @"The provided header view must be a subview of %@", self);
    
    // TODO do this more intelligently, avoiding to hide the scrollbars
    [self bringSubviewToFront:headerView];
}

- (void)gsk_layoutStretchyHeaderView:(GSKStretchyHeaderView *)headerView
                       contentOffset:(CGPoint)contentOffset
               previousContentOffset:(CGPoint)previousContentOffset {
    // First of all, move the header view to the top of the visible part of the scroll view,
    // update its width if needed
    CGRect headerFrame = headerView.frame;
    headerFrame.origin.y = contentOffset.y;
    if (CGRectGetWidth(headerFrame) != CGRectGetWidth(self.bounds)) {
        headerFrame.size.width = CGRectGetWidth(self.bounds);
    }
    
    // Adjust the height of the header view depending on the content offset
    if (contentOffset.y + headerView.maximumHeight < 0) { // bigger than default
        headerFrame.size.height = -contentOffset.y;
    } else if (-contentOffset.y <= headerView.minimumHeight) { // less than minimum height
        headerFrame.size.height = headerView.minimumHeight;
    } else { // between minimum and maximum
        headerFrame.size.height = -contentOffset.y;
    }
    
    // If the size of the header view changes, we will need to adjust its content view
    if (!CGSizeEqualToSize(headerView.frame.size, headerFrame.size)) {
        [headerView setNeedsLayoutContentView];
    }
    headerView.frame = headerFrame;
    
    [headerView layoutContentViewIfNeeded];
}

@end
