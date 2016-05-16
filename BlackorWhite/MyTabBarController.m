//
//  MyTabBarController.m
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import "MyTabBarController.h"
#import "MessageController.h"
#import "ActivityController.h"
#import "LinkmanController.h"
#import "MainViewController.h"
@interface MyTabBarController ()<UITabBarControllerDelegate>

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate=self;
    MainViewController * mainVC = [[MainViewController alloc]init];
    self.mainNC = [[RootNavigationController alloc]initWithRootViewController:mainVC];
    LinkmanController *linkmanVC=[[LinkmanController alloc]init];
    self.LinkmanNC=[[RootNavigationController alloc]initWithRootViewController:linkmanVC];
    ActivityController *activityVC=[[ActivityController alloc]init];
    self.ActivityNC =[[RootNavigationController alloc]initWithRootViewController:activityVC];
    NSArray * NC=@[self.mainNC,self.LinkmanNC,self.ActivityNC];
    for (int i=0; i<3; i++) {
        UINavigationController * Navigation=NC[i];
        [Navigation.navigationBar setBarTintColor:[UIColor colorWithRed:227/255.0   green:143/255.0 blue:23/255.0 alpha:1.000]];
        [Navigation.navigationBar setBackgroundImage:[UIImage imageNamed:@"beijing"] forBarMetrics:UIBarMetricsDefault];
        [Navigation.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        [Navigation.navigationBar setTintColor:[UIColor whiteColor]];
        //设置导航栏的字体大小和颜色
        [Navigation.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    }
    //将四个页面关联到tabbar上
    [self setViewControllers:NC];
    //设置每个页面的标题
    NSArray * Title_Array=@[@"消息",@"联系人",@"动态"];
    NSArray *Image_Array=@[@"bar0",@"bar1",@"bar2"
                           ];
    NSArray *SelectedImage_Array=@[@"selected0",@"selected1",@"selected2"
                           ];
    for (int i=0; i<3; i++) {
        [self.tabBar.items[i] setTitle:Title_Array[i]];
        [self.tabBar.items[i] setImage:[UIImage imageNamed:Image_Array[i]]];
        UIImage *selectedimage=[[UIImage imageNamed:SelectedImage_Array[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        [self.tabBar.items[i] setSelectedImage:selectedimage];
    }
    //imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"%lu",viewController.tabBarController.selectedIndex);
    self.tabbartag=[NSString stringWithFormat:@"%lu",viewController.tabBarController.selectedIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
