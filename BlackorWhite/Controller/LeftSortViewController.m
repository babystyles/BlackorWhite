//
//  LeftSortViewController.m
//  Touch
//
//  Created by lanou3g on 15/12/14.
//  Copyright © 2015年 syx. All rights reserved.
//

#import "LeftSortViewController.h"
#import "AppDelegate.h"
#import "OtherViewController.h"

@interface LeftSortViewController ()<UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate>{
    UIView * _headView;
    UIImageView *topview;
    UILabel * nameLabel;
    UILabel * temperlabel;
    UILabel * placelabel;
}

@end

@implementation LeftSortViewController

-(void)viewWillAppear:(BOOL)animated{
//    [self viewWillAppear:animated];
    NSLog(@"sssss");
    [self.tableView reloadData];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackImage"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
}
+ (instancetype)defaultMainViewController{
    static LeftSortViewController *defaultLeftVC = nil;
    if (!defaultLeftVC) {
        defaultLeftVC = [[LeftSortViewController alloc] init];
    }
    return defaultLeftVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:12/255.0 green:168/255.0 blue:247/255.0 alpha:0.85]];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"topback"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    
    //获取通知中心单例对象
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
    [center addObserver:self selector:@selector(notices:) name:@"123" object:nil];
    
    [self setupUI];
    
}

//CG_INLINE CGRect CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
// 
//    return rect;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.textLabel.font = [UIFont systemFontOfSize:18];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"开通会员";
        cell.imageView.image = [UIImage imageNamed:@"vip_shadow"];
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"QQ钱包";
        cell.imageView.image = [UIImage imageNamed:@"sidebar_purse"];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"个性装扮";
        cell.imageView.image = [UIImage imageNamed:@"sidebar_decoration"];
    } else if (indexPath.row == 3){
        cell.textLabel.text = @"我的收藏";
        cell.imageView.image = [UIImage imageNamed:@"sidebar_favorit"];
    }else if (indexPath.row == 4){
        cell.textLabel.text = @"我的相册";
        cell.imageView.image = [UIImage imageNamed:@"sidebar_album"];
    }else if (indexPath.row == 5){
        cell.textLabel.text = @"我的文件";
        cell.imageView.image = [UIImage imageNamed:@"sidebar_file"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    OtherViewController *vc = [[OtherViewController alloc] init];
    [vc setHidesBottomBarWhenPushed:YES];
    [tempAppDelegate.leftSlideVC closeLeftView];//关闭左侧抽屉
//    [self.navigationController pushViewController:vc animated:YES];
//    tempAppDelegate.mytabbar.delegate=self;
//    NSLog(@"%lu",tempAppDelegate.mytabbar.tabBarController.selectedIndex);
    switch ([tempAppDelegate.mytabbar.tabbartag intValue]) {
        case 0:
        [tempAppDelegate.mytabbar.mainNC pushViewController:vc animated:NO];
            break;
        case 1:
            [tempAppDelegate.mytabbar.LinkmanNC pushViewController:vc animated:NO];
            break;
        case 2:
            [tempAppDelegate.mytabbar.ActivityNC pushViewController:vc animated:NO];
            break;
        default:
            break;
    }
//    [tempAppDelegate.mytabbar.mainNC pushViewController:vc animated:NO];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (void)setupUI{
    
    if (IPHONE4) {
        UITableView * tableView = [[UITableView alloc]init];
        self.tableView = tableView;
        tableView.frame = MYCGRect(0, 150, 320,230);
        tableView.delegate = self;
        tableView.dataSource = self;
        [tableView setBackgroundColor:[UIColor colorWithRed:11/255.0 green:168/255.0 blue:247/255.0 alpha:0]];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.view addSubview:tableView];
        
        _headView = [[UIView alloc]initWithFrame:MYCGRect(0, 0, 320, 150)];
        
        _headView.backgroundColor = [UIColor whiteColor];
        //    self.tableView.tableHeaderView = _headView;
        topview =[[UIImageView alloc]initWithFrame:MYCGRect(0, 0,320, 160)];
        [topview setUserInteractionEnabled:YES];
        UIImage *image1=[UIImage imageNamed:@"sidebar_bg"];
        
        
        [topview setImage:image1];
        //    [topview setContentMode:UIViewContentModeScaleAspectFit];
        
        [self.view addSubview:topview];
        
        //    [topview addSubview:tableView];
        
        UIImageView * headImageView = [[UIImageView alloc]initWithFrame:MYCGRect(15, 0, 50, 50)];
        headImageView.backgroundColor = [UIColor yellowColor];
        headImageView.layer.cornerRadius = headImageView.frame.size.width / 2;
        headImageView.clipsToBounds = YES;
        [topview addSubview:headImageView];
        
        nameLabel = [[UILabel alloc]initWithFrame:MYCGRect(80, 0, 240, 20)];
        nameLabel.text = @"ssss";
        nameLabel.font = [UIFont systemFontOfSize:22];
        [topview addSubview:nameLabel];
        
        UIImageView * sunImage = [[UIImageView alloc]initWithFrame:MYCGRect(80, 30, 20, 20)];
        sunImage.image = [UIImage imageNamed:@"SUN"];
        [topview addSubview:sunImage];
        
        UIImageView * sunImage1 = [[UIImageView alloc]initWithFrame:MYCGRect(100, 30, 20, 20)];
        sunImage1.image = [UIImage imageNamed:@"SUN"];
        [topview addSubview:sunImage1];
        
        //    UIImageView * sunImage2 = [[UIImageView alloc]initWithFrame:MYCGRect(140, 30, 20, 20)];
        //    sunImage2.image = [UIImage imageNamed:@"MOON"];
        //    [topview addSubview:sunImage2];
        
        UILabel * label = [[UILabel alloc]initWithFrame:MYCGRect(5, 60, 320, 20)];
        label.text = @"“ 编辑个性签名";
        label.textColor = [UIColor grayColor];
        [topview addSubview:label];
        
        UIImageView * settingImage = [[UIImageView alloc]initWithFrame:MYCGRect(20, 390, 15, 15)];
        settingImage.image = [UIImage imageNamed:@"sidebar_setting"];
        [self.view addSubview:settingImage];
        
        UIButton * settingbutton=[UIButton buttonWithType:UIButtonTypeSystem];
        [settingbutton setFrame:MYCGRect(35, 390,40,15)];
        [settingbutton setTitle:@"设置" forState:0];
        [settingbutton setTitleColor:[UIColor whiteColor] forState:0];
        settingbutton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        [self.view addSubview:settingbutton];
        
        UIImageView * modeImage = [[UIImageView alloc]initWithFrame:MYCGRect(100, 390, 15, 15)];
        modeImage.image = [UIImage imageNamed:@"sidebar_nightmode_off"];
        [self.view addSubview:modeImage];
        
        UIButton * modebutton=[UIButton buttonWithType:UIButtonTypeSystem];
        [modebutton setFrame:MYCGRect(115, 390,40,15)];
        [modebutton setTitle:@"夜间" forState:0];
        [modebutton setTitleColor:[UIColor whiteColor] forState:0];
        modebutton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        [self.view addSubview:modebutton];
        
        UIButton * weatherbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        [weatherbutton setFrame:MYCGRect(200, 335,50,70)];
        //    [weatherbutton setBackgroundColor:[UIColor redColor]];
        //    [weatherbutton setTitle:@"夜间" forState:0];
        //    weatherbutton.titleLabel.textAlignment = UITextAlignmentCenter;
        //    weatherbutton.titleLabel.numberOfLines = 0;
        //    NSString *str = @"11° 厦门";
        //    weatherbutton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
        //    [weatherbutton setTitle:str forState:UIControlStateNormal];
        [weatherbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        weatherbutton.titleLabel.font=[UIFont boldSystemFontOfSize:12];
        [weatherbutton addTarget:self action:@selector(WeatherAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:weatherbutton];
        
        temperlabel = [[UILabel alloc]initWithFrame:MYCGRect(0,20, 40, 30)];
        temperlabel.text = @"9°";
        [temperlabel setFont:[UIFont boldSystemFontOfSize:25]];
        [temperlabel setTextAlignment:2];
        [temperlabel setUserInteractionEnabled:NO];
        temperlabel.textColor = [UIColor whiteColor];
        [weatherbutton addSubview:temperlabel];
        
        placelabel = [[UILabel alloc]initWithFrame:MYCGRect(0, 42, 40, 40)];
        placelabel.text = @"厦门";
        [placelabel setFont:[UIFont boldSystemFontOfSize:15]];
        [placelabel setTextAlignment:1];
        [placelabel setUserInteractionEnabled:NO];
        placelabel.textColor = [UIColor whiteColor];
        [weatherbutton addSubview:placelabel];
    }else{
        
        
    //iPhone5以上的
    UITableView * tableView = [[UITableView alloc]init];
    self.tableView = tableView;
    tableView.frame = MYCGRect(0, 180, 320,230);
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView setBackgroundColor:[UIColor colorWithRed:11/255.0 green:168/255.0 blue:247/255.0 alpha:0]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.view addSubview:tableView];
    
    _headView = [[UIView alloc]initWithFrame:MYCGRect(0, 0, 320, 150)];
    
    _headView.backgroundColor = [UIColor whiteColor];
//    self.tableView.tableHeaderView = _headView;
    topview =[[UIImageView alloc]initWithFrame:MYCGRect(0, 0,320, 180)];
    [topview setUserInteractionEnabled:YES];
    UIImage *image1=[UIImage imageNamed:@"sidebar_bg"];
                     
                     
    [topview setImage:image1];
//    [topview setContentMode:UIViewContentModeScaleAspectFit];
    
    [self.view addSubview:topview];
    
//    [topview addSubview:tableView];
    
    UIImageView * headImageView = [[UIImageView alloc]initWithFrame:MYCGRect(15, 0, 50, 50)];
    headImageView.backgroundColor = [UIColor yellowColor];
    headImageView.layer.cornerRadius = headImageView.frame.size.width / 2;
    headImageView.clipsToBounds = YES;
    [topview addSubview:headImageView];
    
    nameLabel = [[UILabel alloc]initWithFrame:MYCGRect(80, 0, 240, 20)];
    nameLabel.text = @"ssss";
    nameLabel.font = [UIFont systemFontOfSize:22];
    [topview addSubview:nameLabel];
    
    UIImageView * sunImage = [[UIImageView alloc]initWithFrame:MYCGRect(80, 30, 20, 20)];
    sunImage.image = [UIImage imageNamed:@"SUN"];
    [topview addSubview:sunImage];
    
    UIImageView * sunImage1 = [[UIImageView alloc]initWithFrame:MYCGRect(100, 30, 20, 20)];
    sunImage1.image = [UIImage imageNamed:@"SUN"];
    [topview addSubview:sunImage1];
    
//    UIImageView * sunImage2 = [[UIImageView alloc]initWithFrame:MYCGRect(140, 30, 20, 20)];
//    sunImage2.image = [UIImage imageNamed:@"MOON"];
//    [topview addSubview:sunImage2];
    
    UILabel * label = [[UILabel alloc]initWithFrame:MYCGRect(5, 80, 320, 20)];
    label.text = @"“ 编辑个性签名";
    label.textColor = [UIColor grayColor];
    [topview addSubview:label];
 
    UIImageView * settingImage = [[UIImageView alloc]initWithFrame:MYCGRect(20, 473, 15, 15)];
    settingImage.image = [UIImage imageNamed:@"sidebar_setting"];
    [self.view addSubview:settingImage];
    
    UIButton * settingbutton=[UIButton buttonWithType:UIButtonTypeSystem];
    [settingbutton setFrame:MYCGRect(35, 473,40,15)];
    [settingbutton setTitle:@"设置" forState:0];
    [settingbutton setTitleColor:[UIColor whiteColor] forState:0];
    settingbutton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:settingbutton];
    
    UIImageView * modeImage = [[UIImageView alloc]initWithFrame:MYCGRect(100, 473, 15, 15)];
    modeImage.image = [UIImage imageNamed:@"sidebar_nightmode_off"];
    [self.view addSubview:modeImage];
    
    UIButton * modebutton=[UIButton buttonWithType:UIButtonTypeSystem];
    [modebutton setFrame:MYCGRect(115, 473,40,15)];
    [modebutton setTitle:@"夜间" forState:0];
    [modebutton setTitleColor:[UIColor whiteColor] forState:0];
    modebutton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [self.view addSubview:modebutton];
    
    UIButton * weatherbutton=[UIButton buttonWithType:UIButtonTypeCustom];
    [weatherbutton setFrame:MYCGRect(200, 418,50,70)];
//    [weatherbutton setBackgroundColor:[UIColor redColor]];
//    [weatherbutton setTitle:@"夜间" forState:0];
//    weatherbutton.titleLabel.textAlignment = UITextAlignmentCenter;
//    weatherbutton.titleLabel.numberOfLines = 0;
//    NSString *str = @"11° 厦门";
//    weatherbutton.titleLabel.lineBreakMode = UILineBreakModeWordWrap;
//    [weatherbutton setTitle:str forState:UIControlStateNormal];
    [weatherbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    weatherbutton.titleLabel.font=[UIFont boldSystemFontOfSize:15];
    [weatherbutton addTarget:self action:@selector(WeatherAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:weatherbutton];
    
    temperlabel = [[UILabel alloc]initWithFrame:MYCGRect(0,20, 40, 30)];
    temperlabel.text = @"9°";
    [temperlabel setFont:[UIFont boldSystemFontOfSize:30]];
    [temperlabel setTextAlignment:2];
    [temperlabel setUserInteractionEnabled:NO];
    temperlabel.textColor = [UIColor whiteColor];
    [weatherbutton addSubview:temperlabel];
    
    placelabel = [[UILabel alloc]initWithFrame:MYCGRect(0, 42, 40, 40)];
    placelabel.text = @"厦门";
    [placelabel setFont:[UIFont boldSystemFontOfSize:15]];
    [placelabel setTextAlignment:1];
    [placelabel setUserInteractionEnabled:NO];
    placelabel.textColor = [UIColor whiteColor];
    [weatherbutton addSubview:placelabel];
    
//    self.tableView.backgroundColor = [UIColor colorWithRed:12/255.0 green:168/255.0 blue:247/255.0 alpha:0.85];
    
    
//    self.tableView.separatorColor = [UIColor colorWithRed:42/255.0 green:180/255.0 blue:244/255.0 alpha:0.8];
//    {name = 123; userInfo = {
//        1 = 123;
//    }}
    }
}
-(void)notices:(NSNotification *)sender{
    NSLog(@"222222%@",[sender.userInfo objectForKey:@"1"]);
    nameLabel.text=[sender.userInfo objectForKey:@"1"];
//    NSLog(@"8888");
}

-(void)WeatherAction:(UIButton *)sender{
//    if (sender.selected==YES) {
//        [placelabel setTextColor:[UIColor grayColor]];
//        [temperlabel setTextColor:[UIColor grayColor]];
//        sender.selected=NO;
//    }else{
//        [placelabel setTextColor:[UIColor whiteColor]];
//        [temperlabel setTextColor:[UIColor whiteColor]];
//        sender.selected=YES;
//    }
    
    NSLog(@"hello");
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
