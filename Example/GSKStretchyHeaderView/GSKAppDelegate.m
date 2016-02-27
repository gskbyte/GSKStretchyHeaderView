//
//  GSKAppDelegate.m
//  GSKStretchyHeaderView
//
//  Created by Jose Alcalá Correa on 02/27/2016.
//  Copyright (c) 2016 Jose Alcalá Correa. All rights reserved.
//

#import "GSKAppDelegate.h"
#import "GSKViewController.h"

@implementation GSKAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] init];
    self.window.rootViewController = [[GSKViewController alloc] init];
    [self.window makeKeyAndVisible];
    return YES;
}


@end
