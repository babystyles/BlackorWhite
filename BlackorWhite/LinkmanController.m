//
//  LinkmanController.m
//  BlackorWhite
//
//  Created by 林泽琛 on 15/12/27.
//  Copyright © 2015年 林泽琛. All rights reserved.
//

#import "LinkmanController.h"
#import "RootNavigationController.h"
#import "AppDelegate.h"
#import "MainTableViewCell.h"
#import "ZJSingle.h"
#import "ZJSpreadCell.h"
@interface LinkmanController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,ZJSpreadCellDelegate>
{
     UISearchBar *SearchBar;
}
@property (nonatomic, strong) NSArray             *dataArray;
@end

@implementation LinkmanController


- (NSArray *)dataArray{
    if (!_dataArray) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"test.plist" ofType:nil];
        NSMutableArray *testArray = [[NSMutableArray alloc] initWithContentsOfFile:path];
        
        // 大的字典转成大的模型
        NSMutableArray *tempArray = [NSMutableArray array];
        for (int i = 0; i < testArray.count; i++)
        {
            ZJSingle *single = [ZJSingle singleWithDict:testArray[i]];
            
            // 添加到临时数组
            [tempArray addObject:single];
        }
        _dataArray = tempArray;
    }
    return  _dataArray;
}

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
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    [self.navigationItem setTitle:@"联系人"];
    
    UIButton *menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    menuBtn.frame = CGRectMake(0, 0, 35, 35);
    [menuBtn setBackgroundImage:[UIImage imageNamed:@"head"] forState:UIControlStateNormal];
    [menuBtn addTarget:self action:@selector(openOrCloseLeftList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:menuBtn];
    
    UIButton *Righebutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Righebutton.frame = CGRectMake(0, 0, 50, 18);
    [Righebutton setTitle:@"添加" forState:0];
    Righebutton.titleLabel.font=[UIFont systemFontOfSize:18];
    [Righebutton setTitleColor:[UIColor colorWithRed:30 / 256.0 green:185 / 256.0 blue:230 / 256.0 alpha:1] forState:0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:Righebutton];
    
    
//    UIView *Headview=[[UIView alloc]initWithFrame:MYCGRect(0, 0, self.view.frame.size.width, 50)];
//    [Headview setBackgroundColor:[UIColor whiteColor]];
//    [Headview setUserInteractionEnabled:YES];
//    //设置搜索框
//    SearchBar = [[UISearchBar alloc] init];
//    SearchBar.delegate = self;
//    SearchBar.frame = MYCGRect(10, 3, 300, 30);
//    SearchBar.tintColor =[UIColor whiteColor];
//    [SearchBar setBackgroundColor:[UIColor whiteColor]];
//    [SearchBar setBarTintColor:[UIColor whiteColor]];
//    [SearchBar setSearchBarStyle:UISearchBarStyleMinimal];
//    [SearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"searchbar_inputbox"] forState:0];
//    [SearchBar setScopeBarButtonBackgroundImage:[UIImage imageNamed:@"searchbar_inputbox"] forState:0];
//    SearchBar.placeholder = @"搜索";
//    [Headview addSubview:SearchBar];
//    //添加tableview
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    [self.tableView setTableHeaderView:Headview];
//    [self.view addSubview:self.tableView];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
//        [self.tableView setTableHeaderView:Headview];
        [self.view addSubview:self.tableView];
    
}


#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ZJSpreadCell *cell;
    static NSString *ID = @"ZJSpreadCell";
    cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ZJSpreadCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.delegate = self;
        
        //设置cell点击无任何效果和背景色
        //        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    ZJSingle *single = self.dataArray[indexPath.row];
    
    cell.nameLable.text = single.title;
    cell.nameArray = single.name;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJSingle *single = self.dataArray[indexPath.row];
    
    if (single.opened) {
        return (single.name.count + 1) * 44;
    }
    return 44;
}

- ( CGFloat )tableView:( UITableView *)tableView heightForHeaderInSection:( NSInteger )section
{
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZJSingle *single = self.dataArray[indexPath.row];
    single.opened = !single.opened;
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    /**设置图片箭头旋转*/
    ZJSpreadCell *cell = (ZJSpreadCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell setArrowImageViewWhitIfUnfold:single.opened];
    
    [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -- ZJSpreadCellDelegate
-(void)ZJSpreadCellDidSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击cell要做的事情");
    
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
