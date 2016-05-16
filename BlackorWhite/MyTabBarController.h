//
//  MyTabBarController.h
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootNavigationController.h"
@interface MyTabBarController : UITabBarController
@property (nonatomic, strong) RootNavigationController * mainNC;
@property (nonatomic, strong) RootNavigationController * LinkmanNC;
@property (nonatomic, strong) RootNavigationController * ActivityNC;
@property (nonatomic, strong) NSString * tabbartag;
@end
