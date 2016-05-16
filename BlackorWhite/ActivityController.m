//
//  ActivityController.m
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import "ActivityController.h"
#import "RootNavigationController.h"
#import "AppDelegate.h"
@interface ActivityController ()

@end

@implementation ActivityController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    rootNC.segmentControl.hidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"动态"];
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 35, 35);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];

    UIButton *Righebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Righebutton.frame = CGRectMake(0, 0, 50, 18);
    [Righebutton setTitle:@"更多" forState:0];
    Righebutton.titleLabel.font=[UIFont systemFontOfSize:18];
    [Righebutton setTitleColor:[UIColor colorWithRed:30 / 256.0 green:185 / 256.0 blue:230 / 256.0 alpha:1] forState:0];
    //    [Righebutton setBackgroundImage:[UIImage imageNamed:@"rightbutton"] forState:UIControlStateNormal];
    //    [Righebutton addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Righebutton];
    
}

- (void) openOrCloseLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.leftSlideVC.closed){
        [tempAppDelegate.leftSlideVC openLeftView];
    }
    else{
        [tempAppDelegate.leftSlideVC closeLeftView];
    }
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
