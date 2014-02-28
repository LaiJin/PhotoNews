//
//  AppDelegate.m
//  PhotoNewsClient
//
//  Created by xyooyy on 14-2-10.
//  Copyright (c) 2014年 lunajin. All rights reserved.
//

#import "AppDelegate.h"
#import "OCMapperConfig.h"
#import "PhotoNewsShowViewController.h"
#import "PhotoNewsListViewController.h"
#import "WebViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [OCMapperConfig configure];
    [self configureDrawerController];
    self.window.rootViewController = self.drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)configureDrawerController
{
    UIViewController *rightViewController = [[PhotoNewsListViewController alloc] init];
    UIViewController *centerViewController = [[PhotoNewsShowViewController alloc] init];
    UIViewController *webViewController = [[WebViewController alloc] init];
    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController: centerViewController leftDrawerViewController:webViewController rightDrawerViewController:rightViewController];
    [self.drawerController setMaximumRightDrawerWidth:self.window.frame.size.width];
    [self.drawerController setMaximumLeftDrawerWidth:self.window.frame.size.width];
    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
