//
//  MainViewController.m
//  DrawerDemo
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//
#define MENU_POPOVER_FRAME  CGRectMake(self.view.frame.size.width/2+10, 3, 145, 240)
#import "MainViewController.h"
#import "AppDelegate.h"
#import "RootNavigationController.h"
#import "MessageController.h"
#import "LeftSortViewController.h"
#import "MLKMenuPopover.h"
#import "MainTableViewCell.h"
#import "PellTableViewSelect.h"
@interface MainViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,MLKMenuPopoverDelegate>
{
    NSString *str;
    UISearchBar *SearchBar;
}
@property(nonatomic,strong) MLKMenuPopover *menuPopover;
@property(nonatomic,strong) NSArray *menuItems;
@end

@implementation MainViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuItems = [NSArray arrayWithObjects:@"扫一扫", @"加好友", @"创建讨论组", @"发送到电脑",@"面对面快传", @"收钱",nil];
    
    RootNavigationController * rootNC = (RootNavigationController *)self.navigationController;
    [rootNC.segmentControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = MYCGRect(0, 0, 35, 35);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIButton *Righebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Righebutton.frame = MYCGRect(0, 0, 20, 18);
    [Righebutton setBackgroundImage:[UIImage imageNamed:@"rightbutton"] forState:UIControlStateNormal];
    [Righebutton addTarget:self action:@selector(rightmenu:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Righebutton];
    
    UIView *Headview=[[UIView alloc]initWithFrame:MYCGRect(0, 0, self.view.frame.size.width, 50)];
    [Headview setBackgroundColor:[UIColor whiteColor]];
    [Headview setUserInteractionEnabled:YES];
    //设置搜索框
    SearchBar = [[UISearchBar alloc] init];
    SearchBar.delegate = self;
    SearchBar.frame = MYCGRect(10, 3, 300, 30);
    SearchBar.tintColor =[UIColor whiteColor];
    [SearchBar setBackgroundColor:[UIColor whiteColor]];
    [SearchBar setBarTintColor:[UIColor whiteColor]];
    [SearchBar setSearchBarStyle:UISearchBarStyleMinimal];
    [SearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchbar_inputbox"] forState:0];
    [SearchBar setScopeBarButtonBackgroundImage:[UIImage imageNamed:@"searchbar_inputbox"] forState:0];
    SearchBar.placeholder = @"搜索";
    [Headview addSubview:SearchBar];
    //添加tableview
    self.tableView = [[UITableView alloc]initWithFrame:MYCGRect(0, 0, 320, 568) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView setTableHeaderView:Headview];
    [self.view addSubview:self.tableView];

    
}
-(void)Returnmain{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC closeLeftView];
}

- (void)segmentAction:(UISegmentedControl *)seg{
    NSLog(@"======%ld",seg.selectedSegmentIndex);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     AppDelegate * app = [[UIApplication sharedApplication] delegate];
    return 60*app.autoSizeScaleY;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"cell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
//    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
//    cell.backgroundColor = [UIColor clearColor];
//    cell.textLabel.textColor = [UIColor blackColor];
//    [cell.imageView setImage:[UIImage imageNamed:@"head"]];
//    cell.textLabel.text = @"测试数据";
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    str=[NSString stringWithFormat:@"%ld",(long)indexPath.row];
    NSLog(@"点击了第%ld行",indexPath.row + 1);
    MessageController *message=[[MessageController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}

- (void) openOrCloseLeftList{
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    if (tempAppDelegate.leftSlideVC.closed){
        LeftSortViewController * leftc=[LeftSortViewController defaultMainViewController];
        leftc.str2=str;
        NSLog(@"%@",str);
        [tempAppDelegate.leftSoutVC.tableView reloadData];
        [tempAppDelegate.leftSlideVC openLeftView];
        
//        [tempAppDelegate.leftSlideVC.leftVC removeFromParentViewController];
    }
    else{
        [tempAppDelegate.leftSlideVC closeLeftView];
        [tempAppDelegate.leftSlideVC.leftVC removeFromParentViewController];

    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.leftSlideVC setPanEnabled:YES];
}


-(void)rightmenu:(UIButton *)sender{
    // Hide already showing popover
    if (self.menuPopover.buttontag.intValue) {
       [self.menuPopover dismissMenuPopover];
        self.menuPopover.buttontag=@"0";
    }else{
        [self.menuPopover dismissMenuPopover];

        self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:MENU_POPOVER_FRAME menuItems:self.menuItems];
        
        self.menuPopover.menuPopoverDelegate = self;
        [self.menuPopover showInView:self.view];
        self.menuPopover.buttontag=@"1";
    }
    
//    // 弹出QQ的自定义视图
//    [PellTableViewSelect addPellTableViewSelectWithWindowFrame:MYCGRect(20, 64, 150, 200) selectData:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] images:@[@"right0",@"right1",@"right2",@"right3",@"right4",@"right5"] action:^(NSInteger index) {
//        NSLog(@"选择%ld",index);
//    } animated:YES];
    
    
}
#pragma mark -
#pragma mark MLKMenuPopoverDelegate

- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex
{
    [self.menuPopover dismissMenuPopover];
    
    NSString *title = [NSString stringWithFormat:@"%@ selected.",[self.menuItems objectAtIndex:selectedIndex]];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alertView show];
}

CG_INLINE CGRect
MYCGRect(CGFloat x,CGFloat y,CGFloat width,CGFloat height){
    AppDelegate * app = [[UIApplication sharedApplication] delegate];
    
    
    CGRect rect;
    rect.origin.x = x * app.autoSizeScaleX;
    rect.origin.y = y * app.autoSizeScaleY;
    rect.size.width = width * app.autoSizeScaleX;
    
    rect.size.height = height * app.autoSizeScaleY;
    
    return rect;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
