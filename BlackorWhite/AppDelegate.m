//
//  AppDelegate.m
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "LeftSortViewController.h"
#define SCREENHIGHT [[UIScreen mainScreen]bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen]bounds].size.width
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (MAINSIZE.height>480) {
        
        
        self.autoSizeScaleX = MAINSIZE.width/320;
        self.autoSizeScaleY = MAINSIZE.height/568;
        
        
    }else{
        
        self.autoSizeScaleX = 1.0;
        self.autoSizeScaleY = 1.0;
        
    }
    
    NSLog(@"wwwwwwwwwwwwwww%f",self.autoSizeScaleY);
    
    self.window  = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.mytabbar=[[MyTabBarController alloc]init];
    self.leftSoutVC = [[LeftSortViewController alloc]init];
    UINavigationController * leftNC = [[UINavigationController alloc]initWithRootViewController:self.leftSoutVC];
    
    self.leftSlideVC = [[LeftSlideViewController alloc]initWithLeftView:leftNC andMainView:self.mytabbar];
    self.leftSlideVC.title = @"左视图";
    
    self.window.rootViewController = self.leftSlideVC;
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackImage"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
//    [[UINavigationBar appearance] setBackgroundColor:[UIColor clearColor]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
