//
//  HelperMacros.h
//  GSKStretchyHeaderView
//
//  Created by Jose Alcalá-Correa on 16/7/16.
//  Copyright © 2016 Jose Alcalá-Correa. All rights reserved.
//

#ifndef HelperMacros_h
#define HelperMacros_h

#define XCTAssertEqualFrame(frame0, frame1) XCTAssertTrue(CGRectEqualToRect(frame0, frame1))
#define XCTAssertEqualPoint(p0, p1) XCTAssertTrue(CGPointEqualToPoint(p0, p1))
#define XCTAssertEqualSize(s0, s1) XCTAssertTrue(CGSizeEqualToSize(s0, s1))
#define XCTAssertInRange(value, min, max) XCTAssertGreaterThan(value, min); XCTAssertLessThan(value, max)
#define XCTAssertInClosedRange(value, min, max) XCTAssertGreaterThanOrEqual(value, min); XCTAssertLessThanOrEqual(value, max)

#endif /* HelperMacros_h */
