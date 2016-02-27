#import "GSKAppDelegate.h"
#import "GSKExampleListController.h"

@implementation GSKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    GSKExampleListController *exampleListController = [[GSKExampleListController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:exampleListController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
