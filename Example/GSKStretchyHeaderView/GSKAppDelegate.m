#import "GSKAppDelegate.h"
#import "GSKExampleListController.h"

@implementation GSKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    GSKExampleListController *exampleListController = [[GSKExampleListController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:exampleListController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
