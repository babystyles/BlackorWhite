//
//  AppDelegate.h
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftSlideViewController.h"
#import "RootNavigationController.h"
#import "MyTabBarController.h"
#import "LeftSortViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property float autoSizeScaleX;
@property float autoSizeScaleY;
@property (nonatomic, strong) RootNavigationController * mainNC;
@property (nonatomic, strong) MyTabBarController * mytabbar;
@property (nonatomic, strong) LeftSlideViewController * leftSlideVC;
@property (nonatomic, strong) LeftSortViewController * leftSoutVC;
@end

