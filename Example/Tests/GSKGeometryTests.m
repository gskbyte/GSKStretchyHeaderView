#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/GSKGeometry.h>
#import <Expecta/Expecta.h>

@interface GSKGeometryTests : XCTestCase

@end

@implementation GSKGeometryTests

- (void)testFloatRangeTranslation {
    expect(CGFloatTranslateRange(0, 0, 1, 0, 1)).to.equal(0);
    expect(CGFloatTranslateRange(0.5, 0, 1, 0, 1)).to.equal(0.5);
    expect(CGFloatTranslateRange(1, 0, 1, 0, 1)).to.equal(1);
    expect(CGFloatTranslateRange(200, 0, 1, 0, 1)).to.equal(200);
    
    expect(CGFloatTranslateRange(-10, -10, 10, 20, 10)).to.equal(20);
    expect(CGFloatTranslateRange(0, -10, 10, 20, 10)).to.equal(15);
    expect(CGFloatTranslateRange(10, -10, 10, 20, 10)).to.equal(10);
    expect(CGFloatTranslateRange(100, -10, 10, 20, 10)).to.equal(-35);

    expect(CGFloatTranslateRange(-20, 100, 60, -20, 40)).to.equal(160);
    expect(CGFloatTranslateRange(100, 100, 60, -20, 40)).to.equal(-20);
    expect(CGFloatTranslateRange(60, 100, 60, -20, 40)).to.equal(40);
    expect(CGFloatTranslateRange(-20, 100, 60, -20, 40)).to.equal(160);
    expect(CGFloatTranslateRange(1000, 100, 60, -20, 40)).to.equal(-1370);
}

- (void)testPointInterpolation {
    expect(CGPointInterpolate(0, CGPointMake(0, 0), CGPointMake(1, 1))).to.equal(CGPointMake(0, 0));
    expect(CGPointInterpolate(0, CGPointMake(-4, 10), CGPointMake(2, -20))).to.equal(CGPointMake(-4, 10));
    expect(CGPointInterpolate(0, CGPointMake(5, 10), CGPointMake(8, 30))).to.equal(CGPointMake(5, 10));
    
    expect(CGPointInterpolate(1, CGPointMake(0, 0), CGPointMake(1, 1))).to.equal(CGPointMake(1, 1));
    expect(CGPointInterpolate(1, CGPointMake(-4, 10), CGPointMake(2, -20))).to.equal(CGPointMake(2, -20));
    
    expect(CGPointInterpolate(0.4, CGPointMake(0, 0), CGPointMake(1, 1))).to.equal(CGPointMake(0.4, 0.4));
    expect(CGPointInterpolate(0.2, CGPointMake(-4, 10), CGPointMake(2, -20))).to.equal(CGPointMake(-2.8, 4));
    expect(CGPointInterpolate(0.8, CGPointMake(5, 10), CGPointMake(8, 30))).to.equal(CGPointMake(7.4, 26));
}

- (void)testSizeInterpolation {
    expect(CGSizeInterpolate(0, CGSizeMake(0, 0), CGSizeMake(1, 1))).to.equal(CGSizeMake(0, 0));
    expect(CGSizeInterpolate(0, CGSizeMake(4, 10), CGSizeMake(2, 20))).to.equal(CGSizeMake(4, 10));
    expect(CGSizeInterpolate(0, CGSizeMake(5, 10), CGSizeMake(8, 30))).to.equal(CGSizeMake(5, 10));
    
    expect(CGSizeInterpolate(1, CGSizeMake(0, 0), CGSizeMake(1, 1))).to.equal(CGSizeMake(1, 1));
    expect(CGSizeInterpolate(1, CGSizeMake(4, 10), CGSizeMake(2, 20))).to.equal(CGSizeMake(2, 20));
    
    expect(CGSizeInterpolate(0.2, CGSizeMake(0, 0), CGSizeMake(1, 1))).to.equal(CGSizeMake(0.2, 0.2));
    expect(CGSizeInterpolate(0.6, CGSizeMake(4, 10), CGSizeMake(2, 20))).to.equal(CGSizeMake(2.8, 16));
    expect(CGSizeInterpolate(0.5, CGSizeMake(5, 10), CGSizeMake(8, 30))).to.equal(CGSizeMake(6.5, 20));
}

- (void)testRectInterpolation {
    expect(CGRectInterpolate(0, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 1, 1))).to.equal(CGRectMake(0, 0, 0, 0));
    expect(CGRectInterpolate(0, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60))).to.equal(CGRectMake(-4, 10, 30, 40));
    expect(CGRectInterpolate(0, CGRectMake(5, 10, 50, 80), CGRectMake(8, 30, 50, 60))).to.equal(CGRectMake(5, 10, 50, 80));

    expect(CGRectInterpolate(1, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 1, 1))).to.equal(CGRectMake(1, 1, 1, 1));
    expect(CGRectInterpolate(1, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60))).to.equal(CGRectMake(2, -20, 20, 60));

    expect(CGRectInterpolate(0.25, CGRectMake(0, 0, 0, 0), CGRectMake(1, 1, 10, 10))).to.equal(CGRectMake(0.25, 0.25, 2.5, 2.5));
    expect(CGRectInterpolate(0.5, CGRectMake(-4, 10, 30, 40), CGRectMake(2, -20, 20, 60))).to.equal(CGRectMake(-1, -5, 25, 50));
    expect(CGRectInterpolate(0.8, CGRectMake(5, 10, 50, 80), CGRectMake(8, 30, 50, 60))).to.equal(CGRectMake(7.4, 26, 50, 64));
}

@end
