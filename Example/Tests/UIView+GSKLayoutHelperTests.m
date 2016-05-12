#import <XCTest/XCTest.h>

#import <GSKStretchyHeaderView/UIView+GSKLayoutHelper.h>
#import <Expecta/Expecta.h>

@interface UIView_GSKLayoutHelperTests : XCTestCase

@end

@implementation UIView_GSKLayoutHelperTests

- (void)testReadProperties {
    UIView *view = [self view];
    
    expect(view.origin).to.equal(CGPointMake(10, 20));
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(40);
    expect(view.bottom).to.equal(60);
    
    expect(view.centerX).to.equal(25);
    expect(view.centerY).to.equal(40);

    expect(view.size).to.equal(CGSizeMake(30, 40));

    expect(view.width).to.equal(30);
    expect(view.height).to.equal(40);
}

- (void)testSetEdges {
    UIView *view = [self view];
    
    view.origin = CGPointMake(20, 30);
    
    expect(view.left).to.equal(20);
    expect(view.top).to.equal(30);
    expect(view.right).to.equal(50);
    expect(view.bottom).to.equal(70);
    expect(view.size).to.equal(CGSizeMake(30, 40));

    view = [self view];
    view.left = 100;
    
    expect(view.left).to.equal(100);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(130);
    expect(view.bottom).to.equal(60);
    expect(view.size).to.equal(CGSizeMake(30, 40));
    
    view = [self view];
    view.top = 0;
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(0);
    expect(view.right).to.equal(40);
    expect(view.bottom).to.equal(40);
    expect(view.size).to.equal(CGSizeMake(30, 40));

    view = [self view];
    view.right = 50;
    
    expect(view.left).to.equal(20);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(50);
    expect(view.bottom).to.equal(60);
    expect(view.size).to.equal(CGSizeMake(30, 40));

    view = [self view];
    view.bottom = 70;
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(30);
    expect(view.right).to.equal(40);
    expect(view.bottom).to.equal(70);
    expect(view.size).to.equal(CGSizeMake(30, 40));
}

- (void)testSetCenters {
    UIView *view = [self view];
    
    view.centerX = 80;
    
    expect(view.left).to.equal(65);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(95);
    expect(view.bottom).to.equal(60);
    expect(view.size).to.equal(CGSizeMake(30, 40));
    
    view = [self view];
    view.centerY = 90;
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(70);
    expect(view.right).to.equal(40);
    expect(view.bottom).to.equal(110);
    expect(view.size).to.equal(CGSizeMake(30, 40));
}

- (void)testSetSize {
    UIView *view = [self view];
    
    view.size = CGSizeMake(100, 120);
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(110);
    expect(view.bottom).to.equal(140);
    expect(view.width).to.equal(100);
    expect(view.height).to.equal(120);
    
    view = [self view];
    view.width = 70;
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(80);
    expect(view.bottom).to.equal(60);
    expect(view.size).to.equal(CGSizeMake(70, 40));

    view = [self view];
    view.width = 10;
    
    expect(view.left).to.equal(10);
    expect(view.top).to.equal(20);
    expect(view.right).to.equal(20);
    expect(view.bottom).to.equal(60);
    expect(view.size).to.equal(CGSizeMake(10, 40));
}

#pragma mark - Helper methods

- (UIView *)view {
    return [[UIView alloc] initWithFrame:CGRectMake(10, 20, 30, 40)];
}

@end
