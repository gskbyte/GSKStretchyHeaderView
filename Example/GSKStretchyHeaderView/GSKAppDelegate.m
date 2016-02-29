#import "GSKAppDelegate.h"
#import "GSKExampleListViewController.h"

@implementation GSKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    GSKExampleListViewController *exampleListController = [[GSKExampleListViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:exampleListController];
    self.window.rootViewController = navController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
