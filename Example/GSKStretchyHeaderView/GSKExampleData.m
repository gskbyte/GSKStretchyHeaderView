#import "GSKExampleData.h"

@interface GSKExampleData ()

@property (nonatomic) NSString *title;
@property (nullable, nonatomic) Class viewControllerClass;
@property (nullable, nonatomic) Class headerViewClass;
@property (nullable, nonatomic) NSString *nibName;

@end

@implementation GSKExampleData

+ (instancetype)dataWithTitle:(NSString *)title
              headerViewClass:(Class)headerViewClass {
    GSKExampleData *data = [[self alloc] init];
    data.title = title;
    data.headerViewClass = headerViewClass;
    return data;
}

+ (instancetype)dataWithTitle:(NSString *)title
            headerViewNibName:(NSString *)nibName {
    GSKExampleData *data = [[self alloc] init];
    data.title = title;
    data.nibName = nibName;
    return data;
}

+ (instancetype)dataWithTitle:(NSString *)title
          viewControllerClass:(Class)viewControllerClass {
    GSKExampleData *data = [[self alloc] init];
    data.title = title;
    data.viewControllerClass = viewControllerClass;
    return data;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _headerViewInitialHeight = 240;
    }
    return self;
}

@end
