#import "GSKExampleData.h"

@interface GSKExampleData ()

@property (nonatomic) NSString *title;
@property (nonatomic) Class viewControllerClass;
@property (nonatomic) Class headerViewClass;

@end

@implementation GSKExampleData

+ (instancetype)dataWithTitle:(NSString *)title
              headerViewClass:(Class)headerViewClass {
    GSKExampleData *data = [[self alloc] init];
    data.title = title;
    data.headerViewClass = headerViewClass;
    return data;
}

+ (instancetype)dataWithtitle:(NSString *)title
          viewControllerClass:(Class)viewControllerClass {
    GSKExampleData *data = [[self alloc] init];
    data.title = title;
    data.viewControllerClass = viewControllerClass;
    return data;
}

@end
