#import <Foundation/Foundation.h>

@interface GSKExampleData : NSObject

@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) Class viewControllerClass;
@property (nonatomic, readonly) Class headerViewClass;

+ (instancetype)dataWithTitle:(NSString *)title
              headerViewClass:(Class)headerViewClass;
+ (instancetype)dataWithtitle:(NSString *)title
          viewControllerClass:(Class)viewControllerClass;

@end
