#import "GSKGradientView.h"

@implementation GSKGradientView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *colors = @[(id)[UIColor redColor].CGColor,
                            (id)[UIColor orangeColor].CGColor,
                            (id)[UIColor yellowColor].CGColor];

        NSArray *locations = @[@0.0, @0.25, @1.0];

        [self.gradientLayer setColors:colors];
        [self.gradientLayer setLocations:locations];
        [self.gradientLayer setStartPoint:CGPointMake(0, 0)];
        [self.gradientLayer setEndPoint:CGPointMake(0, 1)];
    }
    return self;
}

+ (Class)layerClass {
    return [CAGradientLayer class];
}

- (CAGradientLayer *)gradientLayer {
    return (CAGradientLayer *)self.layer;
}

@end

