#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/GSKGeometry.h>
#import "HelperMacros.h"

@interface GSKGeometryTests : XCTestCase

@end

@implementation GSKGeometryTests

- (void)testFloatRangeTranslation {
    XCTAssertEqual(CGFloatTranslateRange(0, 0, 1, 0, 1), 0);
    XCTAssertEqual(CGFloatTranslateRange(0.5, 0, 1, 0, 1), 0.5);
    XCTAssertEqual(CGFloatTranslateRange(1, 0, 1, 0, 1), 1);
    XCTAssertEqual(CGFloatTranslateRange(200, 0, 1, 0, 1), 200);
    
    XCTAssertEqual(CGFloatTranslateRange(-10, -10, 10, 20, 10), 20);
    XCTAssertEqual(CGFloatTranslateRange(0, -10, 10, 20, 10), 15);
    XCTAssertEqual(CGFloatTranslateRange(10, -10, 10, 20, 10), 10);
    XCTAssertEqual(CGFloatTranslateRange(100, -10, 10, 20, 10), -35);

    XCTAssertEqual(CGFloatTranslateRange(-20, 100, 60, -20, 40), 160);
    XCTAssertEqual(CGFloatTranslateRange(100, 100, 60, -20, 40), -20);
    XCTAssertEqual(CGFloatTranslateRange(60, 100, 60, -20, 40), 40);
    XCTAssertEqual(CGFloatTranslateRange(-20, 100, 60, -20, 40), 160);
    XCTAssertEqual(CGFloatTranslateRange(1000, 100, 60, -20, 40), -1370);
}

- (void)testPointInterpolation {
    XCTAssertEqualPoint(CGPointInterpolate(0, CGPointMake(0, 0), CGPointMake(1, 1)), CGPointMake(0, 0));
    XCTAssertEqualPoint(CGPointInterpolate(0, CGPointMake(-4, 10), CGPointMake(2, -20)), CGPointMake(-4, 10));
    XCTAssertEqualPoint(CGPointInterpolate(0, CGPointMake(5, 10), CGPointMake(8, 30)), CGPointMake(5, 10));
    
    XCTAssertEqualPoint(CGPointInterpolate(1, CGPointMake(0, 0), CGPointMake(1, 1)), CGPointMake(1, 1));
    XCTAssertEqualPoint(CGPointInterpolate(1, CGPointMake(-4, 10), CGPointMake(2, -20)), CGPointMake(2, -20));
    
    XCTAssertEqualPoint(CGPointInterpolate(0.4, CGPointMake(0, 0), CGPointMake(1, 1)), CGPointMake(0.4, 0.4));
    XCTAssertEqualPoint(CGPointInterpolate(0.2, CGPointMake(-4, 10), CGPointMake(2, -20)), CGPointMake(-2.8, 4));
    XCTAssertEqualPoint(CGPointInterpolate(0.8, CGPointMake(5, 10), CGPointMake(8, 30)), CGPointMake(7.4, 26));
}

- (void)testSizeInterpolation {
    XCTAssertEqualSize(CGSizeInterpolate(0, CGSizeMake(0, 0), CGSizeMake(1, 1)), CGSizeMake(0, 0));
    XCTAssertEqualSize(CGSizeInterpolate(0, CGSizeMake(4, 10), CGSizeMake(2, 20)), CGSizeMake(4, 10));
    XCTAssertEqualSize(CGSizeInterpolate(0, CGSizeMake(5, 10), CGSizeMake(8, 30)), CGSizeMake(5, 10));
    
    XCTAssertEqualSize(CGSizeInterpolate(1, CGSizeMake(0, 0), CGSizeMake(1, 1)), CGSizeMake(1, 1));
    XCTAssertEqualSize(CGSizeInterpolate(1, CGSizeMake(4, 10), CGSizeMake(2, 20)), CGSizeMake(2, 20));
    
    XCTAssertEqualSize(CGSizeInterpolate(0.2, CGSizeMake(0, 0), CGSizeMake(1, 1)), CGSizeMake(0.2, 0.2));
    XCTAssertEqualSize(CGSizeInterpolate(0.6, CGSizeMake(4, 10), CGSizeMake(2, 20)), CGSizeMake(2.8, 16));
    XCTAssertEqualSize(CGSizeInterpolate(0.5, CGSizeMake(5, 10), CGSizeMake(8, 30)), CGSizeMake(6.5, 20));
}

- (void)testRectInterpolation {
    XCTAssertEqualFrame(CGRectInterpolate(0, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 1, 1)), CGRectMake(0, 0, 0, 0));
    XCTAssertEqualFrame(CGRectInterpolate(0, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60)), CGRectMake(-4, 10, 30, 40));
    XCTAssertEqualFrame(CGRectInterpolate(0, CGRectMake(5, 10, 50, 80), CGRectMake(8, 30, 50, 60)), CGRectMake(5, 10, 50, 80));

    XCTAssertEqualFrame(CGRectInterpolate(1, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 1, 1)), CGRectMake(1, 1, 1, 1));
    XCTAssertEqualFrame(CGRectInterpolate(1, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60)), CGRectMake(2, -20, 20, 60));

    XCTAssertEqualFrame(CGRectInterpolate(0.25, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 10, 10)), CGRectMake(0.25, 0.25, 2.5, 2.5));
    XCTAssertEqualFrame(CGRectInterpolate(0.5, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60)), CGRectMake(-1, -5, 25, 50));
    XCTAssertEqualFrame(CGRectInterpolate(0.8, CGRectMake(5, 10, 50, 80), CGRectMake(8, 30, 50, 60)), CGRectMake(7.4, 26, 50, 64));
}

@end
