//
//  OtherViewController.m
//  Touch
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import "OtherViewController.h"
#import "RootNavigationController.h"
#import "AppDelegate.h"
#import "LeftSortViewController.h"
#import "LeftSlideViewController.h"
@interface OtherViewController ()

@end

@implementation OtherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = NO;
    //创建一个消息对象
    NSNotification * notices = [NSNotification notificationWithName:@"123" object:nil userInfo:@{@"1":@"123"}];
    //发送消息
    [[NSNotificationCenter defaultCenter]postNotification:notices];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
//    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
//    [rootNC.segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
//    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title=@"钱包";
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 20, 18);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(ReturnLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
}
- (void) ReturnLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC openLeftView];//开启左侧抽屉
    switch ([tempAppDelegate.mytabbar.tabbartag intValue]) {
        case 0:
             [tempAppDelegate.mytabbar.mainNC popViewControllerAnimated:NO];
            break;
        case 1:
             [tempAppDelegate.mytabbar.LinkmanNC popViewControllerAnimated:NO];
            break;
        case 2:
             [tempAppDelegate.mytabbar.ActivityNC popViewControllerAnimated:NO];
            break;
        default:
            break;
    }

}
- (void)segmentAction:(UISegmentedControl *)seg{
    NSLog(@"--------%ld",seg.selectedSegmentIndex);
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
